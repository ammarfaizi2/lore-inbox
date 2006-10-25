Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423252AbWJYKqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423252AbWJYKqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423255AbWJYKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:46:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20767 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423252AbWJYKqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:46:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SwBok5mgDoIs7DfZpCiLYe7lws+4JCTLMH9TQ7NezQZ24/qniT2KIjvhmk91VOxV+XBOD2pOTGVp4O8R/tRVIH6KUJio96R6AoEvjK7SJpIh8jD7fIaT/mUode/0WXfJzHy28CtUJWVuwAoxgUp+rTBLeMUIK9KoVeo8MPrh+tc=
Message-ID: <74d0deb30610250346u1f444a5brbc2c32b4ab83d3e2@mail.gmail.com>
Date: Wed, 25 Oct 2006 12:46:27 +0200
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc[123]: Oops in __wake_up_common during htc magician resume.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I switched from 2.6.18 to 2.6.19-rc1 processes started to get killed
during resume due to an oops in __wake_up_common on my arm
pxa272 device (htc magician). The patches I used are at
http://userpage.fu-berlin.de/~zabel/magician/magician-patches-2.6.19-rc3-20061025.tar.bz2

Is there any information in those reports that could help me find the issue?
I have no idea how to debug this, so I'd appreciate any hint.

<4>Stopping tasks: =============|
<4>Suspending console(s)
<4>resume:
<4>CCCR = 02000408
<4>CLKCFG = 00000009
<4>MSC0 = 7ff085a2
<4>MSC1 = 18801880
<4>MSC2 = 16607ff0
<4>magician_udc_command(0)
<4>usb usb1: root hub lost power or was reset
<3> usbdev1.2_ep00: PM: resume from 0, parent 1-1 still 2
<3>hci_usb 1-1:1.0: PM: resume from 2, parent 1-1 still 2
<3> usbdev1.2_ep81: PM: resume from 0, parent 1-1:1.0 still 2
<3> usbdev1.2_ep02: PM: resume from 0, parent 1-1:1.0 still 2
<3> usbdev1.2_ep82: PM: resume from 0, parent 1-1:1.0 still 2
<3>hci_usb 1-1:1.1: PM: resume from 2, parent 1-1 still 2
<3> usbdev1.2_ep03: PM: resume from 0, parent 1-1:1.1 still 2
<3> usbdev1.2_ep83: PM: resume from 0, parent 1-1:1.1 still 2
<3> hci0: PM: resume from 0, parent 1-1:1.0 still 2
<4>Restarting tasks...<6>usb 1-1: USB disconnect, address 2
<4> done
<6>udc: USB reset
<1>Unable to handle kernel paging request at virtual address a2f0c000
<1>pgd = c2ef8000
<1>[a2f0c000] *pgd=00000000
<4>Internal error: Oops: f5 [#1]
<4>Modules linked in: hci_usb ohci_hcd usbcore magician_ts
leds_magician hidp l2cap bluetooth g_ether corgi_bl
<4>CPU: 0
<4>PC is at __wake_up_common+0x1c/0x78
<4>LR is at __wake_up+0x4c/0x78
<4>pc : [<c002dbf4>]    lr : [<c002f140>]    Not tainted
<4>sp : c2eddd90  ip : a2f0c000  fp : c2edddbc
<4>r10: 000d8000  r9 : c2edddf0  r8 : 80000013
<4>r7 : c0000008  r6 : 00000001  r5 : 00000003  r4 : c0000008
<4>r3 : 00000000  r2 : 00000001  r1 : 00000003  r0 : c0000008
<4>Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
<4>Control: 397F
<4>Table: A2EF8000  DAC: 00000015
<4>Process sh (pid: 888, stack limit = 0xc2edc260)
<4>Stack: (0xc2eddd90 to 0xc2ede000)
<4>dd80:                                     c01187b8 c0000008
00000003 00000001
<4>dda0: c2edddf0 80000013 c382b220 000d8000 c2edddec c2edddc0
c002f140 c002dbe4
<4>ddc0: c2edddf0 00000005 000000bf c028bdc0 00000000 c028bdc0
c2ed8b60 c394b5f8
<4>dde0: c2edde04 c2edddf0 c0048970 c002f100 c028bdc0 00000000
c2edde1c c2edde08
<4>de00: c005830c c0048948 c2ed8800 00000001 c2edde54 c2edde20
c0064d80 c00582c4
<4>de20: a0000013 c38f8800 00005402 c2ed8800 a2eee0df 00000000
c2ed8b60 c394b5f8
<4>de40: 000d8000 c2ef8000 c2eddebc c2edde58 c0065e4c c0064d14
c2ef8000 c382b260
<4>de60: a2eee0df c01de0ac 00000000 00000001 00000800 c382b220
c001f160 c2ef8000
<4>de80: c2eddeac 00000360 c0103cb0 c002e128 c0103e04 ffffffff
c382b254 c394b5f8
<4>dea0: c3e68d60 c382b220 c2eddfb0 000d80f0 c2eddefc c2eddec0
c00226a0 c00655c0
<4>dec0: c022d6c0 a0000013 c2eddef4 0000081f c00763ac ffffffff
c01dccd0 0000081f
<4>dee0: c2eddfb0 000d80f0 00001008 401ed000 c2eddfac c2eddf00
c0022958 c00225c8
<4>df00: c2eddf24 c3cc6de0 c2eddf2c c2eddf18 c01a611c c002e128
c2edc000 00000000
<4>df20: c2eddf5c c2eddf30 c003f3b0 c002e128 c0045ea8 c3cc6de0
bec187b0 c2eddf60
<4>df40: 0000001c 000000ae c001afa8 bec187b0 00000014 00000000
bec187b0 c003f4b8
<4>df60: 00000000 14000000 4010b740 08000000 00000000 0001e0bc
14000000 4010b740
<4>df80: 08000000 00000000 000c50d4 ffffffff 401ee0b4 401ee0b4
401ee07c 00000063
<4>dfa0: 00000000 c2eddfb0 c001ada8 c0022928 000d70e0 00001038
00002040 401ee404
<4>dfc0: 00000438 401ee0b4 401ee0b4 401ee07c 00000063 00001008
401ed000 00001002
<4>dfe0: 000d80e8 bec189b0 00000003 401431e8 20000010 ffffffff
00000000 00000000
<4>Backtrace:
<4>[<c002dbd8>] (__wake_up_common+0x0/0x78) from [<c002f140>]
(__wake_up+0x4c/0x78)
<4>[<c002f0f4>] (__wake_up+0x0/0x78) from [<c0048970>] (__wake_up_bit+0x34/0x3c)
<4> r8 = C394B5F8  r7 = C2ED8B60  r6 = C028BDC0  r5 = 00000000
<4> r4 = C028BDC0
<4>[<c004893c>] (__wake_up_bit+0x0/0x3c) from [<c005830c>]
(unlock_page+0x54/0x60)
<4>[<c00582b8>] (unlock_page+0x0/0x60) from [<c0064d80>] (do_wp_page+0x78/0x5cc)
<4> r4 = 00000001
<4>[<c0064d08>] (do_wp_page+0x0/0x5cc) from [<c0065e4c>]
(__handle_mm_fault+0x898/0x9d8)
<4>[<c00655b4>] (__handle_mm_fault+0x0/0x9d8) from [<c00226a0>]
(do_page_fault+0xe4/0x230)
<4>[<c00225bc>] (do_page_fault+0x0/0x230) from [<c0022958>]
(do_DataAbort+0x3c/0xa0)
<4>[<c002291c>] (do_DataAbort+0x0/0xa0) from [<c001ada8>]
(ret_from_exception+0x0/0x10)
<4> r8 = 00000063  r7 = 401EE07C  r6 = 401EE0B4  r5 = 401EE0B4
<4> r4 = FFFFFFFF
<4>Code: e24dd004 e590c000 e59b9004 e1a07000 (e59c5000)
<4> <6>note: sh[888] exited with preempt_count 2
<6>udc: USB reset
<6>usb0: full speed config #1: 100 mA, Ethernet Gadget, using CDC Ethernet
<3>pxa2xx-udc pxa2xx-udc: pxa27x_ep_disable, ep1in-bulk not enabled
<3>pxa2xx-udc pxa2xx-udc: pxa27x_ep_disable, ep2out-bulk not enabled
<6>usb 1-1: new full speed USB device using pxa27x-ohci and address 3
<6>usb 1-1: configuration #1 chosen from 1 choice

Some more Oops messages (not only page faults, but all of them ending
in __wake_up_common) are at
http://userpage.fu-berlin.de/~zabel/magician/oops.txt

thanks
Philipp
