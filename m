Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264950AbUELCZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264950AbUELCZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUELCZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:25:45 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:58027 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S264952AbUELCZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:25:31 -0400
Subject: Re: 2.6.6 Oops disconnecting speedtouch usb modem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1084287382.2189.1.camel@taz.graycell.biz>
References: <1084274778.2262.7.camel@taz.graycell.biz>
	 <200405111340.52107.baldrick@free.fr>
	 <1084287382.2189.1.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Message-Id: <1084328730.2521.6.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Wed, 12 May 2004 03:25:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ter, 2004-05-11 at 15:56 +0100, Nuno Ferreira wrote:
> On Ter, 2004-05-11 at 13:40 +0200, Duncan Sands wrote:
> > > May 10 23:31:57 taz kernel: EIP is at destroy_async+0x54/0x80
> > 
> > Does this happen with -mm1?
> 
> I will try it later today, I have the modem at home.

OK, I tried it with -mm1 and the second problem I reported (modem_run
complaining about not being able to read interrupts ans exiting) appears
to be gone.
The oops while disconnecting still exists, but it's different.

May 11 21:18:10 taz kernel: usb 1-1: USB disconnect, address 2
May 11 21:18:10 taz kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 11 21:18:10 taz kernel:  printing eip:
May 11 21:18:10 taz kernel: c02168f4
May 11 21:18:10 taz kernel: *pde = 00000000
May 11 21:18:10 taz kernel:        ___      ______
May 11 21:18:10 taz kernel:       0--,|    /OOOOOO\
May 11 21:18:10 taz kernel:      {_o  /  /OO plop OO\
May 11 21:18:10 taz kernel:        \__\_/OO oh dear OOO\s
May 11 21:18:10 taz kernel:           \OOOOOOOOOOOOOOOO/
May 11 21:18:10 taz kernel:            __XXX__   __XXX__
May 11 21:18:10 taz kernel: Oops: 0000 [#1]
May 11 21:18:10 taz kernel: CPU:    0
May 11 21:18:10 taz kernel: EIP:    0060:[usb_ifnum_to_if+36/64]    Not tainted
VLI
May 11 21:18:10 taz kernel: EFLAGS: 00010293   (2.6.6-mm1)
May 11 21:18:10 taz kernel: EIP is at usb_ifnum_to_if+0x24/0x40
May 11 21:18:10 taz kernel: eax: 00000000   ebx: dd3b7c00   ecx: 00000000   edx: 00000001
May 11 21:18:10 taz kernel: esi: 00000003   edi: 00000001   ebp: dd5d5824   esp: ddd91ea8
May 11 21:18:10 taz kernel: ds: 007b   es: 007b   ss: 0068
May 11 21:18:10 taz kernel: Process khubd (pid: 21, threadinfo=ddd91000 task=ddd676b0)
May 11 21:18:10 taz kernel: Stack: dd5d5800 00000000 00000001 c021c42a dcce4510
00000282 dcce4510 de8d5c80
May 11 21:18:10 taz kernel:        dd5d5800 de864a6d 00000000 de8d3e60 ddd4b194
de8d5c80 dd5d5800 dd5d5824
May 11 21:18:10 taz kernel:        c02167c5 ddd4b1a4 de8d5ca0 c01e8fe6 ddd4b1a4
dd5d58cc c01e90f8 ddd4b1a4
May 11 21:18:10 taz kernel: Call Trace:
May 11 21:18:10 taz kernel:  [usb_set_interface+26/304] usb_set_interface+0x1a/0x130
May 11 21:18:10 taz kernel:  [pg0+508303981/1069920256] atm_dev_deregister+0xd/0xc0 [atm]
May 11 21:18:10 taz kernel:  [pg0+508759648/1069920256] udsl_atm_dev_close+0x30/0x50 [speedtch]
May 11 21:18:10 taz kernel:  [usb_unbind_interface+69/112] usb_unbind_interface+0x45/0x70
May 11 21:18:10 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
May 11 21:18:10 taz kernel:  [bus_remove_device+72/144] bus_remove_device+0x48/0x90
May 11 21:18:10 taz kernel:  [device_del+90/144] device_del+0x5a/0x90
May 11 21:18:10 taz kernel:  [device_unregister+8/16] device_unregister+0x8/0x10May 11 21:18:10 taz kernel:  [usb_disable_device+97/176] usb_disable_device+0x61/0xb0
May 11 21:18:10 taz kernel:  [usb_disconnect+143/224] usb_disconnect+0x8f/0xe0
May 11 21:18:10 taz kernel:  [hub_port_connect_change+580/640] hub_port_connect_change+0x244/0x280
May 11 21:18:10 taz kernel:  [hub_port_status+58/176] hub_port_status+0x3a/0xb0
May 11 21:18:10 taz kernel:  [schedule+604/1040] schedule+0x25c/0x410
May 11 21:18:10 taz kernel:  [hub_events+604/688] hub_events+0x25c/0x2b0
May 11 21:18:10 taz kernel:  [hub_thread+43/224] hub_thread+0x2b/0xe0
May 11 21:18:10 taz kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
May 11 21:18:10 taz kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
May 11 21:18:10 taz kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 11 21:18:10 taz kernel:
May 11 21:18:10 taz kernel: Code: 00 00 90 8d 74 26 00 57 89 d7 56 53 8b 98 9c 01 00 00 31 c0 85 db 74 24 0f b6 43 04 31 c9 39 c1 7d 18 89 c6 8d 76 00 8b 44 8b
0c <8b> 10 0f b6 52 02 39 fa 74 07 41 39 f1 7c ed 31 c0 5b 5e 5f c3

-- 
Nuno Ferreira

