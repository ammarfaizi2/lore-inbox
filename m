Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTDRSjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDRSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:39:22 -0400
Received: from iucha.net ([209.98.146.184]:57162 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263200AbTDRSjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:39:20 -0400
Date: Fri, 18 Apr 2003 13:51:17 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030418185117.GK29143@iucha.net>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com> <20030415160530.2520c61c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEfPc/DjvCj+JzNg"
Content-Disposition: inline
In-Reply-To: <20030415160530.2520c61c.akpm@digeo.com>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEfPc/DjvCj+JzNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 04:05:30PM -0700, Andrew Morton wrote:
> The NMI watchdog hit is nasty:
>=20
> NMI Watchdog detected LOCKUP on CPU0, eip c011eb82, registers:
> CPU:    0
> EIP:    0060:[<c011eb82>]    Tainted: GF  VLI
> EFLAGS: 00200086
> EIP is at .text.lock.sched+0x10c/0x12a
> eax: d79c8000   ebx: d8c578fc   ecx: 00000000   edx: d8c57800
> esi: c03a9d20   edi: d774a0c0   ebp: d79c9d94   esp: d79c9d88
> ds: 007b   es: 007b   ss: 0068
> Process gkrellm (pid: 458, threadinfo=3Dd79c8000 task=3Ddd7152a0)
> Stack: d8c578fc d7eaa400 d774a0c0 d79c9da4 c0235e80 c03a9d20 d77491a0 d79=
c9db0=20
>        c0265b88 d8c578fc d79c9dbc e0a9d76c d8c578d0 d79c9de0 e0aa1c61 d8c=
57800=20
>        e0a97b62 d7d2f894 00200286 00000008 00000004 e0ab38bc d79c9e08 e0a=
a25f5=20
> Call Trace:
>  [<c0235e80>] kobject_get+0x70/0x80
>  [<c0265b88>] get_device+0x18/0x30
>  [<e0a9d76c>] usb_get_dev+0x1c/0x30 [usbcore]
>  [<e0aa1c61>] hcd_submit_urb+0x71/0x180 [usbcore]
>  [<e0a97b62>] hidinput_report_event+0x32/0x50 [hid]
>  [<e0ab38bc>] usb_hcd_operations+0x0/0x24 [usbcore]
>  [<e0aa25f5>] usb_submit_urb+0x1d5/0x250 [usbcore]
>  [<e0a95274>] hid_irq_in+0x34/0xb0 [hid]
>  [<e0aa2104>] usb_hcd_giveback_urb+0x24/0x40 [usbcore]
>  [<e0a8f23f>] uhci_finish_completion+0x8f/0xf0 [uhci_hcd]
>  [<e0aa214c>] usb_hcd_irq+0x2c/0x60 [usbcore]
>  [<c010d7f8>] handle_IRQ_event+0x38/0x60
>  [<c010da74>] do_IRQ+0xc4/0x190
>  [<c010be0c>] common_interrupt+0x18/0x20
>  [<c016007b>] unregister_chrdev_region+0x2b/0x100
>  [<c0235e2e>] kobject_get+0x1e/0x80
>  [<c018b2a0>] check_perm+0x20/0x120
>  [<c0157aa7>] get_empty_filp+0x77/0x100
>  [<c0155f5f>] dentry_open+0x21f/0x250
>  [<c0155d36>] filp_open+0x66/0x70
>  [<c0164423>] getname+0x93/0xd0
>  [<c01562c5>] sys_open+0x55/0x90
>  [<c010b49f>] syscall_call+0x7/0xb

I've got a similar trace, with 2.5.67-bk8:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00210087
EIP is at 0x0
eax: c0470894   ebx: efc54140   ecx: 00010001   edx: 00000001
esi: 00000000   edi: 00000001   ebp: e7b2de08   esp: e7b2ddec
ds: 007b   es: 007b   ss: 0068
Process phoenix-bin (pid: 873, threadinfo=3De7b2c000 task=3De883f980)
Stack: c011a3f1 c0470894 00000001 00000000 e7b2c000 00200082 00000000 e7b2d=
e28=20
       c011a441 c04709a0 00000001 00000001 00000000 c04709a0 eef36c88 00000=
000=20
       c02e31ca edcf8900 0000001d 00020001 efc8b380 efc8b3dc 00000001 e7b2d=
e60=20
Call Trace:
 [<c011a3f1>] __wake_up_common+0x31/0x50
 [<c011a441>] __wake_up+0x31/0x60
 [<c02e31ca>] mousedev_event+0xca/0x2b0
 [<c02e1a5d>] input_event+0xdd/0x360
 [<c02e16c1>] hidinput_report_event+0x31/0x50
 [<c02dede2>] hid_input_report+0xa2/0xe0
 [<c02deec1>] hid_irq_in+0xa1/0xb0
 [<c02d2bd5>] usb_hcd_giveback_urb+0x25/0x40
 [<c02dca6a>] dl_done_list+0xea/0x100
 [<c02dd43b>] ohci_irq+0xeb/0x160
 [<c02d2c1d>] usb_hcd_irq+0x2d/0x60
 [<c010cda8>] handle_IRQ_event+0x38/0x60
 [<c010cfa7>] do_IRQ+0x97/0x120
 [<c010b4e4>] common_interrupt+0x18/0x20

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--PEfPc/DjvCj+JzNg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oEklNLPgdTuQ3+QRAmn+AJ4mzf9GRe2+0rqqBgoLXIf64FVG1wCbBxyD
tw87ZDxGcILaXIAS6F0o/mY=
=MF+X
-----END PGP SIGNATURE-----

--PEfPc/DjvCj+JzNg--
