Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTILMmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbTILMmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:42:11 -0400
Received: from switch-ats62.donpac.ru ([195.161.172.146]:23300 "EHLO
	switch-ats62.donpac.ru") by vger.kernel.org with ESMTP
	id S261455AbTILMmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:42:03 -0400
Date: Fri, 12 Sep 2003 16:42:00 +0400
To: Jes Sorensen <jes@trained-monkey.org>
Cc: linux-kernel@vger.kernel.org
Subject: FWD: qla1280 SCSI driver crash on visws
Message-ID: <20030912124200.GA734@pazke>
Mail-Followup-To: Jes Sorensen <jes@trained-monkey.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: "Andrey Panin,,," <pazke@switch-ats62.donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jes,

qla1280 SCSI driver crashes in inetrrupt handler on visws

Please take a look.

Best regards.

----- Forwarded message from Paul Kaletta <paul@ewido.net> -----

=46rom: Paul Kaletta <paul@ewido.net>
To: linux-visws-devel@lists.sourceforge.net
X-Mailer: Ximian Evolution 1.0.8=20
Subject: [Linux-visws-devel] qla1280

(I'm sorry if you get this twice, but I send it out two days ago,
for some strange reason this message is not in the archives, which seem
to work now, and I didn't recieve any reply).

Hi,

I managed to get the 2.6.0-test5 kernel to work (Andrey: the part with
the VGA-Console still isn't right in test5! I had to apply your patch
for test3 manualy to make a console appear).

The qla1280 driver compiles now and recognizes my harddisk! Hurray *g*
Still something is wrong - during start-up the driver displays the
following stuff:

########
qla1280: QLA1080 found on PCI bus 1, dev 0
scsi(0): Reading NVRAM
scsi(0:0): Resetting SCSI BUS
bad: scheduling while atomic!
Call Trace:
 [<c0118255>] schedule+0x3e5/0x3f0
 [<c0123c63>] schedule_timeout+0x63/0xc0
 [<c0123bf0>] process_timeout+0x0/0x10
 [<c0214fd0>] qla1280_bus_reset+0xa0/0x110
 [<c0214367>] qla1280_init_rings+0xf7/0x100
 [<c0213c67>] qla1280_initialize_adapter+0x147/0x190
 [<c021288c>] qla1280_do_device_init+0x22c/0x260
 [<c0212a38>] qla1280_detect+0x178/0x200
 [<c0352e7b>] init_this_scsi_driver+0x5b/0x110
 [<c03407bb>] do_initcalls+0x2b/0xa0
 [<c012b3ef>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c0107215>] kernel_thread_helper+0x5/0x10

scsi0 : QLogic QLA1080 PCI to SCSI Host Adapter: bus 1 device 0 irq 16
       Firmware version:  8.15.00, Driver version 3.23.35
  Vendor: SEAGATE   Model: ST39103LW         Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi(0:0:0:0): Sync: period 10, offset 8, Wide, Tagged queuing: depth
255
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
#########

That looks pretty wrong to me. However I ignored it, created partitions
on the my SCSI drive, and tried to migrate my stuff from my ide drive to
the SCSI drive. The copying went pretty slow and halted frequently for
some time. After maybe 130 mb it haltet completly. I rebooted and tried
again. This time maybe after 400 megs I got this wonderful stack trace
and kernel panic:

#########
EIP is at 0x0
eax: df659074   ebx: 00000000   ecx: 00000004   edx: 00000003
esi: df634000   edi: 00000001   ebp: c033fee8   esp: c033fecc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc033e000 task=3Dc02ecbe0)
Stack: c011831a df659074 00000003 00000000 c033e000 00000286 00000000
c033ff08
       c011848e df5e1f3c 00000003 00000001 00000000 daee4c20 daee4d24
df62fa2c
       c02137e5 daee4c20 00008020 c0120000 000a0000 00000001 c033e000
df62f1ac
Call Trace:
 [<c011831a>] __wake_up_common+0x3a/0x60
 [<c011848e>] complete+0x3e/0x70
 [<c02137e5>] qla1280_done+0xa5/0x130
 [<c0120000>] __check_region+0x40/0x50
 [<c02132dc>] qla1280_intr_handler+0x8c/0xc0
 [<c010b749>] handle_IRQ_event+0x49/0x80
 [<c010bac7>] do_IRQ+0x97/0x140
 [<c0106ff0>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x60
 [<c0109d68>] common_interrupt+0x18/0x20
 [<c0106ff0>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x60
 [<c0107014>] default_idle+0x24/0x40
 [<c01070a0>] cpu_idle+0x30/0x40
 [<c034076c>] start_kernel+0x14c/0x160
 [<c03404b0>] unknown_bootoption+0x0/0x120

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
##########
btw. this is typed in manually. *cough*. It might contain typos.

I this a visws-issue (messy interrupt handling stuff?) or is something
in the qla1280 driver defunct?

Ciao
Paul Kaletta

----- End forwarded message -----

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Yb8Yby9O0+A2ZecRAleGAJ941Qtp84tNXm3sC9oTVPTNp6b3vACdFcuz
Mgwah4GcoJzIRkDbqCi1f6s=
=w0jh
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
