Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKHS2B>; Thu, 8 Nov 2001 13:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKHS1q>; Thu, 8 Nov 2001 13:27:46 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:26536 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S277509AbRKHS13>; Thu, 8 Nov 2001 13:27:29 -0500
Subject: 2.4.13 infinite loop in all processes
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 08 Nov 2001 10:26:38 -0800
Message-Id: <1005243998.31225.10.camel@heat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The setting: 2-way P-III machine, 2 GB RAM, 1GB swap, ext3 filesystem on
aic7xxx storage.  Kernel 2.4.13 + ext3.  Last night, the load on the
machine went to 45.  I investigated, and saw that every process was
getting equal CPU time, and all CPU time (on both CPUs) was spent in the
kernel.  No process was making much progress.  I could log in to the
machine and execute 'ps' or read from /proc, but I could not write or
read from the disk.  Any attempted disk I/O resulted in dead processes
in the D state.

The physical memory was mostly used up, with 100MB free, 600MB cached,
and 1300MB used.  Swap was completely virgin: not a single byte had been
used.  The load was very normal: a lot of perl scripts reading and
writing over the network to a database.  No oddball mlock activity or
any other out-of-the-ordinary workload.

I left the machine overnight to see if it would sort itself out, but it
did not.  I had to power cycle it.  I upgraded (?) to 2.4.14 + ext3
0.9.15, and will report if the same happens again.

-jwb

