Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272517AbTHFVVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTHFVVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:21:46 -0400
Received: from mx0.gmx.de ([213.165.64.100]:60840 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S272517AbTHFVVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:21:37 -0400
Date: Wed, 6 Aug 2003 23:21:35 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [2.6.0-test2-bk5] OHCI USB printing call trace...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.107.193.132]
Message-ID: <23720.1060204895@www67.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I started a test print job, on my SiS OHCI USB controller system, I ran
into problems. Let me know if any further information is needed - this
kernel includes Greg's recent updates I believe (from Neukum, Bellucci, Brownell,
Stern).

Kernel is 2.6.0-test2-bk5.

--- [Epson C62 connected]

hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt
0 proto 2 vid 0x04B8 pid 0x0005

--- [test print job started]

drivers/usb/class/usblp.c: usblp0: nonzero read/write bulk status received:
-2
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
[last message repeated 216 times]

--- [unplug printer]

usb 2-1: USB disconnect, address 3
ohci-hcd 0000:00:02.3: ed dec62000 (#0) state 2(has tds)
drivers/usb/class/usblp.c: usblp0: error -108 reading printer status
drivers/usb/class/usblp.c: usblp0: removed
Unable to handle kernel paging request at virtual address dee7b0e4
 printing eip:
c02b6a6a
*pde = 0007a067
*pte = 1ee7b000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02b6a6a>]    Not tainted
EFLAGS: 00210282
EIP is at usb_buffer_free+0xd/0x46
eax: dee7b004   ebx: ded75004   ecx: c04adc54   edx: c03fa3b8
esi: ded75008   edi: d8c5b098   ebp: dcbedf1c   esp: dcbedf0c
ds: 007b   es: 007b   ss: 0068
Process usb (pid: 2128, threadinfo=dcbec000 task=c6f89000)
Stack: dcbedf0c ded75004 ded75008 d8c5b098 dcbedf38 c02cb611 dee7b004
00002000
       ceab6000 0eab6000 ded75004 dcbedf50 c02cb713 ded75004 00000077
de347004
       dffe61dc dcbedf70 c016aa7b d8c5b098 de347004 d1f17004 de347004
c745f004
Call Trace:
 [<c02cb611>] usblp_cleanup+0x43/0xa2
 [<c02cb713>] usblp_release+0x6b/0x6d
 [<c016aa7b>] __fput+0xb5/0xc4
 [<c0168c09>] filp_close+0x4b/0x74
 [<c0168d35>] sys_close+0x103/0x226
 [<c0169b05>] sys_read+0x3f/0x5d
 [<c010a07d>] sysenter_past_esp+0x52/0x71
 
Code: 8b 90 e0 00 00 00 85 d2 74 0e 8b 4a 20 85 c9 74 07 8b 41 18
 <6>hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt
0 proto 2 vid 0x04B8 pid 0x0005
usb 2-1: USB disconnect, address 4
drivers/usb/class/usblp.c: usblp0: removed

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

