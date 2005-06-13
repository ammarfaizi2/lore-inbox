Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVFMX4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVFMX4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFMXyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:54:43 -0400
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:63460 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261500AbVFMXwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:52:17 -0400
X-IronPort-AV: i="3.93,196,1115006400"; 
   d="scan'208"; a="1004645416:sNHT31109864"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: Andi Kleen <ak@muc.de>
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Mon, 13 Jun 2005 19:53:16 +0000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506071836.12076.martin@cs.uga.edu> <200506121529.50259.martin@cs.uga.edu> <20050613100604.GA18976@muc.de>
In-Reply-To: <20050613100604.GA18976@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131953.16958.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 10:06 am, Andi Kleen wrote:
> On Sun, Jun 12, 2005 at 03:29:50PM -0400, Jacob Martin wrote:
> > Hardware memhole mapping never seems to work, or causes lockups right
> > away.  I need to test it further though.
> >
> > I have discovered that with the following features enabled:
> >
> > 1.  Software memhole mapping
> > 2.  Continuous,
> >
> > linux sees the entire 4GB of memory.  However, when things start getting
> > requested from the upper half, there are Oopses generated.  Attached are
> > two Oopses that occurred under the test scenario described.
>
> What happens when you boot with numa=off or with numa=noacpi ?

You got it!  It seems to be working just fine without it compiled into the 
kernel.

> The system seems to believe it has memory in an area not covered
> by mem_map.

I think you hit it right on the head.

I enabled NUMA because I had anticipated upgrading later.  So I guess if you 
don't actually have NUMA set up hardware-wise, and enable this module, then 
you will have problems.

Maybe a simple update to the kernel "K8 NUMA support" Processor feature's help 
section should be made to note this?  Or, is there something that could be 
fixed somewhere.  I wouldn't mind helping, it was baffling me for two weeks.

> > launch big memory apps.
> >
> > I suppose I could write a program to consume/probe the upper memory half.
> > Anyone know of a good/quicky way to do that?
>
> You can use the attached program which I often use for similar purposes.
> It writes nearly all free memory in a loop and also often triggers memory
> problems.

Thanks for that too!

Sincerely,
Jacob Martin


-- 
Jacob Martin
