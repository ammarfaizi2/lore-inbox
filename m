Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423263AbWJYLA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423263AbWJYLA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423264AbWJYLA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:00:27 -0400
Received: from nucleus.hjsoft.com ([207.210.221.102]:25867 "EHLO
	nucleus.hjsoft.com") by vger.kernel.org with ESMTP id S1423263AbWJYLA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:00:26 -0400
Date: Wed, 25 Oct 2006 07:00:25 -0400
From: John M Flinchbaugh <john@hjsoft.com>
To: linux-kernel@vger.kernel.org
Subject: inconsistent lock state in 2.6.18.1
Message-ID: <20061025110024.GA4320@hjsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I see this OOPS on boot with 2.6.18.1/amd64:
[  113.147347] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  113.147561] [ INFO: inconsistent lock state ]
[  113.147668] ---------------------------------
[  113.147775] inconsistent {in-hardirq-W} -> {hardirq-on-W} usage.
[  113.147883] dhclient3/1787 [HC0[0]:SC0[1]:HE1:SE0] takes:
[  113.147991]  (&ei_local->page_lock){+...}, at: [<ffffffff88080fbb>] ei_s=
tart_xmit+0x95/0x24e [8390]
[  113.148274] {in-hardirq-W} state was registered at:
[  113.148382]   [<ffffffff802443d5>] lock_acquire+0x7a/0xa1
[  113.148556]   [<ffffffff80438c09>] _spin_lock+0x2e/0x3c
[  113.148730]   [<ffffffff880808e0>] ei_interrupt+0x44/0x2fb [8390]
[  113.148904]   [<ffffffff80258f9f>] handle_IRQ_event+0x2b/0x64
[  113.149078]   [<ffffffff80259086>] __do_IRQ+0xae/0x114
[  113.149251]   [<ffffffff8020c21a>] do_IRQ+0xee/0x100
[  113.149424]   [<ffffffff80209dbd>] common_interrupt+0x65/0x66
[  113.149596] irq event stamp: 20582
[  113.149703] hardirqs last  enabled at (20582): [<ffffffff8043916b>] _spi=
n_unlock_irqrestore+0x3f/0x69
[  113.149940] hardirqs last disabled at (20581): [<ffffffff80438e74>] _spi=
n_lock_irqsave+0x13/0x46
[  113.150176] softirqs last  enabled at (20456): [<ffffffff880037b2>] unix=
_release_sock+0x7c/0x218 [unix]
[  113.150417] softirqs last disabled at (20578): [<ffffffff803ddbe8>] dev_=
queue_xmit+0xe2/0x26a
[  113.150654]=20
[  113.150654] other info that might help us debug this:
[  113.150866] 1 lock held by dhclient3/1787:
[  113.150973]  #0:  (&dev->_xmit_lock){-+..}, at: [<ffffffff803ea9c6>] __q=
disc_run+0x77/0x1e5
[  113.151272]=20
[  113.151273] stack backtrace:
[  113.151484]=20
[  113.151485] Call Trace:
[  113.151799]  [<ffffffff8020ae85>] show_trace+0xae/0x342
[  113.151919]  [<ffffffff8020b12e>] dump_stack+0x15/0x17
[  113.152039]  [<ffffffff8024293b>] print_usage_bug+0x259/0x26a
[  113.152230]  [<ffffffff802431ae>] mark_lock+0x218/0x3e2
[  113.152421]  [<ffffffff80243d97>] __lock_acquire+0x492/0xa56
[  113.152612]  [<ffffffff802443d6>] lock_acquire+0x7b/0xa1
[  113.152804]  [<ffffffff80438c0a>] _spin_lock+0x2f/0x3c
[  113.153002]  [<ffffffff88080fbb>] :8390:ei_start_xmit+0x95/0x24e
[  113.153114]  [<ffffffff803dbac0>] dev_hard_start_xmit+0x1d6/0x24b
[  113.153696]  [<ffffffff803eaa52>] __qdisc_run+0x103/0x1e5
[  113.154282]  [<ffffffff803ddc45>] dev_queue_xmit+0x13f/0x26a
[  113.154857]  [<ffffffff882e2d72>] :af_packet:packet_sendmsg_spkt+0x1cf/0=
x1f7
[  113.154975]  [<ffffffff803d0a8c>] sock_sendmsg+0x111/0x130
[  113.155535]  [<ffffffff803d1f23>] sys_sendto+0x106/0x12d
[  113.156096]  [<ffffffff80209886>] system_call+0x7e/0x83
[  113.156209] DWARF2 unwinder stuck at system_call+0x7e/0x83
[  113.156316] Leftover inexact backtrace:

It seems to be ISCs dhclient3 talking to a NIC which is driven by ne2k_pci
module:
[   91.706329] eth0: RealTek RTL-8029 found at 0xa400, IRQ 225, 00:40:05:59=
:11:18.

Here's the ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux butterfly 2.6.18.1 #1 SMP PREEMPT Wed Oct 25 06:26:53 EDT 2006 x86_64=
 GNU/Linux
=20
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.40-WIP
reiserfsprogs          3.6.19
quota-tools            3.14.
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   100
Modules Loaded         radeon drm binfmt_misc rfcomm l2cap bluetooth nfs nf=
sd exportfs lockd nfs_acl sunrpc thermal fan button ac battery autofs4 act_=
police sch_ingress cls_u32 sch_sfq sch_cbq ipt_REJECT xt_tcpudp iptable_fil=
ter iptable_nat ip_nat ip_conntrack nfnetlink ip_tables x_tables ipv6 af_pa=
cket dm_snapshot dm_mirror dm_mod it87 hwmon_vid hwmon eeprom i2c_isa lp cp=
ufreq_ondemand powernow_k8 freq_table processor sr_mod sbp2 ide_generic ide=
_disk ide_cd cdrom eth1394 amd74xx generic ide_core usbhid snd_intel8x0 tsd=
ev 8250_pnp snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss ohci_hcd =
snd_pcm ohci1394 ieee1394 ehci_hcd evdev sata_nv i2c_nforce2 i2c_core usbco=
re snd_timer snd_page_alloc libata snd_mpu401 snd_mpu401_uart snd_rawmidi s=
nd_seq_device sk98lin forcedeth ne2k_pci 8390 8250 serial_core parport_pc p=
arport floppy snd soundcore pcspkr psmouse serio_raw unix
--=20
John M Flinchbaugh
john@hjsoft.com

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFP0PICGPRljI8080RAtD7AJ4ph4vpp9hhLkm0lMBdH0NKsZUR+QCdG7tR
zxed08m8HbW4nqBTCpNEKGU=
=kr1x
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
