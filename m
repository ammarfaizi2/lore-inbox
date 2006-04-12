Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWDLUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWDLUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWDLUY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:24:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932222AbWDLUY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:24:57 -0400
Date: Wed, 12 Apr 2006 13:23:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Ingo Oeser <netdev@axxeo.de>,
       Denis Vlasenko <vda@ilport.com.ua>, Dave Dillow <dave@thedillows.org>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [RFD][PATCH] typhoon and core sample for folding away VLAN
 stuff
Message-ID: <20060412132322.7786111b@localhost.localdomain>
In-Reply-To: <443D5E9E.80002@candelatech.com>
References: <200604071628.30486.vda@ilport.com.ua>
	<200604111502.52302.vda@ilport.com.ua>
	<200604111517.37215.netdev@axxeo.de>
	<200604122132.46113.ioe-lkml@rameria.de>
	<443D5E9E.80002@candelatech.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 13:10:06 -0700
Ben Greear <greearb@candelatech.com> wrote:

> What is the reasoning for this change?  Is the compiler
> able to optomize the right-hand-side to a constant with your
> change in place?
> 
> > -	if (veth->h_vlan_proto != __constant_htons(ETH_P_8021Q)) {
> > +	if (veth->h_vlan_proto != htons(ETH_P_8021Q)) {
> >  		return -EINVAL;
> >  	}

Read the source, the macro handles it.

For i386:
	htons maps to __cpu_to_be16
	cpu_to_be16 maps to swab16 which is defined in swab.h

#  define __swab16(x) \
(__builtin_constant_p((__u16)(x)) ? \
 ___swab16((x)) : \
 __fswab16((x)))


