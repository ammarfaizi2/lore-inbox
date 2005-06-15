Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVFOUt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVFOUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVFOUsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:48:13 -0400
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:13705 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261562AbVFOUqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:46:39 -0400
X-IronPort-AV: i="3.93,201,1115006400"; 
   d="scan'208"; a="1199239945:sNHT16510296"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Wed, 15 Jun 2005 20:46:37 +0000
User-Agent: KMail/1.8
References: <200506071836.12076.martin@cs.uga.edu> <200506131953.16958.martin@cs.uga.edu> <20050615195144.GA40993@muc.de>
In-Reply-To: <20050615195144.GA40993@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151646.37632.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 June 2005 03:51 pm, you wrote:
> On Mon, Jun 13, 2005 at 07:53:16PM +0000, Jacob Martin wrote:
> > On Monday 13 June 2005 10:06 am, Andi Kleen wrote:
> > > On Sun, Jun 12, 2005 at 03:29:50PM -0400, Jacob Martin wrote:
> > > > Hardware memhole mapping never seems to work, or causes lockups right
> > > > away.  I need to test it further though.
> > > >
> > > > I have discovered that with the following features enabled:
> > > >
> > > > 1.  Software memhole mapping
> > > > 2.  Continuous,
> > > >
> > > > linux sees the entire 4GB of memory.  However, when things start
> > > > getting requested from the upper half, there are Oopses generated. 
> > > > Attached are two Oopses that occurred under the test scenario
> > > > described.
> > >
> > > What happens when you boot with numa=off or with numa=noacpi ?
> >
> > You got it!  It seems to be working just fine without it compiled into
> > the kernel.
>
> Not compiled what in the kernel? I just wanted you to boot
> the kernel with these options.

I took NUMA support out of the kernel.  I will recompile NUMA in and reboot 
with the options.  I'm very stable now without NUMA in the kernel.

> > > The system seems to believe it has memory in an area not covered
> > > by mem_map.
> >
> > I think you hit it right on the head.
> >
> > I enabled NUMA because I had anticipated upgrading later.  So I guess if
> > you don't actually have NUMA set up hardware-wise, and enable this
> > module, then you will have problems.
>
> No, it should work fine in theory.

Hmm, ok I'll work with you to try and verify that what happened really 
happened because of NUMA.

> > Maybe a simple update to the kernel "K8 NUMA support" Processor feature's
> > help section should be made to note this?  Or, is there something that
> > could be fixed somewhere.  I wouldn't mind helping, it was baffling me
> > for two weeks.
>
> It is something that must be either fixed or workarounded (if it's a bug
> in your BIOS, which is quite possible)
>
> Can you send me the full dmesg from a numa boot again?

Yes, I'll send it to you as soon as this experiment I am running finishes 
(unless you know how to sleep a process to disk for reenactment after boot?).
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Jacob Martin
