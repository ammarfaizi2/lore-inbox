Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUAPS3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUAPS3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:29:07 -0500
Received: from cmsrelay03.mx.net ([165.212.11.112]:43404 "HELO
	cmsrelay03.mx.net") by vger.kernel.org with SMTP id S265736AbUAPS25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:28:57 -0500
X-USANET-Auth: 165.212.8.16    AUTO bradtilley@usa.net uwdvg016.cms.usa.net
Date: Fri, 16 Jan 2004 13:28:51 -0500
From: Brad Tilley <bradtilley@usa.net>
To: <linux-kernel@vger.kernel.org>
Subject: Possible Bug in 2.4.24???
X-Mailer: USANET web-mailer (CM.0402.7.03)
Mime-Version: 1.0
Message-ID: <306iaPsCz6064S16.1074277731@uwdvg016.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running a script that recursively changes permissions on a ftp
directory, I received an error to the term window where the script was
running. I then checked out /var/log/messages and saw the below kernel errors.
The machine was generally unresponsive and had to be physically rebooted at
the power switch. It worked fine upon reboot an fsck ran w/o producing any
error... the script ran fine too. This is a HP XW4100 with a P4, 1.5GB DDR RAM
and two very fast (15,000 RPM), very large (140GB) SCSI HDDs. It had been up
for 9 days (since compiling and installing 2.4.24) and has worked fine until
this point. Could someone tell me if this is or isn't a kernel bug?


Jan 16 11:50:43 athop1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0
return code = 8000002
Jan 16 11:50:43 athop1 kernel: Info fld=0x2cd1bd9, Current sd08:15: sense key
Hardware Error
Jan 16 11:50:43 athop1 kernel: Additional sense indicates Internal target
failure
Jan 16 11:50:43 athop1 kernel:  I/O error: dev 08:15, sector 54128
Jan 16 11:50:43 athop1 kernel: journal-601, buffer write failed
Jan 16 11:50:43 athop1 kernel:  (device sd(8,21))
Jan 16 11:50:43 athop1 kernel: kernel BUG at prints.c:341!
Jan 16 11:50:43 athop1 kernel: invalid operand: 0000
Jan 16 11:50:43 athop1 kernel: CPU:    0
Jan 16 11:50:43 athop1 kernel: EIP:    0010:[<c0189878>]    Tainted: P
Jan 16 11:50:43 athop1 kernel: EFLAGS: 00010282
Jan 16 11:50:43 athop1 kernel: eax: 00000037   ebx: f76db000   ecx: c6478000  
edx: f6d9df7c
Jan 16 11:50:43 athop1 kernel: esi: 000000cc   edi: 00000383   ebp: f76db000  
esp: c6479c3c
Jan 16 11:50:43 athop1 kernel: ds: 0018   es: 0018   ss: 0018
Jan 16 11:50:43 athop1 kernel: Process chgrp (pid: 32201, stackpage=c6479000)
Jan 16 11:50:43 athop1 kernel: Stack: c029c4f4 c0354d60 c0352760 f8b35e24
c0194f5a f76db000 c02a35a0 c6479c70
Jan 16 11:50:43 athop1 kernel:        c226c400 00000386 00200046 00000384
00000000 f2960180 f8b35e68 0000003e
Jan 16 11:50:43 athop1 kernel:        00000034 f76db000 c0195086 f76db000
f8b35e24 00000000 f6e654c0 00000004
Jan 16 11:50:43 athop1 kernel: Call Trace:    [<c0194f5a>] [<c0195086>]
[<c010a8ce>] [<c01957a6>] [<c0199a1a>]
Jan 16 11:50:43 athop1 kernel:   [<c0197e9b>] [<c0197ff7>] [<c01870f8>]
[<c014ef8e>] [<c0154846>] [<c0155adb>]
Jan 16 11:50:43 athop1 kernel:   [<c0182717>] [<c014e856>] [<c014eec0>]
[<c014f02b>] [<c014eec0>] [<c014df7d>]
Jan 16 11:50:43 athop1 kernel:   [<c010910f>]
Jan 16 11:50:43 athop1 kernel:
Jan 16 11:50:43 athop1 kernel: Code: 0f 0b 55 01 07 c5 29 c0 85 db 74 0e 0f b7
43 08 89 04 24 e8
Jan 16 11:51:58 athop1 su(pam_unix)[32281]: session opened for user root by
rbt(uid=500)


