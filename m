Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRCYSg7>; Sun, 25 Mar 2001 13:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132153AbRCYSgu>; Sun, 25 Mar 2001 13:36:50 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:56962 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S132151AbRCYSgp>; Sun, 25 Mar 2001 13:36:45 -0500
Message-Id: <l03130325b6e3e9bdf18e@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0103252041470.551-100000@mikeg.weiden.de>
In-Reply-To: <l0313031db6e2def84b96@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 19:35:38 +0100
To: Mike Galbraith <mikeg@wen-online.de>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My patch already fixes OOM problems caused by overgrown caches/buffers, by
>> making sure OOM is not triggered until these buffers have been cannibalised
>> down to freepages.high.  If balancing problems still exist, then they
>> should be retuned with my patch (or something very like it) in hand, to
>> separate one problem from the other.  AFAIK, balancing should now be a
>> performance issue rather than a stability issue.
>
>Great.  I haven't seen your patch yet as my gateway ate it's very last
>disk.  I look forward to reading it.

I'm currently investigating the old non-overcommit patch, which (apart from
needing manual applying to recent kernels) appears to be rather broken in a
trivial way.  It prevents allocation if total reserved memory is greater
than the total unallocated memory.  Let me say that again, a different way
- it prevents memory usage from exceeding 50%...

Is there a fast way of getting total VM size?  Eg. equivalent to the
following code:

si_meminfo(&i);
si_swapinfo(&i);
free = i.totalram + i.totalswap;

If not, I have to do some jiggery to keep good performance along with true
non-overcommittance.

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


