Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbTBVRax>; Sat, 22 Feb 2003 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267259AbTBVRax>; Sat, 22 Feb 2003 12:30:53 -0500
Received: from bitmover.com ([192.132.92.2]:679 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267257AbTBVRaw>;
	Sat, 22 Feb 2003 12:30:52 -0500
Date: Sat, 22 Feb 2003 09:40:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: system time/2.4.18-3smp/3ware
Message-ID: <20030222174056.GB13246@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is watching 3 drives being tar-ed | wc -c in parallel (I suspect
a bad drive, trying to narrow it down).  The machine is a dual 1.6ghz
Athlon, Tyan motherboard, 2GB of ram.  

I'm a little surprised at the system time - yeah, 72MB/sec is a far amount
of I/O but should we really be eating up that much system time?

load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
3.16  11M 1.4G   0   74M  2.4K   0   0   0   0    0    0  1.3K  46K   0  92 108
3.23  11M 1.4G   0   71M  2.4K   0   0   0   0    0    0  1.3K  45K   1  88 111
3.29  11M 1.4G   0   72M  2.4K   0   0   0   0    0    0  1.2K  46K   2 105  93
3.35  11M 1.4G   0   73M  3.2K   0   0   0   0    0    0  1.2K  45K   1 100  99
3.32  11M 1.4G   0   74M  2.4K   0   0   0   0    0    0  1.2K  45K   1  98 101
3.53  11M 1.4G   0   74M   65K   0   0   0   0    0    0  1.3K  46K   4 103  93

I thought maybe it was the | wc -c (notice the context switches/sec) so I 
tried it with a cpio into /dev/null (tar neatly "optimizes" out any I/O
when you are going to /dev/null, I really hate that) and it was still high

load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
0.78  12M 1.4G   0   66M   34K   0   0   0   0    0    0  945  2.0K   6  82 112
0.96  11M 1.4G   0   66M  2.4K   0   0   0   0  1.0  1.0  964  2.1K   6  79 115
1.12  11M 1.4G   0   66M  2.4K   0   0   0   0    0    0  1.0K 2.3K   7  82 111
1.27  11M 1.4G   0   66M  2.4K   0   0   0   0    0    0  972  2.1K   4  80 116
1.41  11M 1.4G   0   67M  2.4K   0   0   0   0    0    0  960  2.1K   5  87 108
1.62  11M 1.4G   0   67M  2.4K   0   0   0   0    0    0  1.0K 2.3K   7  83 110
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
