Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbTFSHux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265733AbTFSHuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 03:50:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265732AbTFSHuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 03:50:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
 Windows!
Date: 19 Jun 2003 01:04:20 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bcrqq4$edi$1@cesium.transmeta.com>
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EF0214A.3000103@aitel.hist.no>
By author:    Helge Hafting <helgehaf@aitel.hist.no>
In newsgroup: linux.dev.kernel
>
> rmoser wrote:
> [...]
> > Ten minutes later I get the brains to run top.  It seems I have about
> > 50 MB in swap, and 54 MB free memory.  So I wait ten minutes more.
> > 
> > No change.
> > 
> > % swapoff -a; swapon -a
> > 
> > Fixes all my problems.
> > 
> > Now this long story shows something:  The kernel appears to be unable
> > to intelligently pull swap back into RAM.  What gives?
> > 
> Because the problem _is_ unsolvable.  You want the kernel
> to go "oh, lots of free memory showed up, lets pull
> everything in from swap just in case someone might need it."
> 
> 
> That would solve _your_ problem.  But lots of other people
> would get another problem - much _more_ swapping:
> 
> Whenever they quit one big app to run another big one,
> everything is pulled in from swap before the next
> big app start.  Then it starts, and push everything out
> again.  The current system lets you quit one app,
> the stuff in swap remains there until someone actually use it,
> and lots of free memory remain in case it is needed.
> 
> The "intelligent" thing is to leave stuff in swap until
> some app needs it, and pull it in then.  Perhaps with
> some read-ahead/clustering to minimize io load.
> 

This is why you pull things in from swap, but keep tabs on the fact
that it's clean against swap and therefore can be culled at will if
you don't need it.  In other words -- it's present *both* in swap and
RAM.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
