Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSBZSlv>; Tue, 26 Feb 2002 13:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBZSlf>; Tue, 26 Feb 2002 13:41:35 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:24327 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S292681AbSBZSlD>;
	Tue, 26 Feb 2002 13:41:03 -0500
Date: Tue, 26 Feb 2002 19:40:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Message-ID: <20020226184043.GA10420@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i have been looking for deadlocks we are experiencing on a couple of=20
SMP machines (Dual Celeron and Dual PIII). After a night stressing a
spare machine with dbench/bonnie++/tcpspray the machine locked up 30
minutes after i killed the test. The last messages on the console were:

__block_prepare_write: zeroing uptodate buffer!

15 times - Machine was answering ping first but stopped after a couple
of minutes. Another couple of minutes later the nmi_watchdog stepped in
and produced an oops:


ksymoops 2.3.4 on i686 2.4.18-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre4/ (default)
     -m /boot/System.map-2.4.18-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c01cc34d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: c0094000   ebx: c0096d2c   ecx: 00000002   edx: 00000000
esi: f880a000   edi: c0094084   ebp: c0094084   esp: f7ddbe80
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_2 (pid: 8, stackpage=3Df7ddb000)
Stack: 0000001e f880a000 c0094084 00000000 00000001 00000009 c0096c16 00000=
086=20
       f880a000 c0094084 00000000 c01cb2b2 00000000 000186a0 c0094084 00000=
000=20
       00000002 00000000 00000018 c01c8e74 00000012 c0094084 00000000 c0094=
084=20
Call Trace: [<c01cb2b2>] [<c01c8e74>] [<c01c9036>] [<c01cbde4>] [<c01b7e25>=
]=20
   [<c01b85a7>] [<c01b8b1b>] [<c01056f4>]=20
Code: 7e f9 e9 4f d0 ff ff 80 3f 00 f3 90 7e f9 e9 53 da ff ff 80=20

>>EIP; c01cc34d <_text_lock_gdth+e1/154>   <=3D=3D=3D=3D=3D
Trace; c01cb2b2 <gdth_interrupt+6ce/6d8>
Trace; c01c8e74 <gdth_wait+5c/ac>
Trace; c01c9036 <gdth_internal_cmd+172/1b8>
Trace; c01cbde4 <gdth_eh_bus_reset+1b4/36c>
Trace; c01b7e25 <scsi_try_bus_reset+89/118>
Trace; c01b85a7 <scsi_unjam_host+357/72c>
Trace; c01b8b1b <scsi_error_handler+19f/1f9>
Trace; c01056f4 <kernel_thread+28/38>
Code;  c01cc34d <_text_lock_gdth+e1/154>
00000000 <_EIP>:
Code;  c01cc34d <_text_lock_gdth+e1/154>   <=3D=3D=3D=3D=3D
   0:   7e f9                     jle    fffffffb <_EIP+0xfffffffb> c01cc34=
8 <_text_lock_gdth+dc/154>   <=3D=3D=3D=3D=3D
Code;  c01cc34f <_text_lock_gdth+e3/154>
   2:   e9 4f d0 ff ff            jmp    ffffd056 <_EIP+0xffffd056> c01c93a=
3 <gdth_next+53/b5c>
Code;  c01cc354 <_text_lock_gdth+e8/154>
   7:   80 3f 00                  cmpb   $0x0,(%edi)
Code;  c01cc357 <_text_lock_gdth+eb/154>
   a:   f3 90                     repz nop=20
Code;  c01cc359 <_text_lock_gdth+ed/154>
   c:   7e f9                     jle    7 <_EIP+0x7> c01cc354 <_text_lock_=
gdth+e8/154>
Code;  c01cc35b <_text_lock_gdth+ef/154>
   e:   e9 53 da ff ff            jmp    ffffda66 <_EIP+0xffffda66> c01c9db=
3 <gdth_next+a63/b5c>
Code;  c01cc360 <_text_lock_gdth+f4/154>
  13:   80 00 00                  addb   $0x0,(%eax)


1 warning issued.  Results may not be reliable.


Software: 2.4.18-pre4, ext2 filesystems, no highmem
Hardware: Dual PIII 1GHz, 1GB Ram,
	ICP Vortex GDT6523RS ( 6 Disks with hardware raid 1 )
	GDTH Firmware is latest 2.28.06-R049

I am now booting with 2.4.19-pre1 and will try to crash it again
tonight.

Flo
--
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8e9aqUaz2rXW+gJcRAinaAKCmUY6N4LaxpfUZb7h57i7lE+191QCgjVmL
VXgZYoQXEys85021JKdWmlA=
=JAPT
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
