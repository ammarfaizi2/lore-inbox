Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUCCKnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUCCKnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:43:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40117 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262428AbUCCKne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:43:34 -0500
Date: Wed, 3 Mar 2004 10:43:32 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modules registering as sysctl handlers
Message-ID: <20040303104332.GR16357@parcelfarce.linux.theplanet.co.uk>
References: <20040302122909.GG24260@mulix.org> <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk> <1078272339.15766.5.camel@bach> <20040303092239.GA31820@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303092239.GA31820@mulix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:22:39AM +0200, Muli Ben-Yehuda wrote:
> > However, an owner field and standard module_get() would solve the case
> > of statically declared ctl_table.
> 
> That's what I had in mind. 
>  
> > I don't know that there's a current user who requires it though?
> 
> Yes, there are. Using the attached scriptlet on a 2.6.1 tree I had
> lying around: 
> 
> [root@hydra kernel]# /tmp/find-register-sysctl 
> /lib/modules/2.6.1/kernel/drivers/cdrom/cdrom.ko uses register_sysctl
> /lib/modules/2.6.1/kernel/drivers/parport/parport.ko uses register_sysctl
> /lib/modules/2.6.1/kernel/net/appletalk/appletalk.ko uses register_sysctl
> /lib/modules/2.6.1/kernel/net/ipx/ipx.ko uses register_sysctl
> /lib/modules/2.6.1/kernel/net/irda/irda.ko uses register_sysctl
> /lib/modules/2.6.1/kernel/net/sctp/sctp.ko uses register_sysctl

	At least parport has both module-wide and per-port sysctls.  The
latter are dynamic even if module support is turned off.  I seriously
suspect that other examples are similar.
