Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHXJ3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHXJ3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 05:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHXJ3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 05:29:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:3999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267311AbUHXJ2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 05:28:52 -0400
X-Authenticated: #4512188
Message-ID: <412B0A4F.2080603@gmx.de>
Date: Tue, 24 Aug 2004 11:28:47 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck kernel mailing list <ck@vds.kolivas.org>,
       Joshua Schmidlkofer <menion@asylumwear.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de> <412A663D.2050104@kolivas.org> <cone.1093304064.895888.10766.502@pc.kolivas.org>
In-Reply-To: <cone.1093304064.895888.10766.502@pc.kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| Con Kolivas writes:
|
|> Prakash K. Cheemplavam wrote:
|>

|>> Yup I think I have a regression here, as well. I remember an older
|>> version of ck exhibited this, but the last one for 2.6.7 did work well
|>> (I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
|>> doing a (niced) compile in background, some windows react very slow, ie
|>> Mozilla Thunderbird takes ages to switch trough mails or cliking on an
|>> icon in kde to load up konsole takes about 10seconds or more (shoud come
|>> up <1sec normally).
|>>
|>> Using 2.8.6.1-ck4
|>>
|>> HTH,
|>>
|>> Prakash
|>
|>
|> For both of you this only happens with NFS? Can you reproduce the
|> problem in flight and send me the output of 'top -n -n 1' while it's
|> happening? Also if you have time can you confirm this happens with
|> just the staircase patch and none of the other patches?
|
|
| blah... I mean `top -b -n 1`

SO exactly what I observed, even with the latest test fix. In my first
try the machin did even do a hard lock...

So I did a emerge -B xorg-x11 (ie. I started compiling xorg-x11 using
gentoo's emerge system). The hard lock occured after a minute or so.
Next try I waited only a bit. I clicked on konsole icon to come up, but
doesn't want to come for too long. In this time I did the top you see.
I'll boot up linux-2.6.8-rc4 and test again (must check first whether it
has reiser4 support...). I will also try to back oput staircase and try
without.

As you can see xorg-x11 wasn't really compiling ie not using cpu, it was
just scaning through the directories to find it it has nothing to do:


make[3]: Entering directory `/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib'
In Datei, eingefügt von ../../config/cf/Imake.tmpl:105,
~                    von Imakefile.c:35:
../../config/cf/linux.cf:353: Warnung: "BuildLibGlxWithoutPIC" redefined
In Datei, eingefügt von ../../config/cf/site.def:44,
~                    von ../../config/cf/Imake.tmpl:46,
~                    von Imakefile.c:35:
../../config/cf/host.def:63: Warnung: this is the location of the
previous definition
make[3]: Leaving directory `/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib'
make[3]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
making Makefiles in lib/GLU/include...
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
In Datei, eingefügt von ../../../config/cf/Imake.tmpl:105,
~                    von Imakefile.c:35:
../../../config/cf/linux.cf:353: Warnung: "BuildLibGlxWithoutPIC" redefined
In Datei, eingefügt von ../../../config/cf/site.def:44,
~                    von ../../../config/cf/Imake.tmpl:46,
~                    von Imakefile.c:35:
../../../config/cf/host.def:63: Warnung: this is the location of the
previous definition
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/include'
make[4]: Für das Ziel »Makefiles« ist nichts zu tun.
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/include'
making Makefiles in lib/GLU/libutil...
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
In Datei, eingefügt von ../../../config/cf/Imake.tmpl:105,
~                    von Imakefile.c:35:
../../../config/cf/linux.cf:353: Warnung: "BuildLibGlxWithoutPIC" redefined
In Datei, eingefügt von ../../../config/cf/site.def:44,
~                    von ../../../config/cf/Imake.tmpl:46,
~                    von Imakefile.c:35:
../../../config/cf/host.def:63: Warnung: this is the location of the
previous definition
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/libutil'
make[4]: Für das Ziel »Makefiles« ist nichts zu tun.
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/libutil'
making Makefiles in lib/GLU/libtess...
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
In Datei, eingefügt von ../../../config/cf/Imake.tmpl:105,
~                    von Imakefile.c:35:
../../../config/cf/linux.cf:353: Warnung: "BuildLibGlxWithoutPIC" redefined
In Datei, eingefügt von ../../../config/cf/site.def:44,
~                    von ../../../config/cf/Imake.tmpl:46,
~                    von Imakefile.c:35:
../../../config/cf/host.def:63: Warnung: this is the location of the
previous definition
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU'
make[4]: Entering directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/libtess'
make[4]: Für das Ziel »Makefiles« ist nichts zu tun.
make[4]: Leaving directory
`/var/tmp/portage/xorg-x11-6.7.0-r2/work/xc/lib/GLU/libtess'
making Makefiles in lib/GLU/libnurbs/internals...



light@tachyon ~ $ top -b -n 1
top - 11:22:41 up 4 min,  4 users,  load average: 2.03, 1.20, 0.51
Tasks:  94 total,   4 running,  90 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.4% us, 17.3% sy, 25.2% ni, 25.8% id, 23.6% wa,  0.1% hi,  0.6% si
Mem:   1034224k total,   646380k used,   387844k free,    39220k buffers
Swap:        0k total,        0k used,        0k free,   467460k cached

~  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
~ 5491 root      20   0  151m  20m 141m S  9.9  2.0   0:10.99 X
~ 5662 light     20   0 31616  15m  28m S  4.0  1.5   0:01.32 kdeinit
14859 light     20   0 31152  14m  28m R  2.0  1.5   0:00.33 kdeinit
~    1 root      20   0  1356  416 1204 S  0.0  0.0   0:00.58 init
~    2 root      39  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
~    3 root      10 -10     0    0    0 S  0.0  0.0   0:00.04 events/0
~    4 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 khelper
~    5 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 kacpid
~   29 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
~   45 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
~   44 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0
~  137 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 ata/0
~  138 root      20   0     0    0    0 S  0.0  0.0   0:00.00 scsi_eh_0
~  139 root      20   0     0    0    0 S  0.0  0.0   0:00.00 scsi_eh_1
~  153 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
~  159 root      20   0     0    0    0 S  0.0  0.0   0:00.00 i2oevtd
~  185 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/0
~  423 root      10 -10  1332  320 1184 S  0.0  0.0   0:00.02 udevd
~  944 root      20   0     0    0    0 S  0.0  0.0   0:00.00
ktxnmgrd:sda5:w
~  945 root      20   0     0    0    0 S  0.0  0.0   0:00.00 ent:sda5.
~  948 root      20   0     0    0    0 S  0.0  0.0   0:00.00 khubd
~ 2756 root      20   0     0    0    0 S  0.0  0.0   0:00.00 khpsbpkt
~ 2768 root      20   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
~ 4543 root      20   0  1616  628 1436 S  0.0  0.1   0:00.00 syslog-ng
~ 4877 rpc       20   0  1568  612 1400 S  0.0  0.1   0:00.00 portmap
~ 4880 root      20   0  6620 3568 3100 S  0.0  0.3   0:00.14 cupsd
~ 5031 light     20   0  3116 1520 2504 S  0.0  0.1   0:00.01 famd
~ 5091 nobody    20   0  1528  720 1360 S  0.0  0.1   0:00.00 rpc.statd
~ 5096 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5097 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5098 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5099 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5100 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5101 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5102 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5103 root      20   0     0    0    0 S  0.0  0.0   0:00.00 nfsd
~ 5106 root      20   0     0    0    0 S  0.0  0.0   0:00.00 lockd
~ 5107 root      20   0     0    0    0 S  0.0  0.0   0:00.00 rpciod
~ 5108 root      20   0  1568  744 1376 S  0.0  0.1   0:00.00 rpc.mountd
~ 5160 root      20   0  3288 1376 2920 S  0.0  0.1   0:00.00 sshd
~ 5263 root      20   0  2032  896 1704 S  0.0  0.1   0:00.00 xinetd
~ 5315 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5316 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5317 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5318 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5319 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5320 root      20   0  1404  580 1236 S  0.0  0.1   0:00.00 agetty
~ 5478 root      20   0  2560  604 2252 S  0.0  0.1   0:00.00 kdm
~ 5492 root      20   0  3300 1464 2744 S  0.0  0.1   0:00.01 kdm
~ 5551 light     20   0  4360 1004 4180 S  0.0  0.1   0:00.00 kde-3.3.0
~ 5560 light     20   0  4748 1148 4180 S  0.0  0.1   0:00.00 startkde
~ 5616 light     20   0 26324 9768  24m S  0.0  0.9   0:00.08 kdeinit
~ 5619 light     20   0 25200 8476  24m S  0.0  0.8   0:00.01 kdeinit
~ 5621 light     20   0 27360  10m  26m S  0.0  1.0   0:00.05 kdeinit
~ 5624 light     20   0 29972  13m  27m S  0.0  1.3   0:00.24 kdeinit
~ 5630 light     20   0 27128  11m  25m S  0.0  1.1   0:00.07 kdeinit
~ 5640 light     20   0  1344  248 1188 S  0.0  0.0   0:00.00 kwrapper
~ 5642 light     20   0 27184  11m  25m S  0.0  1.1   0:00.06 kdeinit
~ 5643 light     20   0 29104  13m  26m S  0.0  1.4   0:00.52 kdeinit
~ 5645 light     20   0 30264  15m  27m S  0.0  1.5   0:01.00 kdeinit
~ 5647 light     20   0 31808  15m  28m S  0.0  1.6   0:00.68 kdeinit
~ 5648 light     20   0 27976  10m  26m S  0.0  1.0   0:00.00 kdeinit
~ 5650 light     20   0 26420 8404  16m S  0.0  0.8   0:00.74 gkrellm2
~ 5654 light     20   0 28404  13m  25m S  0.0  1.3   0:00.13 kdeinit
~ 5657 light     20   0 27712  11m  25m S  0.0  1.2   0:00.08 kdeinit
~ 5659 light     20   0 30968  14m  28m S  0.0  1.5   0:00.20 korgac
~ 5665 light     20   0  4836 1488 4372 S  0.0  0.1   0:00.00 bash
~ 5674 root      20   0  2144  988 1700 S  0.0  0.1   0:00.00 su
~ 5677 root      20   0  4576 1488 4372 S  0.0  0.1   0:00.00 bash
~ 5692 light     20   0  4620 1120 4180 S  0.0  0.1   0:00.00 thunderbird
~ 5694 light     20   0  4620 1128 4180 S  0.0  0.1   0:00.00 run-mozilla.sh
~ 5699 light     20   0  126m  35m  37m S  0.0  3.5   0:02.90
thunderbird-bin
~ 5727 light     20   0  6004 2352 5564 S  0.0  0.2   0:00.04 gconfd-2
~ 9427 light     20   0  4752 1184 4180 S  0.0  0.1   0:00.00 firefox
~ 9455 light     20   0 83648  32m  36m S  0.0  3.3   0:03.45 firefox-bin
18499 light     20   0  4836 1488 4372 S  0.0  0.1   0:00.00 bash
18536 root      24   4 12512 7176 7432 S  0.0  0.7   0:00.72 emerge
18657 root      20   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
19367 root      20   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
21826 root      24   4  1588  636 1408 S  0.0  0.1   0:00.00 sandbox
21827 root      24   4  6124 2684 4408 S  0.0  0.3   0:00.12 ebuild.sh
21862 root      24   4  4872 1444 4408 S  0.0  0.1   0:00.00 emake
21863 root      24   4  4204 1052 3748 S  0.0  0.1   0:00.00 make
22055 root      24   4  4288 1280 3832 S  0.0  0.1   0:00.00 make
22056 root      24   4  4676 1356 4216 S  0.0  0.1   0:00.00 sh
22318 root      24   4  4288 1208 3832 S  0.0  0.1   0:00.00 make
22319 root      24   4  4676 1360 4216 S  0.0  0.1   0:00.00 sh
22323 light     29   0 28612  11m  26m R  0.0  1.2   0:00.07 kdeinit
22596 light     20   0  1948  896 1736 R  0.0  0.1   0:00.00 top
22652 root      24   4  4288 1200 3832 S  0.0  0.1   0:00.00 make
22653 root      24   4  4672 1332 4216 S  0.0  0.1   0:00.00 sh
22654 root      25   4  1576  616 1248 S  0.0  0.1   0:00.00 imake
22655 root      25   4  4048  808 3608 S  0.0  0.1   0:00.00 gcc
22656 root      25   4  7836 1252 6812 R  0.0  0.1   0:00.00 cc1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKwpPxU2n/+9+t5gRAj0QAJ9cCgvd2v8AWtZ4TOtifIM3eLy24gCfflPO
yDWBXABxegkw/Eaqd9MFVgs=
=nmxi
-----END PGP SIGNATURE-----
