Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVEKHQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVEKHQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVEKHQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:16:51 -0400
Received: from k1.dinoex.de ([80.237.200.138]:2033 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S261909AbVEKHQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:16:17 -0400
From: Jochen Hein <jochen@jochen.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.11.8] Hang with IrDA
Mail-Followup-To: linux-kernel@vger.kernel.org
CC: irda-users@lists.sourceforge.net.--.tty.deadlock?
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
Date: Wed, 11 May 2005 08:54:07 +0200
Message-ID: <878y2mi774.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please follow up to Linux-kernel or CC me; I'm not subscribed to irda-users]

I'm trying to communicate with my Handy via IrDA, using scmxx.
# scmxx -d /dev/ircomm0 --system-charset utf-8 -i

That command hangs, SysRQ-t shows:

...
May 11 08:40:24 hermes kernel: scmxx         S CE879D64     0  9248   6505                     (L-TLB)
May 11 08:40:24 hermes kernel: ce879d50 00000046 c1405a60 ce879d64 ce879d2c c0103a92 00000000 c03ebba0 
May 11 08:40:24 hermes kernel:        00000286 c0c5e020 ce879d64 ce879d2c c0c5e020 00000001 c04d5be8 c1405020 
May 11 08:40:24 hermes kernel:        00000000 00000000 1ce069c0 000f66db c012d063 d1006aa0 d1006bf8 00000286 
May 11 08:40:24 hermes kernel: Call Trace:
May 11 08:40:24 hermes kernel:  [schedule_timeout+105/192] schedule_timeout+0x69/0xc0
May 11 08:40:24 hermes kernel:  [pg0+558195132/1068463104] ircomm_tty_wait_until_sent+0xcc/0x160 [ircomm_tty]
May 11 08:40:24 hermes kernel:  [tty_wait_until_sent+225/240] tty_wait_until_sent+0xe1/0xf0
May 11 08:40:24 hermes kernel:  [pg0+558193184/1068463104] ircomm_tty_close+0x120/0x280 [ircomm_tty]
May 11 08:40:24 hermes kernel:  [release_dev+2072/2112] release_dev+0x818/0x840
May 11 08:40:24 hermes kernel:  [tty_release+18/32] tty_release+0x12/0x20
May 11 08:40:24 hermes kernel:  [__fput+333/352] __fput+0x14d/0x160
May 11 08:40:24 hermes kernel:  [filp_close+79/128] filp_close+0x4f/0x80
May 11 08:40:24 hermes kernel:  [put_files_struct+113/208] put_files_struct+0x71/0xd0
May 11 08:40:24 hermes kernel:  [do_exit+211/896] do_exit+0xd3/0x380
May 11 08:40:24 hermes kernel:  [do_group_exit+63/176] do_group_exit+0x3f/0xb0
May 11 08:40:24 hermes kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
...
May 11 08:41:54 hermes kernel: scmxx         S 00000000     0  9248   6505                     (L-TLB)
May 11 08:41:54 hermes kernel: ce879d50 00000046 c1405020 00000000 00000000 699c7680 000f66e7 c03ebba0 
May 11 08:41:54 hermes kernel:        d1006aa0 c8331560 00000000 ce879d2c c8331560 00000001 c04d5be8 c1405020 
May 11 08:41:54 hermes kernel:        00000000 00000000 3c914f40 000f66f0 c012d063 d1006aa0 d1006bf8 00000286 
May 11 08:41:54 hermes kernel: Call Trace:
May 11 08:41:54 hermes kernel:  [schedule_timeout+105/192] schedule_timeout+0x69/0xc0
May 11 08:41:54 hermes kernel:  [pg0+558195132/1068463104] ircomm_tty_wait_until_sent+0xcc/0x160 [ircomm_tty]
May 11 08:41:54 hermes kernel:  [tty_wait_until_sent+225/240] tty_wait_until_sent+0xe1/0xf0
May 11 08:41:54 hermes kernel:  [pg0+558193184/1068463104] ircomm_tty_close+0x120/0x280 [ircomm_tty]
May 11 08:41:54 hermes kernel:  [release_dev+2072/2112] release_dev+0x818/0x840
May 11 08:41:54 hermes kernel:  [tty_release+18/32] tty_release+0x12/0x20
May 11 08:41:54 hermes kernel:  [__fput+333/352] __fput+0x14d/0x160
May 11 08:41:54 hermes kernel:  [filp_close+79/128] filp_close+0x4f/0x80
May 11 08:41:54 hermes kernel:  [put_files_struct+113/208] put_files_struct+0x71/0xd0
May 11 08:41:54 hermes kernel:  [do_exit+211/896] do_exit+0xd3/0x380
May 11 08:41:54 hermes kernel:  [do_group_exit+63/176] do_group_exit+0x3f/0xb0
May 11 08:41:54 hermes kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
...
May 11 08:42:33 hermes kernel: scmxx         S 00000000     0  9248   6505                     (L-TLB)
May 11 08:42:33 hermes kernel: ce879d50 00000046 c1405020 00000000 00000000 699c7680 000f66e7 c03ebba0 
May 11 08:42:33 hermes kernel:        d1006aa0 c819baa0 00000000 ce879d2c c819baa0 00000001 c04d5be8 c1405020 
May 11 08:42:33 hermes kernel:        00000000 00000000 3142a180 000f66f9 c012d063 d1006aa0 d1006bf8 00000286 
May 11 08:42:33 hermes kernel: Call Trace:
May 11 08:42:33 hermes kernel:  [schedule_timeout+105/192] schedule_timeout+0x69/0xc0
May 11 08:42:33 hermes kernel:  [pg0+558195132/1068463104] ircomm_tty_wait_until_sent+0xcc/0x160 [ircomm_tty]
May 11 08:42:33 hermes kernel:  [tty_wait_until_sent+225/240] tty_wait_until_sent+0xe1/0xf0
May 11 08:42:33 hermes kernel:  [pg0+558193184/1068463104] ircomm_tty_close+0x120/0x280 [ircomm_tty]
May 11 08:42:33 hermes kernel:  [release_dev+2072/2112] release_dev+0x818/0x840
May 11 08:42:33 hermes kernel:  [tty_release+18/32] tty_release+0x12/0x20
May 11 08:42:33 hermes kernel:  [__fput+333/352] __fput+0x14d/0x160
May 11 08:42:33 hermes kernel:  [filp_close+79/128] filp_close+0x4f/0x80
May 11 08:42:33 hermes kernel:  [put_files_struct+113/208] put_files_struct+0x71/0xd0
May 11 08:42:33 hermes kernel:  [do_exit+211/896] do_exit+0xd3/0x380
May 11 08:42:33 hermes kernel:  [do_group_exit+63/176] do_group_exit+0x3f/0xb0
May 11 08:42:33 hermes kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
...
May 11 08:43:25 hermes kernel: scmxx         S CE879CF4     0  9248   6505                     (L-TLB)
May 11 08:43:25 hermes kernel: ce879d50 00000046 ce879d1c ce879cf4 c012974d ce879d14 c01053fa c03ebba0 
May 11 08:43:25 hermes kernel:        c01053fa c5d22aa0 0268cb43 ce879d64 c5d22aa0 00000001 c04d5be8 c1405020 
May 11 08:43:25 hermes kernel:        00000000 00000000 81de8080 000f6705 c012d063 d1006aa0 d1006bf8 00000286 
May 11 08:43:25 hermes kernel: Call Trace:
May 11 08:43:25 hermes kernel:  [schedule_timeout+105/192] schedule_timeout+0x69/0xc0
May 11 08:43:25 hermes kernel:  [pg0+558195132/1068463104] ircomm_tty_wait_until_sent+0xcc/0x160 [ircomm_tty]
May 11 08:43:25 hermes kernel:  [tty_wait_until_sent+225/240] tty_wait_until_sent+0xe1/0xf0
May 11 08:43:25 hermes kernel:  [pg0+558193184/1068463104] ircomm_tty_close+0x120/0x280 [ircomm_tty]
May 11 08:43:25 hermes kernel:  [release_dev+2072/2112] release_dev+0x818/0x840
May 11 08:43:25 hermes kernel:  [tty_release+18/32] tty_release+0x12/0x20
May 11 08:43:25 hermes kernel:  [__fput+333/352] __fput+0x14d/0x160
May 11 08:43:25 hermes kernel:  [filp_close+79/128] filp_close+0x4f/0x80
May 11 08:43:25 hermes kernel:  [put_files_struct+113/208] put_files_struct+0x71/0xd0
May 11 08:43:25 hermes kernel:  [do_exit+211/896] do_exit+0xd3/0x380
May 11 08:43:25 hermes kernel:  [do_group_exit+63/176] do_group_exit+0x3f/0xb0
May 11 08:43:25 hermes kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

There is no other IrDA-user, the process can't be killed with "kill
-9", strace to that PID is not permitted (as root):
attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted

Any ideas?

Jochen

-- 
#include <~/.signature>: permission denied
