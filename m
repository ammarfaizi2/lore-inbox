Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKSJSb>; Mon, 19 Nov 2001 04:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRKSJSW>; Mon, 19 Nov 2001 04:18:22 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:43756 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S275973AbRKSJSQ>; Mon, 19 Nov 2001 04:18:16 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: James A Sutherland <jas88@cam.ac.uk>
To: =?iso-8859-15?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>,
        Dan Maas <dmaas@dcine.com>
Subject: Re: Swap
Date: Mon, 19 Nov 2001 09:18:11 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fa.inl6g6v.1mmbp4@ifi.uio.no> <053d01c1707e$8c941630$1a01a8c0@allyourbase> <3BF839AA.4050508@wanadoo.fr>
In-Reply-To: <3BF839AA.4050508@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E165kZ4-0005I4-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 November 2001 10:43 pm, François Cami wrote:
> Dan Maas wrote:
> > Still, it puzzles me why a system with no swap space would appear to be
> > more responsive than one with swap (assuming their working sets are quite
> > a bit smaller than total amount of RAM)... Can you do a controlled test
> > somehow, to rule out any sort of placebo effect?
>
> It's pretty simple... Try putting as much progs as you can into RAM
> (but less than total RAM size) when you have RAM+swap.
> Switching from one prog to another now takes time, because if you need
> to go e.g. from mozilla to openoffice for example, if openoffice has
> been swapped, it'll take ages.

Except that openoffice and mozilla can be swapped out in BOTH cases: the 
kernel can discard mapped pages and reread as needed, whether you have a swap 
partition or not.

> Another good example is launching X and a few heavy X apps, going back
> to console, doing a few things, like compiling different kernel trees.
> If you have swap, the X + X apps will be swapped. going back to X will
> take ages, because all that data + code has to be moved out to RAM to
> cache the data in the two kernel trees.

Whereas without swapspace, only the read-only mapped pages can be swapped out.

> If you don't have swap, maybe one, or both of the two kernel trees
> will end up being not cached into main memory, depending on how much
> RAM left you have. but going back to X will take 1 second instead of 20,
> and thus the system will be more responsive.

You're trading throughput for responsiveness, here: you save 19 seconds 
switching to/from X, but walking through the two kernel trees will be slowed 
down by more than that amount... By most metrics, keeping X+apps in memory 
and forcing your kernel tree accesses to hit the disk is the WRONG strategy.

(Making X mlock() some or all of itself into RAM might make sense here, 
perhaps?)

> It depends clearly on the situation you're in. I believe running with
> swap is beneficial when your memory load is more than 75% of total
> RAM, and less so when you have a few hundred megs of RAM left with all
> useful apps loaded into RAM (which is not too unlikely these days,
> due to the low price of SD/DDR RAM).

Provided the VM is doing its job properly, adding swap will always be a net 
win for efficiency: the kernel is able to dump unused pages to make more room 
for others. Of course, you tend to "feel" the response times to interactive 
events, rather than the overall throughput, so a change which slows the 
system down but makes it more "responsive" to mouse clicks etc feels like a 
net win...


James.
