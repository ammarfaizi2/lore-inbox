Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWDLUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWDLUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWDLUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:52:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54230
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932233AbWDLUwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:52:24 -0400
Date: Wed, 12 Apr 2006 13:51:43 -0700 (PDT)
Message-Id: <20060412.135143.29962858.davem@davemloft.net>
To: greearb@candelatech.com
Cc: ioe-lkml@rameria.de, netdev@axxeo.de, vda@ilport.com.ua,
       dave@thedillows.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [RFD][PATCH] typhoon and core sample for folding away VLAN
 stuff
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <443D5E9E.80002@candelatech.com>
References: <200604111517.37215.netdev@axxeo.de>
	<200604122132.46113.ioe-lkml@rameria.de>
	<443D5E9E.80002@candelatech.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>
Date: Wed, 12 Apr 2006 13:10:06 -0700

> What is the reasoning for this change?  Is the compiler
> able to optomize the right-hand-side to a constant with your
> change in place?
> 
> > -	if (veth->h_vlan_proto != __constant_htons(ETH_P_8021Q)) {
> > +	if (veth->h_vlan_proto != htons(ETH_P_8021Q)) {
> >  		return -EINVAL;
> >  	}

As a policy, Ben, we only use __constant_htons() in compile
time initializers of data structures.  Otherwise we use the
normal htons().

That's why.
