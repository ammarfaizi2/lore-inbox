Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757054AbWK2A1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbWK2A1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757517AbWK2A1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:27:05 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:18934 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1757054AbWK2A1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:27:03 -0500
Date: Tue, 28 Nov 2006 19:24:45 -0500
From: Thomas Tuttle <linux-kernel@ttuttle.net>
Subject: Re: 2.6.19-rc6-mm2
In-reply-to: <20061128020246.47e481eb.akpm@osdl.org>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mail-followup-to: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <20061129002411.GA1178@lion>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=OwLcNYc0lM97+oe1
Content-disposition: inline
References: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've found a couple of bugs so far...

1. I did `modprobe kvm' and then tried running a version of the KVM Qemu
compiled for a different kernel.  My mistake.  But I got an oops:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000008
 printing eip:
f91f9c3f
*pde =3D 00000000
Oops: 0000 [#1]
SMP=20
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_max_freq
Modules linked in: kvm iTCO_wdt i8k rfcomm l2cap rtc sdhci mmc_block mmc_co=
re hci_usb bluetooth b44 mii ohci1394 ieee1394 uhci_hcd ehci_hcd usbcore ps=
mouse evdev i915 drm cpuid msr speedstep_centrino video thermal processor f=
an container button battery ac
CPU:    0
EIP:    0060:[<f91f9c3f>]    Not tainted VLI
EFLAGS: 00010202   (2.6.19-rc6-mm1 #1)
EIP is at kvm_vmx_return+0xef/0x4d0 [kvm]
eax: e5490068   ebx: 00000000   ecx: 00000000   edx: e5491ca4
esi: 00000000   edi: e5490060   ebp: e5a4fde0   esp: e5a4fd54
ds: 007b   es: 007b   ss: 0068
Process qemu (pid: 24193, ti=3De5a4e000 task=3Dc2286a90 task.ti=3De5a4e000)
Stack: 00000002 00000001 f7fe1278 00000002 b7f92000 e5490000 00000000 00000=
000=20
       e5a4fdac 00000000 000000d8 f783a580 e5a4fdac c043b98a bfb93f7c f91fa=
020=20
       e5a4fde0 bfb93f7c bfb93f7c f91fa0cb 000004f3 c03fb974 e5490000 00000=
000=20
Call Trace:
 [<f91fa020>] kvm_dev_ioctl+0x0/0x1040 [kvm]
 [<f91fa0cb>] kvm_dev_ioctl+0xab/0x1040 [kvm]
 [<c03fb974>] error_code+0x7c/0x84
 [<c011d469>] kmap_atomic+0xc9/0xe0
 [<c018007b>] permission+0x2b/0xd0
 [<c01700d8>] sys_swapon+0x978/0xaf0
 [<c011d263>] kunmap_atomic+0x63/0x70
 [<c011d469>] kmap_atomic+0xc9/0xe0
 [<c011d263>] kunmap_atomic+0x63/0x70
 [<c015cdbd>] get_page_from_freelist+0x27d/0x340
 [<c011d469>] kmap_atomic+0xc9/0xe0
 [<c011d263>] kunmap_atomic+0x63/0x70
 [<c015cdbd>] get_page_from_freelist+0x27d/0x340
 [<c0157af0>] find_get_page+0x20/0x60
 [<c015a75c>] filemap_nopage+0x2dc/0x490
 [<c0178a47>] do_sync_read+0xc7/0x110
 [<c011d469>] kmap_atomic+0xc9/0xe0
 [<c011d263>] kunmap_atomic+0x63/0x70
 [<c0166386>] __handle_mm_fault+0x246/0x9c0
 [<f91fa020>] kvm_dev_ioctl+0x0/0x1040 [kvm]
 [<c030ae02>] scsi_host_alloc+0x202/0x2a0
  [<c018430b>] do_ioctl+0x2b/0x90
 [<c01843cc>] vfs_ioctl+0x5c/0x2b0
 [<c018465d>] sys_ioctl+0x3d/0x70
 [<c0103238>] syscall_call+0x7/0xb
 [<c030ae02>] scsi_host_alloc+0x202/0x2a0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 14 0f 87 77 02 00 00 8b 0c b5 00 15 20 f9 85 c9 0f 84 68 02 00 00 89 =
ea 89 f8 ff d1 85 c0 0f 84 4c 02 00 00 89 f8 e8 31 e9 ff ff <65> a1 08 00 0=
0 00 8b 40 04 8b 40 08 a8 04 0f 85 ae 02 00 00 e8=20
EIP: [<f91f9c3f>] kvm_vmx_return+0xef/0x4d0 [kvm] SS:ESP 0068:e5a4fd54
 msrs: 2

Oh, and I get a ton of these messages with kvm:

rtc: lost some interrupts at 1024Hz.

2. I'm not sure if this bug is in the kernel, wireless tools, or the
ipw3945 driver, but I haven't changed the version of anything but the
kernel.  When I do `iwconfig eth1 essid foobar' something drops the
last character of the essid, and a subsequent `iwconfig eth1' shows
"fooba" as the essid.  And it's actually set as "fooba", since I had
to do `iwconfig eth1 essid MyUsualEssid_' (note underscore) to get on
to my usual network.

--Thomas Tuttle

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFbNNNgPpxLpYWreERAp8bAJ48VknjlZtCivvjjqlSiJdv4F2VgwCdHDax
LfqCNa9zIE57eaaxcXP8DRc=
=XSRk
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
