Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUASLXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUASLXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:23:43 -0500
Received: from ns.sysgo.de ([213.68.67.98]:17036 "EHLO balu.sysgo.de")
	by vger.kernel.org with ESMTP id S264549AbUASLXl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:23:41 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=FCrgen=20Urban?= <jur@sysgo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Lost memory, total memory size is not correct
Date: Mon, 19 Jan 2004 12:22:23 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200401191222.23449.jur@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.21.0.1; VDF: 6.21.0.30; host: balu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to get the amount of total physical memory. I looked at /proc/meminfo 
and found this line (2.4.18):

MemTotal:        30844 kB

But this is not correct the system have 32768 kB Memory. I looked at kernel 
sources and I found the variable max_mapnr. Can I use it to detect the 
correct memory size? It seems that it stores the maximum number of pages 
usable. So I can convert it with macro K() in linux/fs/proc/proc_misc.c to a 
value in kB.

But there are 1924 kB not available (32768 kB - 30844 kB). On system boot I 
get the following message:
Memory: 30780k available (960k kernel code, 392k data, 64k init, 0k highmem)
So I calculated:

1924 kB
-960 kB Kernel
- 392 kB Data
- 64 kB Init
--------------------
508 kB

There are 508 kB lost (?) memory. It seems the boot allocator is reserving 
this memory, but linux doesn't tell for what. I want to know for what the 508 
kB are. Is the kernel stack included in the 508 kB or in the 30844 kB. I 
don't think so, because the value 30844 kB isn't changing after boot. And 
every process should allocate 8 kB kernel stack.

Best Regards
Jürgen Urban

-- 
Jürgen Urban <jur@sysgo.com>
Software Engineer

SYSGO Real-Time Solutions AG
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Telefon: +49-6136-9948-0
FAX: +49-6136-9948-10
www.sysgo.com

