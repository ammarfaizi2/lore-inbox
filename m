Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVIGDqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIGDqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 23:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIGDqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 23:46:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63176 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750792AbVIGDqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 23:46:14 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Daniel Phillips <phillips@istop.com>,
       Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <431E497A.4080303@rtr.ca>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <58d0dbf10509061005358dce91@mail.gmail.com> <dfkjav$lmd$1@sea.gmane.org>
	 <200509061819.45567.phillips@istop.com>  <431E497A.4080303@rtr.ca>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 23:46:10 -0400
Message-Id: <1126064771.13159.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 21:59 -0400, Mark Lord wrote:
> Daniel Phillips wrote:
> > There are only two stacks involved, the normal kernel stack and your new ndis 
> > stack.  You save ESP of the kernel stack at the base of the ndis stack.  When 
> > the Windows code calls your api, you get the ndis ESP, load the kernel ESP 
> > from the base of the ndis stack, push the ndis ESP so you can get back to the 
> > ndis code later, and continue on your merry way.
> 
> With CONFIG_PREEMPT, this will still cause trouble due to lack
> of "current" task info on the NDIS stack.
> 
> One option is to copy (duplicate) the bottom-of-stack info when
> switching to the NDIS stack.
> 
> Another option is to stick a Mutex around any use of the NDIS stack
> when calling into the foreign driver (might be done like this already??),
> which will prevent PREEMPTion during the call.

Isn't it bad to rely on taking a lock disabling preemption as a side
effect?  For example it will break on PREEMPT_RT (not merged yet, but
still...).  If you really just need preemption disabled/reenabled can't
you just do it explicitly?

Lee

