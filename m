Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUJWNAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUJWNAq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUJWNAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:00:46 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:8971 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261162AbUJWNAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:00:02 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.9 SMP: via-rhine cannot be upped.
Date: Sat, 23 Oct 2004 15:59:28 +0300
User-Agent: KMail/1.5.4
Cc: Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wWleBRFFIcZ2ZEK"
Message-Id: <200410231559.28215.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wWleBRFFIcZ2ZEK
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I reported this yesterday but somehow managed to mess up configs
and accidentally compiled 2.6.9 for SMP! :(

I just checked that it does not happen on non-SMP 2.6.9.
2.6.9-preempt is working too.

Here goes a problem description again.

I have an onboard VIA eth:

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 A=
GP]
00:0a.0 Network controller: Texas Instruments ACX 111 54Mbps Wireless Inter=
face
00:0c.0 Network controller: Harris Semiconductor D-Links DWL-g650 A1 (rev 0=
1)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8=
237 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =
74)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX =
400] (rev a1)

It cannot be upped:

# ip l set dev if up
SIOCSIFFLAGS: Function not implemented
# ifconfig if up
SIOCSIFFLAGS: Function not implemented
# busybox ip l set dev if up
SIOCSIFFLAGS: Function not implemented

(NB: ip and ifconfig are not busyboxed, they are "standard" ones)

Strace (busybox one is smallest):

execve("/usr/bin/busybox", ["busybox", "ip", "l", "set", "dev", "if", "up"]=
, [/* 28 vars */]) =3D 0
fcntl64(0, F_GETFD) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0
fcntl64(1, F_GETFD) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0
fcntl64(2, F_GETFD) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0
uname({sys=3D"Linux", node=3D"shadow", ...}) =3D 0
geteuid32() =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0
getuid32() =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=3D 0
getegid32() =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0
getgid32() =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=3D 0
brk(0) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
=3D 0x81ab000
brk(0x81ac000) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=3D 0x81a=
c000
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 4
ioctl(4, 0x8913, 0xbffff9e0) =9A =9A =9A =9A =9A =9A=3D 0
ioctl(4, 0x8914, 0xbffff9e0) =9A =9A =9A =9A =9A =9A=3D -1 ENOSYS (Function=
 not implemented)
dup(2) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
=3D 5
fcntl64(5, F_GETFL) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =3D 0x2 (flags =
O_RDWR)
fstat64(5, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(136, 2), ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40000000
_llseek(5, 0, 0xbffff830, SEEK_CUR) =9A =9A =3D -1 ESPIPE (Illegal seek)
write(5, "SIOCSIFFLAGS: Function not imple"..., 39) =3D 39
close(5) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=3D=
 0
munmap(0x40000000, 4096) =9A =9A =9A =9A =9A =9A =9A =9A=3D 0
close(4) =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=3D=
 0
write(2, "BusyBox v1.00-pre8 (2004.03.31-2"..., 295) =3D 295
_exit(1)

I booted with init=3D/bin/sh and ran 'ip l set dev eth0 up'
=2D it fails under 2.6.9-smp. This rules out my userspace setup
being somehow involved (for example, the fact that I rename iface
from 'eth0' to 'if' does not contribute to the bug).

My 2.6.9-smp config is attached.
=2D-
vda

--Boundary-00=_wWleBRFFIcZ2ZEK
Content-Type: application/x-bzip2;
  name=".config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=".config.bz2"

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

--Boundary-00=_wWleBRFFIcZ2ZEK--

