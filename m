Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132845AbRDPEst>; Mon, 16 Apr 2001 00:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132851AbRDPEsa>; Mon, 16 Apr 2001 00:48:30 -0400
Received: from linas.org ([207.170.121.1]:4088 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132845AbRDPEsY>;
	Mon, 16 Apr 2001 00:48:24 -0400
Date: Sun, 15 Apr 2001 23:47:06 -0500
To: linux-kernel@vger.kernel.org, russell@coker.com.au, almesber@lrc.epfl.ch,
        johninsd@san.rr.com
Subject: lilo + raid + kernel-2.4.x failure to boot
Message-ID: <20010415234706.A865@backlot.linas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: linas@backlot.linas.org (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

another zinger that I am sending to LKML because I don't know where else to=
 send it ...

I've discovered a deadly combination of kernel & lilo (and raid).  This may=
 be a pure
lilo bug, but I assume that the kernel+raid aids & abets the problem...:


I am running kernel-2.4.x.  Two ide hard drives, with partitions 1,5,6,7,8 =
in use.
The partitions on the two drives are mirrored using RAID-1 to create /dev/m=
d1, /dev/md5,
/dev/md6, etc.  The root fs is on /dev/md1.  Thus, lilo.conf looks like:


boot=3D/dev/md1
map=3D/boot/map
install=3D/boot/boot.b
prompt
timeout=3D50
linear
default=3Dlinux

image=3D/boot/vmlinuz-2.4.2
        label=3Dlinux
        read-only
        root=3D/dev/md1

For nearly a year, this combo has worked just fine (running 2.3.99 back the=
n).  =20

Just fine, that is, using the redhat-6.2 rpm for LILO, i.e. version=20
lilo-0.21-15.i386.rpm  which reports itself to be:=20

% /sbin/lilo -V
LILO version 21

Recently, this machine went over to debian-unstable from redhat:=20

% dpkg -s lilo
Package: lilo
Status: install ok installed
Priority: important
Section: base
Installed-Size: 271
Maintainer: Russell Coker <russell@coker.com.au>
Version: 1:21.7-3
Depends: libc6 (>=3D 2.2.1-2), debconf (>=3D 0.2.26), logrotate

The debian version of lilo writes a boot sector that hangs hard for the abo=
ve
kernel+raid+lilo.conf configuration: specifically:=20

LIL-     after a reboot.   Needless to say, recovery was painful.  But I wa=
s able to verify
that the redhat lilo rpm always functioned correctly, and the debian-unstab=
le dpkg always
hung in this way.  Although at one point, during my twisting & turning, I g=
ot the debian lilo
to get to only LI  before hanging.  I have no idea of what I did different =
to get to that as
opposed to LIL-=20


BTW, I noticed that oddly, every time I ran lilo, and then ran lilo -q -v -=
v, it reported
different sector numbers for the kernel images.  This freaked me out at fir=
st, but I came to
accept it as normal: doesn't affect bootability.  But is this really w.a.d?=
  (I was
assuming, appearently erroneously, that lilo -q -v -v was reporting the phy=
sical location
of the kernel image on the disk; but since the numbers bounce around, that =
can't be right.
Or is this just weird bios head/cyl/sect math flakiness?)


--linas

=20




--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE62nlGZKmaggEEWTMRAjIXAKCBtPtRDSUeMOFxXn5vj7M3XiF1xgCdEFUk
irQ9rXxstfZMid6jey5ZCqk=
=9tAq
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
