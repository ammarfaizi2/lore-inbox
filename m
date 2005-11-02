Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVKBPuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVKBPuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVKBPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:49:59 -0500
Received: from mx1.mail.ru ([194.67.23.121]:57644 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S965096AbVKBPt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:49:58 -0500
Subject: PAE bug in 2.4?!
From: Ilya <khext@mail.ru>
To: linux-kernel@vger.kernel.org, khext@mail.ru
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4bIMSEGSfm3fD6mgvKTV"
Date: Wed, 02 Nov 2005 18:49:55 +0300
Message-Id: <1130946595.4434.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4bIMSEGSfm3fD6mgvKTV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've ASUS P4P800-Mx-EAYVZ motherboard and have to use a 2GB memory. But
after including PAE support in kernel it almost twice... Surely, i
understand, that it's inevitable, the slowing of PAE, but twice?! Does
anybody faced this problem? Or is there some bug in PAE?! I tested the
PAE at some other motherboards, but only on this model on asus it works
strange)=20

Best rgds, Ilya

Below, you can find some usefull info about this situation.

Cpu info:
khext@al:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.156
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4784.12

Here is the difference in kernels:
khext@al:~$ diff linux-2.4.31/.config linux-2.4.31-PAE/.config
61,62c61,62
< CONFIG_NOHIGHMEM=3Dy
< # CONFIG_HIGHMEM4G is not set
---
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=3Dy
64c64,65
< # CONFIG_HIGHMEM is not set
---
> CONFIG_HIGHMEM=3Dy
> CONFIG_HIGHIO=3Dy

Here is my test:
khext@al:~$ cat pl
for ($j=3D1;$j<5;$j++){
$num=3D250000*$j;
$a=3D"";
for ($i=3D0; $i<$num/72; $i++) {
        $a.=3D'1234567890qwertyuiopasdfghjklzxcvbnm';
        $a.=3D'1234567890QWERTYUIOPASDFGHJKLZXCVBNM';
}
printf ("len=3D".length($a)."\n");
$b=3D"";
$k=3D345345342;
for ($i=3D0; $i<1000000; $i++) {
        $k*=3D34523;
        $k%=3D$num;
        $k=3Dabs($k);
        $b.=3Dsubstr(substr($a, $k, 4097),$k%4097,1);
}
printf ("b=3D".length($b)."\n");
printf (substr($b, 10, 5)."\n");
}

Test themselfs...
With PAE turned on:

khext@al:~$ uname -a
Linux al 2.4.31 #25 SMP Wed Nov 2 19:05:47 MSK 2005 i686 GNU/Linux
khext@al:~$ free
             total       used       free     shared    buffers
cached
Mem:       2059812      30656    2029156          0       2512
9744
-/+ buffers/cache:      18400    2041412
Swap:      4883720          0    4883720
khext@al:~$ time perl pl
len=3D250056
b=3D991920
xPnx7
len=3D500040
b=3D996000
SqnSb
len=3D750024
b=3D997280
e2ux7
len=3D1000008
b=3D997960
SLuSb

real    0m33.436s
user    0m33.210s
sys     0m0.220s

With PAE turned off:
khext@al:~$ uname -a
Linux al 2.4.31 #25 SMP Wed Nov 2 19:00:05 MSK 2005 i686 GNU/Linux
khext@al:~$ free
             total       used       free     shared    buffers
cached
Mem:        903880      27640     876240          0       2492
9756
-/+ buffers/cache:      15392     888488
Swap:      4883720          0    4883720

khext@al:~$ time perl pl
len=3D250056
b=3D991920
xPnx7
len=3D500040
b=3D996000
SqnSb
len=3D750024
b=3D997280
e2ux7
len=3D1000008
b=3D997960
SLuSb

real    0m17.208s
user    0m16.780s
sys     0m0.430s


--=-4bIMSEGSfm3fD6mgvKTV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDaOAj2sJFZiIalz0RAuIjAJ0Tktv0pCo5ljGCPu3rqv2Hz3FkIwCgzftw
Je3zmrAdMF+qiY6zINSsirw=
=mspD
-----END PGP SIGNATURE-----

--=-4bIMSEGSfm3fD6mgvKTV--

