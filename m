Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUJYIZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUJYIZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUJYITh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:37 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:10113 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261699AbUJYHkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:40:42 -0400
Message-ID: <9405454.1098690041900.JavaMail.ngmail@webmail04.arcor-online.net>
Date: Mon, 25 Oct 2004 09:40:41 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: benh@kernel.crashing.org
Subject: Re: Re: [2.6.10-rc1] Segmentation fault in program "X"
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: : 193.150.166.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Nachricht ----
Von:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
An:      Linus Torvalds <torvalds@osdl.org>
Datum:   25.10.2004 01:00
Betreff: Re: [2.6.10-rc1] Segmentation fault in program "X"

> On Mon, 2004-10-25 at 06:24, Linus Torvalds wrote:
> 
> > > Signal SIGSEGV happens while doing sys function
> > > "ioctl(5, FBIOBLANK <unfinished ...>"
> > > 
> > > seems to be some changes between 2.6.9 and 2.6.10-rc1 in file "fbmem.c"
> > 
> > Do you have radeon hardware? Is there any oops in your logs?
> 
> A Oops log would be useful...
> 
> I don't see anything, are you sure he is using radeonfb ? Look at the
> fix posted by Tony Dapalas today fixing a possible Oops on blank for
> fbdev's that have no blank() callback ...
> 
> Ben.
> 
> 
> 

Hello.

It's a via integrated video card and there is an oops:

Oct 23 09:34:46 hotzenplotz kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000048
Oct 23 09:34:46 hotzenplotz kernel:  printing eip:
Oct 23 09:34:46 hotzenplotz kernel: c0202206
Oct 23 09:34:46 hotzenplotz kernel: *pde = 00000000
Oct 23 09:34:46 hotzenplotz kernel: Oops: 0000 [#1]
Oct 23 09:34:46 hotzenplotz kernel: PREEMPT SMP 
Oct 23 09:34:46 hotzenplotz kernel: Modules linked in: eth1394 ohci1394 uhci_hcd ehci_hcd i2c_viapro i2c_core snd_via82xx snd_ac97_codec gameport snd_mpu401_uart snd_rawmidi joydev tsdev evdev yenta_socket pcmcia_core ntfs
Oct 23 09:34:46 hotzenplotz kernel: CPU:    0
Oct 23 09:34:46 hotzenplotz kernel: EIP:    0060:[<c0202206>]    Not tainted VLI
Oct 23 09:34:46 hotzenplotz kernel: EFLAGS: 00013293   (2.6.10-rc1) 
Oct 23 09:34:46 hotzenplotz kernel: EIP is at fb_set_cmap+0x76/0xf0
Oct 23 09:34:46 hotzenplotz kernel: eax: 00000000   ebx: 00000048   ecx: 00000807   edx: c02031a0
Oct 23 09:34:46 hotzenplotz kernel: esi: ebc30008   edi: 00003282   ebp: e1932e20   esp: e1932de0
Oct 23 09:34:46 hotzenplotz kernel: ds: 007b   es: 007b   ss: 0068
Oct 23 09:34:46 hotzenplotz kernel: Process X (pid: 2366, threadinfo=e1932000 task=e1802a80)
Oct 23 09:34:46 hotzenplotz kernel: Stack: e1932e00 e1932e00 e1932e20 00003246 e1932e28 c03bd0e0 0000ffff e1932e24 
Oct 23 09:34:46 hotzenplotz kernel:        083bb950 00000000 00000048 00000000 ebc30000 ebc30000 e1d2de00 00000001 
Oct 23 09:34:46 hotzenplotz kernel:        e1932e54 c01ff18a 00003282 00003246 00000048 00000000 083bb950 ebc30008 
Oct 23 09:34:46 hotzenplotz kernel: Call Trace:
Oct 23 09:34:46 hotzenplotz kernel:  [<c0106eaa>] show_stack+0x7a/0x90
Oct 23 09:34:46 hotzenplotz kernel:  [<c0107032>] show_registers+0x152/0x1c0
Oct 23 09:34:46 hotzenplotz kernel:  [<c010723c>] die+0xfc/0x180
Oct 23 09:34:46 hotzenplotz kernel:  [<c0119517>] do_page_fault+0x237/0x5e7
Oct 23 09:34:46 hotzenplotz kernel:  [<c0106af9>] error_code+0x2d/0x38
Oct 23 09:34:46 hotzenplotz kernel:  [<c01ff18a>] fb_blank+0x6a/0x110
Oct 23 09:34:46 hotzenplotz kernel:  [<c01ff4c0>] fb_ioctl+0x290/0x360
Oct 23 09:34:46 hotzenplotz kernel:  [<c016add4>] sys_ioctl+0xf4/0x260
Oct 23 09:34:46 hotzenplotz kernel:  [<c010606f>] syscall_call+0x7/0xb
Oct 23 09:34:46 hotzenplotz kernel: Code: 75 0d b8 ea ff ff ff 83 c4 34 5b 5e 5f c9 c3 8b 5d d0 c7 45 ec 00 00 00 00 31 c0 3b 43 04 73 78 90 8d 74 26 00 8b 5d e8 8b 45 e4 <0f> b7 1b 83 45 e8 02 89 5d dc 8b 5d e0 0f b7 08 83 c0 02 89 45 


with kind regards
Thomas


