Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272912AbTHFWdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272637AbTHFWc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:32:56 -0400
Received: from mx0.gmx.net ([213.165.64.100]:63924 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S272559AbTHFWbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:31:43 -0400
Date: Thu, 7 Aug 2003 00:31:39 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [2.6.0-test2-bk5] OHCI USB printing causing system lockup...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.107.193.132]
Message-ID: <19853.1060209099@www44.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When printing a test page on an Epson C62 through an unpowered USB 1.1 hub,
the printer printed part of the page, then stopped.

The 'error -110' messages were being sent to the syslogs, and after pulling
the connector to the USB hub, the system locked up.

Details below:

--- [printer connected via hub]

Aug  6 23:10:28 stratum kernel: hub 2-2:0: new USB device on port 4,
assigned address 31
Aug  6 23:10:28 stratum kernel: drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 31 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005

-- [printing stopped]

Aug  6 23:15:36 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-110 reading printer status
Aug  6 23:15:36 stratum last message repeated 146 times

--- [pulled USB hub connection, ie disconnect 3 devices + hub]

Aug  6 23:15:36 stratum kernel: usb 2-2: USB disconnect, address 25
Aug  6 23:15:36 stratum kernel: usb 2-2.1: USB disconnect, address 26
Aug  6 23:15:36 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-110 reading printer status
Aug  6 23:15:36 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-110 reading printer status
Aug  6 23:15:36 stratum kernel: usb 2-2.2: USB disconnect, address 27
Aug  6 23:15:36 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-110 reading printer status
Aug  6 23:15:36 stratum kernel: usb 2-2.3: USB disconnect, address 28
Aug  6 23:15:36 stratum kernel: usb 2-2.4: USB disconnect, address 31
Aug  6 23:15:36 stratum kernel: ohci-hcd 0000:00:02.3: ed deee1340 (#0)
state 2(has tds)
Aug  6 23:15:36 stratum kernel: drivers/usb/class/usblp.c: usblp0: error
-108 reading printer status
Aug  6 23:15:36 stratum kernel: usb 2-2.5: USB disconnect, address 29
Aug  6 23:15:39 stratum kernel: drivers/usb/class/usblp.c: usblp0: removed
Aug  6 23:15:39 stratum kernel: Unable to handle kernel paging request at
virtual address df2670e4
Aug  6 23:15:39 stratum kernel:  printing eip:
Aug  6 23:15:39 stratum kernel: c02b6a6a
Aug  6 23:15:39 stratum kernel: *pde = 0007b067
Aug  6 23:15:39 stratum kernel: *pte = 1f267000
Aug  6 23:15:39 stratum kernel: Oops: 0000 [#1]
Aug  6 23:15:39 stratum kernel: CPU:    0
Aug  6 23:15:39 stratum kernel: EIP:    0060:[<c02b6a6a>]    Not tainted
Aug  6 23:15:39 stratum kernel: EFLAGS: 00010282
Aug  6 23:15:39 stratum kernel: EIP is at usb_buffer_free+0xd/0x46

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

