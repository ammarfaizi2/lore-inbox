Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUGLNRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUGLNRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUGLNRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:17:19 -0400
Received: from web20808.mail.yahoo.com ([216.136.226.197]:2313 "HELO
	web20808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266817AbUGLNRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:17:04 -0400
Message-ID: <20040712131658.22471.qmail@web20808.mail.yahoo.com>
Date: Mon, 12 Jul 2004 06:16:58 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: what is the proper place to use run_task_queue(&tq_disk) in kernel-2.4 ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want help regarding the proper place to use the
run_task_queue(&tq_disk) in linux-2.4.XX. I m working
on a project of caching disk (as I also asked for help
for creating a single RAMDISK of 7GB or more) and now
stuck at a very uncertain position.

I m inplementing it almost like md and raid1, as I
mapped my module on the actual disk and the request
for the data went through my module; in which I decide
that whether the data hav to write or read from
Caching Disk or from Actual Disk depending of the
policy and the bitmap of the Caching Disk. As if some
sectors of the request are present in cache disk and
some hav to brought from the storge, then I create
requests according to the sectors from cache disk and
from storage disk. And then place them in a queue. If
no data is present in cache disk then call
generic_make_request for that buffer_head which I
created. and In the end_io of that bh I look that if
the policy is saying that data hav to be written in
the other disk then again queue the fullfilled request
in a queue and if not then just call the b_end_io of
the original bh then from the thread (deamonized)
which is working in a while(1) loop and in the loop it
looks for the queue that whether it has some request
to fullfill ??? if yes then it fullfills the request
by calling generic_make_request and then calls
run_task_queue(&tq_disk) from the thread.

This is working fine for the Data transfered from HDD
to the Storage through our module using caching. But
when I start copying data from Storage to HDD or from
Storage to Storage after copying 300MB or 400MB Kernel
hangs.

I think this is the problem due to
run_task_queue(&tq_disk) as when I changed its
position or comments it our module becomes tooo slow
............ 

Now what to do ???? Any Idea or suggestion ???
If you are not getting the Idea what I m trying to
explain then do tell me !!! I 'll give my code to
..... but I m not sending the code as you may not hav
much time to go through the coding.

Fawad Lateef


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
