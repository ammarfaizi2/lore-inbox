Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVAYR3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVAYR3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVAYR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:29:47 -0500
Received: from mout2.freenet.de ([194.97.50.155]:53224 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262028AbVAYR2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:28:31 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: swap on dmcrypt crashes machine
Date: Tue, 25 Jan 2005 18:28:12 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200501251828.17569.mbuesch@freenet.de>
Cc: ck@vds.kolivas.org
Content-Type: multipart/signed;
  boundary="nextPart1705872.ynONRVoAdE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1705872.ynONRVoAdE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

linux-2.6.10-ck4
gcc-3.4.4 20041128


I set up swap on an encrypted dmcrypt device.
While stressing swap usage with make -j200 in the
kernel tree, the machine crashes:

Adding 1461872k swap on /dev/mapper/swap.  Priority:-2 extents:1
=2D-----------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:2193!
invalid operand: 0000 [#1]
SMP=20
Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf firmw=
are_class btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
CPU:    0
EIP:    0060:[<c0218b8a>]    Tainted: P      VLI
EFLAGS: 00210002   (2.6.10-ck4-defaultidle)=20
EIP is at __blk_put_request+0x87/0x91
eax: d6149574   ebx: d15ede60   ecx: c021edb1   edx: 00432374
esi: f7cc1b1c   edi: 00000000   ebp: d0969780   esp: d0969774
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 8285, threadinfo=3Dd0968000 task=3De07b0530)
Stack: d15ede60 c196cc80 00000088 d0969798 c0219d42 00000000 d15ede60 da55d=
080=20
       00200286 d09697b0 c023ce8b f7cc1b1c 00000001 00000001 d15ede60 d0969=
814=20
       c023d142 00000001 d09697c8 da55d098 d09697d4 00200096 c1a0970c da55d=
080=20
Call Trace:
 [<c0103b6d>] show_stack+0x7a/0x90
 [<c0103cee>] show_registers+0x152/0x1ca
 [<c0103ef3>] die+0xf4/0x178
 [<c01042e4>] do_invalid_op+0xa3/0xad
 [<c010381b>] error_code+0x2b/0x30
 [<c0219d42>] end_that_request_last+0xb4/0xf0
 [<c023ce8b>] scsi_end_request+0x98/0xca
 [<c023d142>] scsi_io_completion+0xec/0x444
 [<c0238faa>] scsi_finish_command+0x78/0xba
 [<c0238ecd>] scsi_softirq+0x89/0xb5
 [<c0122a50>] __do_softirq+0x64/0xd2
 [<c0122aef>] do_softirq+0x31/0x33
 [<c0104ec8>] do_IRQ+0x3c/0x65
 [<c01036e6>] common_interrupt+0x1a/0x20
Code: e8 aa 25 f2 ff 89 fa 89 f0 8b 1c 24 8b 74 24 04 8b 7c 24 08 89 ec 5d =
e9 01 f6 ff ff 8b 1c 24 8b 74 24 04 8b 7c 24 08 89 ec 5d c3 <0f> 0b 91 08 2=
d e8 33 c0 eb bd 55 89 e5 83 ec 0c 89 7c 24 08 89=20
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 NMI Watchdog detected LOCKUP on CPU1, eip c0319132, registers:
Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf firmw=
are_class btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
CPU:    1
EIP:    0060:[<c0319132>]    Tainted: P      VLI
EFLAGS: 00200086   (2.6.10-ck4-defaultidle)=20
EIP is at _spin_lock_irq+0x1a/0x44
eax: c1a0cc1c   ebx: c1a0cc1c   ecx: ecf5fc80   edx: 00000000
esi: f7cc1b1c   edi: 00000000   ebp: cef21988   esp: cef2197c
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 7732, threadinfo=3Dcef20000 task=3Dd1b8e530)
Stack: 00001000 00000000 d0365240 cef219d8 c0218f02 d42c6ff0 00000000 00000=
000=20
       00001000 0016699f c1910000 00000200 cef21a90 00000200 00000000 00000=
008=20
       00000008 00000001 c01b37f2 d0365240 f7cc1b1c 00001000 cef21a0c cef21=
a64=20
Call Trace:
 [<c0103b6d>] show_stack+0x7a/0x90
 [<c0103cee>] show_registers+0x152/0x1ca
 [<c01047e6>] die_nmi+0x50/0x81
 [<c0111782>] nmi_watchdog_tick+0x9a/0xb6
 [<c0104889>] default_do_nmi+0x72/0x10d
 [<c010497c>] do_nmi+0x51/0x63
 [<c01038fc>] nmi_stack_correct+0x1d/0x2a
 [<c0218f02>] __make_request+0xb7/0x4a3
 [<c02195f7>] generic_make_request+0xb6/0x228
 [<c0283f28>] crypt_map+0x112/0x21d
 [<c027c17b>] __map_bio+0x3b/0xe4
 [<c027c50a>] __clone_and_map+0x213/0x222
 [<c027c5a1>] __split_bio+0x88/0xf0
 [<c027c66d>] dm_request+0x64/0x90
 [<c02195f7>] generic_make_request+0xb6/0x228
 [<c02197c9>] submit_bio+0x60/0x100
 [<c014ca9a>] swap_writepage+0x8a/0xc8
 [<c0142679>] pageout+0x98/0xd5
 [<c014288c>] shrink_list+0x1d6/0x403
 [<c0142c20>] shrink_cache+0x167/0x3b9
 [<c014340f>] shrink_zone+0xa2/0xd8
 [<c01434a5>] shrink_caches+0x60/0x6c
 [<c0143570>] try_to_free_pages+0xbf/0x18c
 [<c013c3bd>] __alloc_pages+0x20e/0x2f8
 [<c014d1a6>] read_swap_cache_async+0x73/0xcd
 [<c01467c0>] swapin_readahead+0x4e/0x9d
 [<c01469c5>] do_swap_page+0x1b6/0x2a8
 [<c01471b2>] handle_mm_fault+0xfe/0x16a
 [<c0113f6e>] do_page_fault+0x215/0x628
 [<c010381b>] error_code+0x2b/0x30
Code: 24 04 e8 34 51 e0 ff 0f 0b 95 00 02 0a 33 c0 eb bf 55 89 e5 53 89 c3 =
83 ec 08 fa 81 78 04 ad 4e ad de 75 14 f0 fe 0b 79 09 f3 90 <80> 3b 00 7e f=
9 eb f2 83 c4 08 5b 5d c3 8b 45 04 c7 04 24 f3 11=20
console shuts up ...
  SysRq : Emergency Sync
SysRq : Terminate All Tasks
SysRq : SAK
SysRq : SAK
SysRq : Emergency Remount R/O
SysRq : Resetting
Badness in smp_call_function at arch/i386/kernel/smp.c:523
 [<c0103b9a>] dump_stack+0x17/0x19
 [<c01107b4>] smp_call_function+0xcf/0xe5
 [<c0110818>] smp_send_stop+0x1e/0x27
 [<c011024b>] machine_restart+0x8a/0x105
 [<c0207f7c>] __handle_sysrq+0x6c/0xf8
 [<c02023e0>] kbd_event+0xdc/0xeb
 [<c0252aea>] input_event+0x14e/0x3b2
 [<c025508f>] atkbd_report_key+0x2f/0x71
 [<c0255405>] atkbd_interrupt+0x334/0x65f
 [<c020a2a2>] serio_interrupt+0x43/0x95
 [<c020a91c>] i8042_interrupt+0x151/0x181
 [<c0136b54>] handle_IRQ_event+0x35/0x67
 [<c0136c53>] __do_IRQ+0xcd/0x136
 [<c0104ec3>] do_IRQ+0x37/0x65
 [<c01036e6>] common_interrupt+0x1a/0x20
 [<c0110818>] smp_send_stop+0x1e/0x27
 [<c011da28>] panic+0x49/0xe6
 [<c0103f6d>] die+0x16e/0x178
 [<c01042e4>] do_invalid_op+0xa3/0xad
 [<c010381b>] error_code+0x2b/0x30
 [<c0219d42>] end_that_request_last+0xb4/0xf0
 [<c023ce8b>] scsi_end_request+0x98/0xca
 [<c023d142>] scsi_io_completion+0xec/0x444
 [<c0238faa>] scsi_finish_command+0x78/0xba
 [<c0238ecd>] scsi_softirq+0x89/0xb5
 [<c0122a50>] __do_softirq+0x64/0xd2
 [<c0122aef>] do_softirq+0x31/0x33
 [<c0104ec8>] do_IRQ+0x3c/0x65
 [<c01036e6>] common_interrupt+0x1a/0x20
NMI Watchdog detected LOCKUP on CPU0, eip c03192d4, registers:
Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf firmw=
are_class btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
CPU:    0
EIP:    0060:[<c03192d4>]    Tainted: P      VLI
EFLAGS: 00200082   (2.6.10-ck4-defaultidle)=20
EIP is at _spin_lock+0x1c/0x43
eax: c0372d38   ebx: c0372d38   ecx: c037388c   edx: 00200086
esi: c01107ca   edi: 00000000   ebp: d09693e4   esp: d09693d8
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 8285, threadinfo=3Dd0968000 task=3De07b0530)
Stack: d09693e4 c0103b9a 00000001 d0969428 c0110737 c032fe08 c031c020 c032f=
df1=20
       0000020b c01107ca 00000000 00000000 00000000 00000000 c043dcca 00200=
086=20
       0000000a 00000000 00000062 f72e3000 d0969434 c0110818 00000000 d0969=
444=20
Call Trace:
 [<c0103b6d>] show_stack+0x7a/0x90
 [<c0103cee>] show_registers+0x152/0x1ca
 [<c01047e6>] die_nmi+0x50/0x81
 [<c0111782>] nmi_watchdog_tick+0x9a/0xb6
 [<c0104889>] default_do_nmi+0x72/0x10d
 [<c010497c>] do_nmi+0x51/0x63
 [<c01038fc>] nmi_stack_correct+0x1d/0x2a
 [<c0110737>] smp_call_function+0x52/0xe5
 [<c0110818>] smp_send_stop+0x1e/0x27
 [<c011024b>] machine_restart+0x8a/0x105
 [<c0207f7c>] __handle_sysrq+0x6c/0xf8
 [<c02023e0>] kbd_event+0xdc/0xeb
 [<c0252aea>] input_event+0x14e/0x3b2
 [<c025508f>] atkbd_report_key+0x2f/0x71
 [<c0255405>] atkbd_interrupt+0x334/0x65f
 [<c020a2a2>] serio_interrupt+0x43/0x95
 [<c020a91c>] i8042_interrupt+0x151/0x181
 [<c0136b54>] handle_IRQ_event+0x35/0x67
 [<c0136c53>] __do_IRQ+0xcd/0x136
 [<c0104ec3>] do_IRQ+0x37/0x65
 [<c01036e6>] common_interrupt+0x1a/0x20
 [<c0110818>] smp_send_stop+0x1e/0x27
 [<c011da28>] panic+0x49/0xe6
 [<c0103f6d>] die+0x16e/0x178
 [<c01042e4>] do_invalid_op+0xa3/0xad
 [<c010381b>] error_code+0x2b/0x30
 [<c0219d42>] end_that_request_last+0xb4/0xf0
 [<c023ce8b>] scsi_end_request+0x98/0xca
 [<c023d142>] scsi_io_completion+0xec/0x444
 [<c0238faa>] scsi_finish_command+0x78/0xba
 [<c0238ecd>] scsi_softirq+0x89/0xb5
 [<c0122a50>] __do_softirq+0x64/0xd2
 [<c0122aef>] do_softirq+0x31/0x33
 [<c0104ec8>] do_IRQ+0x3c/0x65
 [<c01036e6>] common_interrupt+0x1a/0x20
Code: ed ff ff 5d c3 0f 0b d5 00 02 0a 33 c0 eb e4 55 89 e5 53 89 c3 83 ec =
08 81 78 04 ad 4e ad de 75 14 f0 fe 0b 79 09 f3 90 80 3b 00 <7e> f9 eb f2 8=
3 c4 08 5b 5d c3 8b 45 04 c7 04 24 f3 11 33 c0 89=20
console shuts up ...


=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart1705872.ynONRVoAdE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9oGxFGK1OIvVOP4RAmOZAKCSvO/8/tCwsd2/L46DG5EJXSfnxgCgt9/t
D9XmyEPW4G7cv5kL+dT8GI0=
=GTBN
-----END PGP SIGNATURE-----

--nextPart1705872.ynONRVoAdE--
