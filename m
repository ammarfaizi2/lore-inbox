Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264199AbTCXNLD>; Mon, 24 Mar 2003 08:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264200AbTCXNLC>; Mon, 24 Mar 2003 08:11:02 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:11407 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S264199AbTCXNKg> convert rfc822-to-8bit; Mon, 24 Mar 2003 08:10:36 -0500
Content-Type: text/plain;
  charset="utf-8"
From: Eugen Kaparulin <eugen.kaparulin@arcor.de>
Reply-To: eugen.kaparulin@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.5.65 broken i4l, hisax and hisax_fcpcipnp
Date: Mon, 24 Mar 2003 14:22:11 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303241422.11357.eugen.kaparulin@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developer,

I just trying to get my configuration complete since I upgraded my system to 
dual CPU. I'm using a
Tyan Tiger Board running two Pentium III-S 1400 MHz CPU's.

The kernel 2.4.20 wasn't able to find the L2 Cache so I tried the kernel 
2.5.65. It seems to work fine with the processors
and so on, but unfortunatelly I can't get my ISDN working. Since I'm using a 
Fritz!Card PCI v2 I used to compile
the support for i4l and hisax with hisax_fcpcipnp module.

But I can't finish even a "make bzImage". there are calls for  `save_flags', 
`cli' and `restore_flags' functions. I've read the
mailing lists and found responses for similar problems but it seemed to affect 
SMP kernels only.

I compiled it for UMP but is still didn't work. Then I commented out these 
"flags" calls from concerned modules
(isdn_tty and isdn_audio) so I could finish a "make bzImage".
But loading the hisax modules I get these messages:

Mar 23 11:54:22 xaoc kernel: hisax: Unknown symbol kstat__per_cpu
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmDelTimer
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmEvent
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmRestartTimer
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmChangeState
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmFree
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmInitTimer
Mar 23 11:54:22 xaoc kernel: hisax_isac: Unknown symbol FsmNew
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol isac_irq
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol hisax_unregister
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol hisax_register
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol hisax_isac_setup
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol isac_d_l2l1
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol isacsx_setup
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol isac_init
Mar 23 11:54:22 xaoc kernel: hisax_fcpcipnp: Unknown symbol isacsx_irq

So I suppose there is something massively wrong in the code or I am doing 
something wrong I don't know. I've
downloaded the latest patch from today 2.5.65-bk4 but still have the same 
result. Can you tell me what am I doing wrong?


These are the messages from "make bzImage" :

drivers/built-in.o: In function `isdn_tty_readmodem':
drivers/built-in.o(.text+0x15688f): undefined reference to `save_flags'
drivers/built-in.o(.text+0x156894): undefined reference to `cli'
drivers/built-in.o(.text+0x156904): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_rcv_skb':
drivers/built-in.o(.text+0x156acf): undefined reference to `save_flags'
drivers/built-in.o(.text+0x156ad4): undefined reference to `cli'
drivers/built-in.o(.text+0x156b18): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x156b5f): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_cleanup_xmit':
drivers/built-in.o(.text+0x156d10): undefined reference to `save_flags'
drivers/built-in.o(.text+0x156d15): undefined reference to `cli'
drivers/built-in.o: In function `isdn_tty_dial':
drivers/built-in.o(.text+0x157626): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15762b): undefined reference to `cli'
drivers/built-in.o(.text+0x1576e1): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x15773b): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_resume':
drivers/built-in.o(.text+0x157aab): undefined reference to `save_flags'
drivers/built-in.o(.text+0x157ab0): undefined reference to `cli'
drivers/built-in.o(.text+0x157b17): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x157c1f): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_send_msg':
drivers/built-in.o(.text+0x157d03): undefined reference to `save_flags'
drivers/built-in.o(.text+0x157d08): undefined reference to `cli'
drivers/built-in.o(.text+0x157d6f): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x157e2f): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_startup':
drivers/built-in.o(.text+0x157f96): undefined reference to `save_flags'
drivers/built-in.o(.text+0x157f9b): undefined reference to `cli'
drivers/built-in.o(.text+0x157fdc): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_shutdown':
drivers/built-in.o: In function `isdn_tty_flush_buffer':
drivers/built-in.o(.text+0x158717): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_at_cout':
drivers/built-in.o(.text+0x158014): undefined reference to `save_flags'
drivers/built-in.o(.text+0x158019): undefined reference to `cli'
drivers/built-in.o: In function `isdn_tty_flush_buffer':
drivers/built-in.o(.text+0x158656): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15865b): undefined reference to `cli'
drivers/built-in.o(.text+0x1586c7): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_get_lsr_info':
drivers/built-in.o(.text+0x158906): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15890b): undefined reference to `cli'
drivers/built-in.o(.text+0x15891a): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_get_modem_info':
drivers/built-in.o(.text+0x158974): undefined reference to `save_flags'
drivers/built-in.o(.text+0x158979): undefined reference to `cli'
drivers/built-in.o(.text+0x158988): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_block_til_ready':
drivers/built-in.o(.text+0x158e62): undefined reference to `save_flags'
drivers/built-in.o(.text+0x158e67): undefined reference to `cli'
drivers/built-in.o(.text+0x158e8d): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_close':
drivers/built-in.o(.text+0x15922e): undefined reference to `save_flags'
drivers/built-in.o(.text+0x159233): undefined reference to `cli'
drivers/built-in.o(.text+0x1593af): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_find_icall':
drivers/built-in.o(.text+0x159eca): undefined reference to `save_flags'
drivers/built-in.o(.text+0x159ecf): undefined reference to `cli'
drivers/built-in.o(.text+0x159f1d): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x15a016): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_at_cout':
drivers/built-in.o(.text+0x15a522): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15a527): undefined reference to `cli'
drivers/built-in.o(.text+0x15a696): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x15a6e0): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_modem_result':
drivers/built-in.o(.text+0x15aa3a): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15aa3f): undefined reference to `cli'
drivers/built-in.o(.text+0x15aa5f): undefined reference to `restore_flags'
drivers/built-in.o(.text+0x15ace6): undefined reference to `save_flags'
drivers/built-in.o(.text+0x15aceb): undefined reference to `cli'
drivers/built-in.o(.text+0x15ad27): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_cleanup_xmit':
drivers/built-in.o(.text+0x156de3): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_shutdown':
drivers/built-in.o(.text+0x15806d): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_flush_buffer':
drivers/built-in.o(.text+0x158717): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_tty_at_cout':
drivers/built-in.o(.text+0x15a79e): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_audio_eval_dtmf':
drivers/built-in.o(.text+0x166848): undefined reference to `save_flags'
drivers/built-in.o(.text+0x16684d): undefined reference to `cli'
drivers/built-in.o(.text+0x16687b): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_audio_put_dle_code':
drivers/built-in.o(.text+0x166c0e): undefined reference to `save_flags'
drivers/built-in.o(.text+0x166c13): undefined reference to `cli'
drivers/built-in.o(.text+0x166c38): undefined reference to `restore_flags'
make: *** [vmlinux] Error 1

Since I am not yet suscribed on the list would you be so kind in your 
answering setting me personally on CC in answers/comments posted to the list 
in response to my posting?

Regards, Eugen.
