Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTLAHnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLAHnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:43:41 -0500
Received: from bluejay.broadware.com ([209.219.63.5]:54656 "EHLO
	bluejay.broadware.com") by vger.kernel.org with ESMTP
	id S261406AbTLAHnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:43:39 -0500
Message-ID: <003c01c3b7de$b2f02090$04740718@vaiors410>
From: "Suman Puthana" <suman@broadware.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Suman Puthana" <suman@broadware.com>
Subject: problem with iowait (disk I/O) in 2.4.21 kernel
Date: Sun, 30 Nov 2003 23:35:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is anybody aware of any changes in the 2.4.21 kernel which affects disk I/O
badly?  We are noticing that the cpu taken up by iowait's is causing
significant degradation in disk performance.

We have an application in which there are multiple processes writing to disk
simultaneously, each process writing anywhere from 16 - 64 K Bytes at a time
and sleeping for about 50 ms depending on how long the write() call takes to
finish. It is important that the write() finishes within 50 ms for this
application. The file's are opened with the open() call with the standard
O_RDWR and O_CREAT flags.

On the 2.4.18 kernel, 25 of these processes take up about 15% of CPU on a
dual Xeon Pentium 4 2.4 GHz processor with 1 MB of memory for a total
throughput of about 7 MBps which is very good.  The write() calls typically
take less than 5 ms to complete and we sleep for the remaining 45 ms or so.

But on the same system when we installed the 2.4.21 kernel, these 25
processes take anywhere between 40 - 70 % of the CPU depending on how  much
CPU the iowait is taking up. The iowait part of it varies all the way from
10 - 60 %. (The iowait CPU is within 1% on the 2.4.18 kernel.).  What is
even worse - sometimes the write() calls take anywhere between 1 - 2
seconds( yes seconds!) to return, which degrades the performance of our
application server pretty badly.

 It happens on all kinds of storage devices so it's definitely not a
hardware problem.(We tested on the standard IDE disk all the way upto the
EMC clariion storage system).

Is this iowait something which was introduced in the 2.4.21 kernel core code
or in the file system driver code? It definitely happens with jfs, reiserfs
and also on ext3 though not as badly . Is there a way to turn it off or to
make it take up lesser CPU?

Any insight or pointers regarding this problem would be greatly
appreciated.  Thank you for your support.

- Suman Puthana

PS - Something else of interest here is that when the iowait part of the CPU
increases, iostat shows a significantly  higher throughput than what we are
actually trying to write to disk. (When sampled over 30 seconds, when we are
trying to write 7 MBps, iostat actually shows 11-12 MBps when iowait goes
upto 30-40 %). It's almost like there's some internal copies going on.



