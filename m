Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTHFWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbTHFWy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:54:26 -0400
Received: from mx0.gmx.net ([213.165.64.100]:10318 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261741AbTHFWyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:54:23 -0400
Date: Thu, 7 Aug 2003 00:54:22 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <200308070014.11306.oliver@neukum.org>
Subject: Re: [linux-usb-devel] [2.6.0-test2-bk5] OHCI USB printing call trace...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.107.193.132]
Message-ID: <14118.1060210462@www54.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

Thanks for your response. This is consistently reproducible and the printer
will get to ~20% down the first page before stopping. Just when or after it
stops printing, I observed the system time jump to 61% [2], then some
polling/logging going on, until I turn the printer off or disconnect the cable. This
can be seen again in the logs [1], but we do not observe your additional
debugging. I enabled the additional USB debugging also.

--- [1]
[printer plugged into root hub]
Aug  6 23:42:33 stratum kernel: hub 1-0:0: debounce: port 2: delay 100ms
stable 4 status 0x101
Aug  6 23:42:33 stratum kernel: hub 1-0:0: new USB device on port 2,
assigned address 3
Aug  6 23:42:33 stratum kernel: usb 1-2: Product: USB Printer
Aug  6 23:42:33 stratum kernel: usb 1-2: Manufacturer: EPSON
Aug  6 23:42:33 stratum kernel: usb 1-2: SerialNumber: ABCDE0212160438390
Aug  6 23:42:33 stratum kernel: drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005

[print job started; printer reached 20% down the page and stopped]
Aug  6 23:44:33 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-110 reading printer status
Aug  6 23:44:33 stratum last message repeated 17 times

[printer powered off]
Aug  6 23:44:33 stratum kernel: usb 1-2: USB disconnect, address 3
Aug  6 23:44:33 stratum kernel: ohci-hcd 0000:00:02.2: ed df122080 (#0)
state 2(has tds)
Aug  6 23:44:33 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-108 reading printer status
Aug  6 23:44:37 stratum kernel: drivers/usb/class/usblp.c: usblp0: removed
Aug  6 23:44:37 stratum kernel: Unable to handle kernel paging request at
virtual address d6b990e4
Aug  6 23:44:37 stratum kernel:  printing eip:
Aug  6 23:44:37 stratum kernel: c02c6383
Aug  6 23:44:37 stratum kernel: *pde = 00059067
Aug  6 23:44:37 stratum kernel: *pte = 16b99000
Aug  6 23:44:37 stratum kernel: Oops: 0000 [#1]
Aug  6 23:44:37 stratum kernel: CPU:    0
Aug  6 23:44:37 stratum kernel: EIP:    0060:[<c02c6383>]    Not tainted
Aug  6 23:44:37 stratum kernel: EFLAGS: 00010282
Aug  6 23:44:37 stratum kernel: EIP is at usb_buffer_free+0xd/0x46
Aug  6 23:44:37 stratum kernel: eax: d6b99004   ebx: dda96004   ecx:
df1aa000   edx: d6b70000
Aug  6 23:44:37 stratum kernel: esi: dda96008   edi: dcc6f098   ebp:
d6b71f1c   esp: d6b71f0c
Aug  6 23:44:37 stratum kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 23:44:37 stratum kernel: Process usb (pid: 1257, threadinfo=d6b70000
task=d0fb3000)
Aug  6 23:44:37 stratum kernel: Stack: d6b71f0c dda96004 dda96008 dcc6f098
d6b71f38 c02ddf4d d6b99004 00002000
Aug  6 23:44:37 stratum kernel:        d1370000 11370000 dda96004 d6b71f50
c02de04f dda96004 00000077 d113f004
Aug  6 23:44:37 stratum kernel:        dffe61dc d6b71f70 c016aa7b dcc6f098
d113f004 dd86d004 d113f004 d1045004
Aug  6 23:44:37 stratum kernel: Call Trace:
Aug  6 23:44:37 stratum kernel:  [<c02ddf4d>] usblp_cleanup+0x43/0xa2
Aug  6 23:44:37 stratum kernel:  [<c02de04f>] usblp_release+0x6b/0x6d
Aug  6 23:44:37 stratum kernel:  [<c016aa7b>] __fput+0xb5/0xc4
Aug  6 23:44:37 stratum kernel:  [<c0168c09>] filp_close+0x4b/0x74
Aug  6 23:44:37 stratum kernel:  [<c0168d35>] sys_close+0x103/0x226
Aug  6 23:44:37 stratum kernel:  [<c0169b05>] sys_read+0x3f/0x5d
Aug  6 23:44:37 stratum kernel:  [<c010a07d>] sysenter_past_esp+0x52/0x71
Aug  6 23:44:37 stratum kernel:
Aug  6 23:44:37 stratum kernel: Code: 8b 90 e0 00 00 00 85 d2 74 0e 8b 4a 20
85 c9 74 07 8b 41 18

--- [2]
$ vmstat 1
   procs                      memory      swap          io     system     
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id
 0  0  0      0 195816   9412 130720    0    0   750   115 1197   469 14  6
80
 0  0  0      0 195816   9412 130720    0    0     0     0 1020    48  0  1
99
 1  0  0      0 183144   9416 130840    0    0     0     0 1006   408 56  7
37
 0  1  0      0 183080   9416 130840    0    0     0     0 1970  1993 61  0
39
 1  0  0      0 183080   9424 130840    0    0     0   384 2012  2092  0  8
92
 1  0  0      0 183096   9424 130840    0    0     0     0 2018  2044  0  0
100
 1  0  0      0 183096   9424 130840    0    0     0     0 2004  2026  1  0
99
 1  0  0      0 183096   9424 130840    0    0     0     0 2021  2052  0  0
100
 1  0  0      0 183096   9424 130840    0    0     0     0 2005  2022  0  1
99
 1  0  0      0 183096   9424 130840    0    0     0     0 2020  2041  0  2
98
 1  0  0      0 183096   9432 130840    0    0     0    20 2002  2049  1  5
94
 1  0  0      0 183096   9432 130840    0    0     0     0 2020  2034  0  0
100
 1  0  0      0 183096   9432 130840    0    0     0     0 2003  2032  0  1
99

> > --- [test print job started]
> > 
> > drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status
> received:
> > -2
> > drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
> > [last message repeated 216 times]
> 
> Did it print at all?
> Could you please run this diagnostic patch?
> 
> 	Regards
> 		Oliver
[snip]
> +				printk("Timeout during write to printer.\n");

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

