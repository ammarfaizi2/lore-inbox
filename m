Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVBGJvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVBGJvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBGJvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:51:08 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:52202 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261381AbVBGJur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:50:47 -0500
Message-ID: <420739E7.8050707@tequila.co.jp>
Date: Mon, 07 Feb 2005 18:50:31 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops in 2.6.8.1
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

today, just 30min ago I found this in my messages file:

The box is a Debian/Testing with a self compiled 2.6.8.1

ramen:~# lsmod
Module                  Size  Used by
loop                   13704  4
ntfs                  131188  2
appletalk              34384  20
ipx                    28324  0
p8022                   2688  1 ipx
psnap                   3972  2 appletalk,ipx
llc                     6676  2 p8022,psnap
usbcore               102628  0

ramen:~# lspci
0000:00:00.0 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE
chipset) (rev 13)
0000:00:00.1 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE chipset)
0000:00:00.2 Host bridge: ServerWorks CMIC-LE
0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:00:04.0 System peripheral: Compaq Computer Corporation Integrated
Lights Out Controller (rev 01)
0000:00:04.2 System peripheral: Compaq Computer Corporation Integrated
Lights Out  Processor (rev 01)
0000:00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 05)
0000:00:0f.3 Host bridge: ServerWorks CSB5 LPC bridge
0000:00:10.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:10.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:01:03.0 RAID bus controller: Compaq Computer Corporation Smart
Array 5i/532 (rev 01)
0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5703X Gigabit Ethernet (rev 02)
0000:02:02.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5703X Gigabit Ethernet (rev 02)
0000:03:01.0 RAID bus controller: Compaq Computer Corporation Smart
Array 64xx (rev 01)
0000:06:02.0 SCSI storage controller: Adaptec ASC-29320LP U320 (rev 03)
0000:06:1e.0 PCI Hot-plug controller: Compaq Computer Corporation PCI
Hotplug Controller (rev 14)

ramen:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v
- --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
- --mandir=/usr/share/man --infodir=/usr/share/info
- --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
- --with-system-zlib --enable-nls --without-included-gettext
- --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
- --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-5)

I have an external SW Raid5 with XFS shared as NFS, samba and appletalk,
and internal HW RAID5 also XFS shared as NFS< samba and appletalk.

there is one external FS mounted via NFS and one via CIFS.

 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error unlocking previously locked range -5 during test of lock
 CIFS VFS: Error unlocking previously locked range -5 during test of lock
 CIFS VFS: Error unlocking previously locked range -5 during test of lock
Unable to handle kernel paging request at virtual address 91982aca
 printing eip:
c02180d4
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: loop ntfs appletalk ipx p8022 psnap llc usbcore
CPU:    1
EIP:    0060:[<c02180d4>]    Not tainted
EFLAGS: 00010246   (2.6.8.1)
EIP is at cifs_readdir+0x961/0xd75
eax: c050c480   ebx: d3b79f4c   ecx: f7db1340   edx: 91982a8e
esi: 00000000   edi: e9048bce   ebp: d3b79f68   esp: d3b79ee0
ds: 007b   es: 007b   ss: 0068
Process smbd (pid: 30224, threadinfo=d3b78000 task=cbc4b290)
Stack: d3b79f4c e70d41e0 cc0e8480 c050c480 d3b79fa0 c050c480 d3b79f34
d3b79f38
       00000001 000003e9 e70d4000 91982a8e c229ab00 dec6bb80 f7db1340
00000009
       00004000 000c0451 00000000 4204f254 33390598 00000001 00000000
000a1800
Call Trace:
 [<c0105cb7>] show_stack+0x80/0x96
 [<c0105e4e>] show_registers+0x15f/0x1ae
 [<c0105fc3>] die+0x8d/0xfb
 [<c01189cd>] do_page_fault+0x2c4/0x56e
 [<c0105961>] error_code+0x2d/0x38
 [<c01683de>] vfs_readdir+0x96/0xb1
 [<c0168802>] sys_getdents64+0x6d/0xa6
 [<c0104ed7>] syscall_call+0x7/0xb
Code: 8b 42 3c d1 e8 89 44 24 08 89 d0 83 c0 40 89 44 24 04 89 04
 <3> CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xffffffec or on cifs_get_inode_info in lookup
 CIFS VFS: Error unlocking previously locked range -5 during test of lock
 CIFS VFS: Error unlocking previously locked range -5 during test of lock


- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBznnjBz/yQjBxz8RAoGEAKCyuIrRwWib13rd2+Iv4GLqU/4WmACgqNct
GuU5sGARIIyy23kFChrh7IE=
=IOhj
-----END PGP SIGNATURE-----
