Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135958AbREGBMD>; Sun, 6 May 2001 21:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135955AbREGBLx>; Sun, 6 May 2001 21:11:53 -0400
Received: from [64.165.192.135] ([64.165.192.135]:38161 "EHLO
	server1.skystream.com") by vger.kernel.org with ESMTP
	id <S135958AbREGBLv>; Sun, 6 May 2001 21:11:51 -0400
Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044631@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'bkuschak@yahoo.com'" <bkuschak@yahoo.com>
Subject: kernel BUG at dcache.h:251
Date: Sun, 6 May 2001 18:10:19 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running snmpd or httpd overnight causes this oops: (kernel BUG at
/home/brian/linux/include/linux/dcache.h:251! - in dget() called from
d_alloc())
Occasionally I see: de_put: entry net already free! before the oops.

I've been able to reliably reproduce the problem in 15 minutes by running
this instead:
while /bin/true; do cat /proc/net/* 2>/dev/null > /tmp/junk; done;

The system fails when trying to open /proc/net/tcp, for example, and finds
that net has a zero dentry->d_count.

2.4.3 on a PPC405, with root fs (ext2) on ramdisk.  Any ideas on why this is
happening?  The system is stable otherwise.

Thanks, Brian
(Please CC my email address)

