Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRLQO0G>; Mon, 17 Dec 2001 09:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280035AbRLQOZ5>; Mon, 17 Dec 2001 09:25:57 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:7387 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S280029AbRLQOZk>; Mon, 17 Dec 2001 09:25:40 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: modify_ldt returning ENOMEM on highmem machine
Date: Mon, 17 Dec 2001 15:25:35 +0100
Organization: Internet Factory AG
Message-ID: <3C1E005F.E189A18A@internet-factory.de>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1008599138 5307 195.122.142.158 (17 Dec 2001 14:25:38 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 17 Dec 2001 14:25:38 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried posting this before, but apparently it didn't get through to the
list.
The following are the final lines of a strace of a failing mplayer:

[...]
modify_ldt(0x1, 0xbffff85c, 0x10)       = -1 ENOMEM (Cannot allocate
memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

But I have lots of memory available:

[hal@duncan hal]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054355456 1012023296 42332160        0 73637888 522129408
Swap: 542826496  4218880 538607616
MemTotal:      1029644 kB
MemFree:         41340 kB
MemShared:           0 kB
Buffers:         71912 kB
Cached:         505916 kB
SwapCached:       3976 kB
Active:         196216 kB
Inactive:       417156 kB
HighTotal:      131008 kB
HighFree:         2044 kB
LowTotal:       898636 kB
LowFree:         39296 kB
SwapTotal:      530104 kB
SwapFree:       525984 kB

The bug exists with 2.4.16 as well as with 2.4.17-rc1 and 2.4.13-ac8.
Under
ac8, I can work around it by copying something large to /dev/null, which
gets
some buffers freed.  With 2.4.16 and .17-rc1, usually all I can do to
get
mplayer working again is reboot.
After memory fills up again (usually one updatedb is sufficient), the
problem
reappears.

I have been unable to reproduce the problem when I use "mem=896M" or on
a
kernel with highmem support disabled, so I suspect it to be highmem
related.

Holger
