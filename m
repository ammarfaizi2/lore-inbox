Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUKNEhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUKNEhF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUKNEhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:37:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:60096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261216AbUKNEg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:36:59 -0500
Date: Sat, 13 Nov 2004 20:36:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: ppc: fix up pmac IDE driver for driver core changes
In-Reply-To: <1100399187.20511.137.camel@gaston>
Message-ID: <Pine.LNX.4.58.0411132034340.12386@ppc970.osdl.org>
References: <200411132203.iADM3Lwb004846@hera.kernel.org>
 <1100399187.20511.137.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Nov 2004, Benjamin Herrenschmidt wrote:
> On Sat, 2004-11-13 at 20:53 +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2115, 2004/11/13 12:53:51-08:00, torvalds@ppc970.osdl.org
> > 
> > 	ppc: fix up pmac IDE driver for driver core changes
> > 	
> > 	device power state is in "dev.power.power_state" now, rather than
> > 	in "dev.power_state".
> > 
> 
> Hrm... Missed that core change, where does it come from ?

It's the core "struct device" shrinkage patch:

	ChangeSet@1.2092.3.1, 2004-11-12 11:41:25-08:00, david-b@pacbell.net
	  [PATCH] driver core: shrink struct device a bit
  
	  This patch removes two fields from "struct device" that are duplicated
	  in "struct dev_pm_info":  power_state (which should probably vanish)
	  and "saved_state".  There were only two "real" uses of saved_state;
	  both are now switched over to use dev_pm_info.
  
	  Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
	  Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

so I think the people involved agree with you on moving it ever outwards..

		Linus
