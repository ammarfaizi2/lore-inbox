Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUCDFeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCDFeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:34:44 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:40209 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261388AbUCDFea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:34:30 -0500
Subject: 2.6.3-mm4-rcu_ll SMP memory leak ?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XSYdpwGDSt6//0/rf70G"
Message-Id: <1078378468.22198.10.camel@twins>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 06:34:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XSYdpwGDSt6//0/rf70G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,


I'm running said kernel, and after 5 days I've noticed that all my
memory is gone. Even if I quit every possible application there is
still 600MB+ gone, not in buffers/cache but just used, and no app to
show for it.

I append my current uname,top and lsmod output (while writing this mail)
and as one can see I'm lucky if the RES column adds up to 150m.

is there some way to see how much memory the kernel uses for its
internal structures and then maybe pinpoint the leak?

Kind regards,

Peter Zijlstra



Linux ####### 2.6.3-mm4-rcu_ll #1 SMP Fri Feb 27 09:32:12 CET 2004 i686
AMD Athlon(tm) Processor AuthenticAMD GNU/Linux


top - 06:27:58 up 5 days, 20:51,  2 users,  load average: 0.00, 0.11, 0.20
Tasks:  66 total,   2 running,  63 sleeping,   0 stopped,   1 zombie
Cpu(s):  0.5% us,  0.0% sy,  0.0% ni, 99.5% id,  0.0% wa,  0.0% hi,  0.0% s=
i
Mem:   1033500k total,   910520k used,   122980k free,    26472k buffers
Swap:  2097136k total,     5504k used,  2091632k free,   103088k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND       =
   =20
22169 root      15   0  233m 102m 133m S  1.0 10.1   0:14.74 X             =
   =20
22198 peter     16   0 93524  29m  24m S  0.0  2.9   0:05.39 evolution     =
   =20
22204 peter     16   0 22000 7208  16m S  0.0  0.7   0:00.18 evolution-alar=
m  =20
22202 peter     16   0 24916 6860  19m S  0.0  0.7   0:00.24 evolution-womb=
a  =20
22200 peter     16   0  5992 4040 4092 S  0.0  0.4   0:00.17 gconfd-2      =
   =20
22186 peter     17   0  9812 3744 9328 S  0.0  0.4   0:00.06 gmix          =
   =20
22216 peter     16   0  6808 3496 5752 R  0.0  0.3   0:00.11 Eterm         =
   =20
22178 peter     15   0  5472 3140 4564 S  0.0  0.3   0:00.53 wmaker        =
   =20
22193 peter     15   0  5060 2352 4720 S  0.0  0.2   0:00.02 wmxmms        =
   =20
 3733 peter     16   0  4776 2128 4316 S  0.0  0.2   0:00.29 bonobo-activat=
i  =20
 3491 root      16   0  2096 2088 1848 S  0.0  0.2   0:00.55 ntpd          =
   =20
22191 peter     15   0  2800 1316 2472 S  0.0  0.1   0:00.02 wmpinboard    =
   =20
22217 peter     16   0  2412 1316 2084 S  0.0  0.1   0:00.01 bash          =
   =20
 3646 peter     15   0  2408 1028 2084 S  0.0  0.1   0:00.01 bash          =
   =20
22224 peter     16   0  2028 1028 1816 R  1.0  0.1   0:00.21 top           =
   =20
22189 peter     16   0  2628  960 2448 S  0.0  0.1   0:00.00 wmnetload     =
   =20
22190 peter     16   0  2476  960 2300 S  0.0  0.1   0:00.09 wmclockmon    =
   =20
 3071 root      16   0  4836  956 2904 S  0.0  0.1   0:00.78 cupsd         =
   =20
22157 peter     16   0  2080  944 1904 S  0.0  0.1   0:00.00 startx        =
   =20
11955 root      16   0  2408  940 2084 S  0.0  0.1   0:00.13 bash          =
   =20
22187 peter     16   0  2468  928 2292 S  0.0  0.1   0:00.01 wmmemload     =
   =20
22188 peter     16   0  2472  924 2296 S  0.0  0.1   0:00.02 wmcpuload     =
   =20
  136 root      16   0  1820  788 1512 S  0.0  0.1   0:00.20 devfsd        =
   =20
22192 peter     15   0  2732  736 2576 S  0.0  0.1   0:00.00 docker        =
   =20
22168 peter     18   0  2252  632 2096 S  0.0  0.1   0:00.00 xinit         =
   =20
11953 root      16   0  5628  628 5252 S  0.0  0.1   0:00.19 sshd          =
   =20
 3576 root      17   0  2276  612 1848 S  0.0  0.1   0:00.05 login         =
   =20
 3256 root      16   0  1768  568 1476 S  0.0  0.1   0:00.03 crond         =
   =20
 3526 root      17   0  3060  556 2692 S  0.0  0.1   0:00.23 sshd          =
   =20
 3435 root      19   0  1612  540 1448 S  0.0  0.1   0:00.00 rpc.statd     =
   =20
 3554 root      16   0  1636  532 1348 S  0.0  0.1   0:13.89 syslogd       =
   =20
 3570 root      17   0  1500  480 1332 S  0.0  0.0   0:00.00 agetty        =
   =20
 3567 root      17   0  1500  476 1332 S  0.0  0.0   0:00.00 agetty        =
   =20
 3568 root      17   0  1500  476 1332 S  0.0  0.0   0:00.00 agetty        =
   =20
 3569 root      17   0  1500  476 1332 S  0.0  0.0   0:00.00 agetty        =
   =20
 3571 root      17   0  1500  476 1332 S  0.0  0.0   0:00.00 agetty        =
   =20
    1 root      16   0  1460  464 1312 S  0.0  0.0   0:05.12 init          =
   =20
 3556 root      16   0  1588  452 1304 S  0.0  0.0   0:01.65 klogd         =
   =20
 3307 bin       15   0  1480  380 1324 S  0.0  0.0   0:00.16 portmap       =
   =20
22177 peter     18   0  1308  256 1288 S  0.0  0.0   0:00.00 waiter        =
   =20
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.01 migration/0   =
   =20
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.01 ksoftirqd/0   =
   =20
    4 root      RT   0     0    0    0 S  0.0  0.0   0:00.01 migration/1   =
   =20
    5 root      34  19     0    0    0 S  0.0  0.0   0:00.01 ksoftirqd/1   =
   =20
    6 root       6 -19     0    0    0 S  0.0  0.0   0:00.00 krcud/1       =
   =20
    7 root       5 -10     0    0    0 S  0.0  0.0   0:00.17 events/0      =
   =20
    8 root       5 -10     0    0    0 S  0.0  0.0   0:00.15 events/1      =
   =20
    9 root       5 -10     0    0    0 S  0.0  0.0   0:00.15 kblockd/0     =
   =20
   10 root       5 -10     0    0    0 S  0.0  0.0   0:00.15 kblockd/1     =
   =20
   11 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd         =
   =20
   12 root       1 -19     0    0    0 S  0.0  0.0   0:00.00 krcud/0       =
   =20
   16 root      15 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0         =
   =20
   15 root      15   0     0    0    0 S  0.0  0.0   0:04.75 kswapd0       =
   =20
   17 root      15 -10     0    0    0 S  0.0  0.0   0:00.00 aio/1         =
   =20
   18 root      21   0     0    0    0 S  0.0  0.0   0:00.00 scsi_eh_0     =
   =20
   19 root      15   0     0    0    0 S  0.0  0.0   0:00.00 ahc_dv_0      =
   =20
   20 root      19   0     0    0    0 S  0.0  0.0   0:00.29 kseriod       =
   =20
   21 root      16   0     0    0    0 S  0.0  0.0   0:00.00 i2oevtd       =
   =20
   22 root      16   0     0    0    0 S  0.0  0.0   0:00.00 i2oblock      =
   =20
   23 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/0    =
   =20
   24 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/1    =
   =20
 3370 root      15   0     0    0    0 S  0.0  0.0   0:20.39 rpciod        =
   =20
 3371 root      20   0     0    0    0 S  0.0  0.0   0:00.00 lockd         =
   =20
11812 root      15   0     0    0    0 S  0.0  0.0   0:00.16 pdflush       =
   =20
11813 root      15   0     0    0    0 S  0.0  0.0   0:04.07 pdflush       =
   =20
22208 peter     18   0     0    0    0 Z  0.0  0.0   0:00.00 netstat <defun=
ct> =20


Module                  Size  Used by
em8300                 58500  0=20
bt865                   5580  0=20
emu10k1                63300  1=20
ac97_codec             17548  1 emu10k1


--=-XSYdpwGDSt6//0/rf70G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBARr/ktCb2m4B45HIRAttWAJ4hnZ0OJUibw57zqPMlwm/6vUMp/gCfSayY
7by0OfH8dLP9DNHdwQZZtGE=
=h+UQ
-----END PGP SIGNATURE-----

--=-XSYdpwGDSt6//0/rf70G--

