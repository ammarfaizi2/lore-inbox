Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTJ3PC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTJ3PC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:02:29 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:31398 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262558AbTJ3PCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:02:08 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 16:01:55 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_jfSo/8QiF4cYynU";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310301601.55588.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_jfSo/8QiF4cYynU
Content-Type: multipart/mixed;
  boundary="Boundary-01=_jfSo/dN6Gg44tNC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_jfSo/dN6Gg44tNC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The config=
=2Egz=20
is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda' newly starte=
d=20
processes die due to a received SIGSEGV. No bad kernel messages appear...

Disabling TCQ again doesn't help, only e reboot does...
When I let the kernel enable TCQ at boot time, it set the TCQ buffer depth =
to=20
8 and even the init script was killed!

Here some additional information:

schlicht@bigboss:~> uname -a
Linux bigboss 2.6.0-test9-mm1 #1 Thu Oct 30 14:45:35 CET 2003 i686 unknown=
=20
unknown GNU/Linux
schlicht@bigboss:~> hdparm -i /dev/hda

/dev/hda:

 Model=3DIBM-DTLA-307030, FwRev=3DTX4OA50C, SerialNo=3DYK0YKT61943
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D40
 BuffType=3DDualPortCache, BuffSize=3D1916kB, MaxMultSect=3D16, MultSect=3D=
16
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D60036480
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

 * signifies the current active mode

schlicht@bigboss:~> hdparm -i /dev/hdb
/dev/hdb: No such device or address
schlicht@bigboss:~> cat /proc/ide/via
=2D---------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.38
South Bridge:                       VIA vt8235
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xec00
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
=2D----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
=2D------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA      UDMA
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          22ns     600ns     120ns      60ns
Transfer Rate:   88.8MB/s   3.3MB/s  16.6MB/s  33.3MB/s
schlicht@bigboss:~> mount
/dev/hda5 on / type reiserfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)
sysfs on /sys type sysfs (rw)
tmpfs on /tmp type tmpfs (rw)


Regards
   Thomas

P.S.: My hdparm version v5.4 sets the queuing depth only to 1 even if I=20
provide e.g. '-Q8'...

--Boundary-01=_jfSo/dN6Gg44tNC
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
hfmntgPBAAA=

--Boundary-01=_jfSo/dN6Gg44tNC--

--Boundary-03=_jfSo/8QiF4cYynU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/oSfjYAiN+WRIZzQRAvqUAJ9473Ug/Va9/T3vceRuFN3lqBx98ACdETeU
CbyPoalAbAn+tNnsAiReVQI=
=Z9wJ
-----END PGP SIGNATURE-----

--Boundary-03=_jfSo/8QiF4cYynU--
