Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbRCXBj2>; Fri, 23 Mar 2001 20:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbRCXBjT>; Fri, 23 Mar 2001 20:39:19 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:6377 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S131531AbRCXBjK>;
	Fri, 23 Mar 2001 20:39:10 -0500
Message-Id: <l03130314b6e1ab060578@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 01:38:22 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hmm...  "if ( freemem < (size_of_mallocing_process / 20) ) fail_to_allocate;"
>
>Seems like a reasonable soft limit - processes which have already got lots
>of RAM can probably stand not to have that little bit more and can be
>curbed more quickly.  Processes with less probably don't deserve to die and
>furthermore are less likely to be engineered to handle malloc() failure, so
>failure only occurs closer to the mark.  In this scenario OOM killing
>(which is, after all, a last resort) should trigger rarely and simple
>malloc() failure (which userspace apps can cope with more easily) is an
>early-warning and prevention system.

Following up my own post with some action, I hacked 2.4.1's
mm/mmap.c::vm_enough_pages() to include something similar to the above
algorithm.  In fact, it triggers malloc() failure when 1/16th of
current->mm->total_vm would be greater than the sum of the free space and
the potentially-allocated area.

My very quick tests show that my test program (the rogue allocator) now in
fact does encounter a failed malloc() at approx. 475M, instead of being
killed by the OOM handler at approx. 490M.  This is pretty much the desired
behaviour.

If someone would like me to post a patch and have it tested, I'd be happy
to do so.

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


