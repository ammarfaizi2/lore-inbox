Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJAQZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJAQZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJAQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:25:47 -0400
Received: from tomts45.bellnexxia.net ([209.226.175.112]:15275 "EHLO
	tomts45-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264795AbUJAQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:24:32 -0400
Reply-To: <ivan.kalatchev@esg.ca>
From: "Ivan Kalatchev" <ivan.kalatchev@esg.ca>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.8 bug in fs/locks.c
Date: Fri, 1 Oct 2004 12:24:30 -0400
Message-ID: <000001c4a7d3$21c62bb0$2e646434@ivans>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Application I'm developing has a web interface, so user can change
configuration file for this application using IE browser e.g.
I'm using pthreads for each user-application connections. To protect
configuration file from corruption I used file locking mechanism - fcntl
with F_WRLCK/F_RDLCK.
 And at one point after posting web page back immediately after browser
received it, I got this in dmesg:

------------[ cut here ]------------
kernel BUG at fs/locks.c:1726!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: hpac cdc_acm ohci_hcd usbcore e100
CPU:    0
EIP:    0060:[<c01555f1>]    Not tainted
EFLAGS: 00010246   (2.6.8)
EIP is at locks_remove_flock+0x69/0xbc
eax: c113d781   ebx: c34ecf4c   ecx: c34eceb0   edx: c1dbff6c
esi: c126f420   edi: c3fd0a40   ebp: c34eceb0   esp: c35b8f84
ds: 007b   es: 007b   ss: 0068
Process hdas (pid: 6875, threadinfo=c35b8000 task=c113d710)
Stack: c126f420 c126f420 c0142d13 c126f420 c126f420 00000007 00000000
bf5ff914
       c3c9ce60 c0142cdf c01513e9 00000009 00000007 00000009 c35b8000
c0105c4b
       00000009 00000007 bf5ff914 00000007 00000009 bf5ff6f4 000000dd
c010007b
Call Trace:
 [<c0142d13>] __fput+0x33/0x104
 [<c0142cdf>] fput+0x13/0x14
 [<c01513e9>] sys_fcntl64+0x69/0x70
 [<c0105c4b>] syscall_call+0x7/0xb
Code: 0f 0b be 06 de 4a 23 c0 89 d3 8b 13 85 d2 75 c7 ba 00 f0 ff

Configuration file was destroyed of course, as I opened it for writing with
truncation.
I'm changing code now to use pthread mutexes to control access to the
configuration file,
hopefully it will work better. So this message more like bug info, but I
would like
to be CC-ed  all answers/comments posted to the list in response to this
posting.

Regards,

_________________________________________________
Ivan Kalatchev

Senior Software Developer
Engineering Seismology Group Canada Inc.
ISO 9001-2000
1 Hyperion Court, Kingston,
Ontarion, Canada K7K 7G3
phone: (613) 548-8287 ext.247
fax:     (613) 548-8917


