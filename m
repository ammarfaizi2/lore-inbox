Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTDRPQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTDRPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:16:35 -0400
Received: from iucha.net ([209.98.146.184]:7751 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263098AbTDRPQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:16:28 -0400
Date: Fri, 18 Apr 2003 10:28:24 -0500
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030418152824.GJ29143@iucha.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net> <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk> <20030416131536.GF29143@iucha.net> <20030416135819.GB18358@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fKov5AqTsvseSZ0Z"
Content-Disposition: inline
In-Reply-To: <20030416135819.GB18358@suse.de>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 02:58:19PM +0100, Dave Jones wrote:
> On Wed, Apr 16, 2003 at 08:15:36AM -0500, Florin Iucha wrote:
>=20
>  > 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
>  > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL
>  > [Radeon 8500 LE]
>  >=20
>  > Maybe the AGP code is trying to push some bits in the wrong
>  > port/address?
>=20
> SiS driver internals haven't changed (at least not under my hands),
> so it should be poking the same bits in the same registers as the
> 2.4 driver does. The only 'bits in wrong address' type bug outstanding
> in agpgart is that the gatt_table address is potentially allocated as
> a 64bit address and truncated to fit into 32bits, but that will only bite
> you on a 64bit host that uses the generic gatt allocation routines.
> (Namely x86-64).

With 2.5.67-bk8, agpgart and sis-agp compiled as modules and loaded:
   - X starts (I am using wdm as display manager)
   - direct rendering is enabled, according to /var/log/XFree86.0.log
   - start glxgears
   - framerate 130!!! It should be around 1900-2000 on my hardware
     (moons ago on XFree 4.2.1 + DRI snapshot)
   - after 15-20 seconds, the X session is restarted - back to wdm
     screen
   - I login, I logout and the machine freeze
   - the last words on serial console:
      [drm] Loading R200 Microcode
      double fault, gdt at c039df00 [255 bytes]
      double fault, tss at c0418800
      eip =3D c0143a00, esp =3D ececbf0c
      eax =3D ee37dc60, ebx =3D ee37dc40, ecx =3D 0000007b, edx =3D 00000000
      esi =3D ee37dc60, edi =3D edc0e0c0

With 2.5.67-bk8, agpgart and sis-agp built in:
   - no lockups
   - direct rendering is disabled
   - X crashes sometimes with the following traces:

eth0: Media Link On 100mbps full-duplex=20
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
agpgart: Found an AGP 2.0 compliant device.
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device.
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
[drm] Loading R200 Microcode
Unable to handle kernel paging request at virtual address fffffff0
 printing eip:
c0146147
*pde =3D 00001067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0146147>]    Not tainted
EFLAGS: 00013286
EIP is at page_remove_rmap+0xb7/0x130
eax: ffffffff   ebx: c14acc48   ecx: 0000000f   edx: fffffff0
esi: dcd5ffc0   edi: ffffffff   ebp: fffffff0   esp: da333b60
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 657, threadinfo=3Dda332000 task=3Dde0ced00)
Stack: dcb72cc0 dcd5ffc0 da403a18 da403a18 0006e000 00100000 c14acc48 c0140=
495=20
       c14acc48 da332000 da332000 00000000 1deb5045 dc8b5084 08618000 08318=
000=20
       c0465758 c014053b c0465758 dc8b5080 08218000 00100000 08218000 dc8b5=
084=20
Call Trace:
 [<c0140495>] zap_pte_range+0x155/0x1b0
 [<c014053b>] zap_pmd_range+0x4b/0x70
 [<c01405a3>] unmap_page_range+0x43/0x70
 [<c0140694>] unmap_vmas+0xc4/0x220
 [<c01444cb>] exit_mmap+0x7b/0x190
 [<c011bc44>] mmput+0x54/0xb0
 [<c0159203>] exec_mmap+0xb3/0x130
 [<c0159309>] flush_old_exec+0x19/0x850
 [<c0159140>] kernel_read+0x50/0x60
 [<c0175525>] load_elf_binary+0x2d5/0xb50
 [<c01651e2>] dput+0x22/0x1e0
 [<c021a187>] linvfs_readv+0x47/0x50
 [<c0175250>] load_elf_binary+0x0/0xb50
 [<c0159e7a>] search_binary_handler+0x8a/0x1d0
 [<c015a1d1>] do_execve+0x211/0x260
 [<c01093e0>] sys_execve+0x50/0x80
 [<c010ab77>] syscall_call+0x7/0xb

Code: 8b 02 89 c5 83 e5 f0 74 04 0f 0d 45 00 89 c1 83 e1 0f 83 f9=20
 <6>note: XFree86[657] exited with preempt_count 2
Unable to handle kernel paging request at virtual address 081e5788
 printing eip:
c0164857
*pde =3D 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0164857>]    Not tainted
EFLAGS: 00013206
EIP is at locks_remove_posix+0x97/0x110
eax: de0ced00   ebx: dd6dfd20   ecx: 00000000   edx: 081e5760
esi: de84b040   edi: de84b040   ebp: 00000000   esp: da333988
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 657, threadinfo=3Dda332000 task=3Dde0ced00)
Stack: 000003e8 00000005 0000000d 00000032 00000000 00000000 da3339c0 c0119=
948=20
       de84b040 00000291 00003092 00000000 de3064c0 00000201 00000000 00000=
000=20
       ffffffff 7fffffff 00000000 da332000 00003296 00000000 00100000 de826=
ac0=20
Call Trace:
 [<c0119948>] try_to_wake_up+0x128/0x1d0
 [<c014ea5c>] filp_close+0x8c/0xd0
 [<c011ecb7>] put_files_struct+0x57/0xc0
 [<c011f816>] do_exit+0x146/0x370
 [<c010bbb1>] die+0xe1/0xf0
 [<c0118a2a>] do_page_fault+0x14a/0x457
 [<c01355b0>] do_generic_mapping_read+0x1a0/0x3b0
 [<c0168409>] update_atime+0xd9/0xe0
 [<c0135a89>] __generic_file_aio_read+0x1b9/0x200
 [<c01357c0>] file_read_actor+0x0/0x110
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38
 [<c0146147>] page_remove_rmap+0xb7/0x130
 [<c0140495>] zap_pte_range+0x155/0x1b0
 [<c014053b>] zap_pmd_range+0x4b/0x70
 [<c01405a3>] unmap_page_range+0x43/0x70
 [<c0140694>] unmap_vmas+0xc4/0x220
 [<c01444cb>] exit_mmap+0x7b/0x190
 [<c011bc44>] mmput+0x54/0xb0
 [<c0159203>] exec_mmap+0xb3/0x130
 [<c0159309>] flush_old_exec+0x19/0x850
 [<c0159140>] kernel_read+0x50/0x60
 [<c0175525>] load_elf_binary+0x2d5/0xb50
 [<c01651e2>] dput+0x22/0x1e0
 [<c021a187>] linvfs_readv+0x47/0x50
 [<c0175250>] load_elf_binary+0x0/0xb50
 [<c0159e7a>] search_binary_handler+0x8a/0x1d0
 [<c015a1d1>] do_execve+0x211/0x260
 [<c01093e0>] sys_execve+0x50/0x80
 [<c010ab77>] syscall_call+0x7/0xb

Code: 0f b6 42 28 24 01 84 c0 74 05 39 72 14 74 44 89 d3 8b 03 85=20
 <6>note: XFree86[657] exited with preempt_count 3
Unable to handle kernel paging request at virtual address 09373844
 printing eip:
c0143a33
*pde =3D 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c0143a33>]    Not tainted
EFLAGS: 00013202
EIP is at find_vma+0x33/0x60
eax: 0937383c   ebx: bfffe76c   ecx: 00000000   edx: 09373854
esi: de826ac0   edi: de0ced00   ebp: bfffe76c   esp: da257f04
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 658, threadinfo=3Dda256000 task=3Dde0ced00)
Stack: de826ac0 de826ae0 c0118a68 de826ac0 bfffe76c 081c959c 00000001 00000=
001=20
       dc4b8c00 00000000 00000000 00030001 00000000 00000000 40000000 40000=
000=20
       00000000 00000000 00000000 00000000 08754c28 08768ed4 00000000 00000=
000=20
Call Trace:
 [<c0118a68>] do_page_fault+0x188/0x457
 [<c014ea63>] filp_close+0x93/0xd0
 [<c014ea63>] filp_close+0x93/0xd0
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38

Code: 39 58 08 76 1a 39 58 04 89 c1 76 07 8b 52 0c 85 d2 75 ea 85=20
 unmap_vmas: VMA list is not sorted correctly!
------------[ cut here ]------------
kernel BUG at mm/mmap.c:1417!
invalid operand: 0000 [#4]
CPU:    0
EIP:    0060:[<c01445d2>]    Not tainted
EFLAGS: 00013202
EIP is at exit_mmap+0x182/0x190
eax: fffff8f1   ebx: 00000002   ecx: 00000000   edx: 00000000
esi: de826ac0   edi: da256000   ebp: de0ced00   esp: da257d9c
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 658, threadinfo=3Dda256000 task=3Dde0ced00)
Stack: da257db4 de826ac0 dc4b8e80 00000000 ffffffff da257db8 c0465758 00000=
70f=20
       de826ac0 00000000 00000000 c011bc44 de826ac0 c03b4fdc de826ac0 c011f=
7dd=20
       de826ac0 de826ac0 00000001 0000007b da256000 da257ed0 de0ced00 09373=
844=20
Call Trace:
 [<c011bc44>] mmput+0x54/0xb0
 [<c011f7dd>] do_exit+0x10d/0x370
 [<c010bbb1>] die+0xe1/0xf0
 [<c0118a2a>] do_page_fault+0x14a/0x457
 [<c0138941>] buffered_rmqueue+0xb1/0x150
 [<c0138a72>] __alloc_pages+0x92/0x2c0
 [<c013d945>] invalidate_vcache+0x35/0xf0
 [<c014110d>] do_wp_page+0x1cd/0x370
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38
 [<c0143a33>] find_vma+0x33/0x60
 [<c0118a68>] do_page_fault+0x188/0x457
 [<c014ea63>] filp_close+0x93/0xd0
 [<c014ea63>] filp_close+0x93/0xd0
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38

Code: 0f 0b 89 05 a6 50 37 c0 e9 06 ff ff ff 90 83 ec 28 89 5c 24=20
 <6>note: XFree86[658] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 081e5788
 printing eip:
c0164857
*pde =3D 1c19e067
*pte =3D 00000000
Oops: 0000 [#5]
CPU:    0
EIP:    0060:[<c0164857>]    Not tainted
EFLAGS: 00013206
EIP is at locks_remove_posix+0x97/0x110
eax: de0ced00   ebx: dd6dfd20   ecx: 00000000   edx: 081e5760
esi: df2f8e40   edi: df2f8e40   ebp: 00000000   esp: da257bd8
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 658, threadinfo=3Dda256000 task=3Dde0ced00)
Stack: 000003e8 00000005 0000000d 00000032 00000000 00000000 da257c10 c0119=
948=20
       df2f8e40 00000292 00003092 00000000 de3064c0 00000201 00000000 00000=
000=20
       ffffffff 7fffffff 00000000 da256000 00003292 00000032 da257c50 00003=
292=20
Call Trace:
 [<c0119948>] try_to_wake_up+0x128/0x1d0
 [<c014ea5c>] filp_close+0x8c/0xd0
 [<c011ecb7>] put_files_struct+0x57/0xc0
 [<c010bf30>] do_invalid_op+0x0/0xd0
 [<c011f816>] do_exit+0x146/0x370
 [<c010bf30>] do_invalid_op+0x0/0xd0
 [<c010bbb1>] die+0xe1/0xf0
 [<c010bff9>] do_invalid_op+0xc9/0xd0
 [<c01445d2>] exit_mmap+0x182/0x190
 [<c011a3f1>] __wake_up_common+0x31/0x50
 [<c011df1d>] printk+0x11d/0x180
 [<c010b581>] error_code+0x2d/0x38
 [<c01445d2>] exit_mmap+0x182/0x190
 [<c011bc44>] mmput+0x54/0xb0
 [<c011f7dd>] do_exit+0x10d/0x370
 [<c010bbb1>] die+0xe1/0xf0
 [<c0118a2a>] do_page_fault+0x14a/0x457
 [<c0138941>] buffered_rmqueue+0xb1/0x150
 [<c0138a72>] __alloc_pages+0x92/0x2c0
 [<c013d945>] invalidate_vcache+0x35/0xf0
 [<c014110d>] do_wp_page+0x1cd/0x370
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38
 [<c0143a33>] find_vma+0x33/0x60
 [<c0118a68>] do_page_fault+0x188/0x457
 [<c014ea63>] filp_close+0x93/0xd0
 [<c014ea63>] filp_close+0x93/0xd0
 [<c01188e0>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38

Code: 0f b6 42 28 24 01 84 c0 74 05 39 72 14 74 44 89 d3 8b 03 85=20
 <6>note: XFree86[658] exited with preempt_count 2
mtrr: MTRR 1 not used
mtrr: MTRR 1 not used
serio: kseriod exiting
Shutting down devices
Power down.
acpi_power_off called

With the same .config but with 67-ac2 the machine hungs with similar
traces on the serial console.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--fKov5AqTsvseSZ0Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oBmYNLPgdTuQ3+QRAiLaAKCXV4ERXTE8FEMeZdH52vtqu465CACglKxQ
oIKLBNSzI642F3YL69ExPQU=
=3+/F
-----END PGP SIGNATURE-----

--fKov5AqTsvseSZ0Z--
