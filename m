Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbRE3N2T>; Wed, 30 May 2001 09:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbRE3N2J>; Wed, 30 May 2001 09:28:09 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:54774 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262778AbRE3N1z>; Wed, 30 May 2001 09:27:55 -0400
Message-Id: <l03130301b73a9b647979@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0105300820470.750-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0105292009310.9556-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 30 May 2001 14:27:23 +0100
To: Mike Galbraith <mikeg@wen-online.de>,
        Craig Kulesa <ckulesa@as.arizona.edu>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Plain 2.4.5 VM
Cc: <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The page aging logic does seems fragile as heck.  You never know how
>many folks are aging pages or at what rate.  If aging happens too fast,
>it defeats the garbage identification logic and you rape your cache. If
>aging happens too slowly...... sigh.

Then it sounds like the current algorithm is totally broken and needs
replacement.  If it's impossible to make a system stable by choosing the
right numbers, the system needs changing, not the numbers.  I think that's
pretty much what we're being taught in Control Engineering.  :)

Not having studied the code too closely, it sounds as though there are half
a dozen different "clocks" running for different types of memory, and each
one runs at a different speed and is updated at a different time.
Meanwhile, the paging-out is done on the assumption that all the clocks are
(at least roughly) in sync.  Makes sense, right?  (not!)

I think it's worthwhile to think of the page/buffer caches as having a
working set of their own - if they are being heavily used, they should get
more memory than if they are only lightly used.  The important point to get
right is to ensure that the "clocks" used for each memory area remain in
sync - they don't have to measure real time, just be consistent and fine
granularity.

I'm working on some relatively small changes to vmscan.c which should help
improve the behaviour without upsetting the balance too much.  Watch this
space...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


