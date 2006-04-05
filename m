Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWDEC1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWDEC1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDEC1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:27:21 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:20101 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1751083AbWDEC1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:27:20 -0400
Subject: Re: 2.6.17-rc1-mm1, nfsd/reiser4 BUG
From: Zan Lynx <zlynx@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       reiserfs-list@namesys.com
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J7X/cuQXOp3onmdryQe3"
Date: Tue, 04 Apr 2006 20:27:16 -0600
Message-Id: <1144204036.26812.72.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J7X/cuQXOp3onmdryQe3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 01:45 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/=
2.6.17-rc1-mm1/

While running the following command on a Reiser4 partition mounted on a
MD RAID-0 device on top of two SCSI disks:

find -type f -print0 | xargs -0 cat > /dev/null

I was running this on the local machine, not on the NFS mounts.  In
fact, the NFS mounts should have had none, or very little, activity.

I started getting the following error messages.  I had been running
2.6.16-rc5-mm3 and hadn't noticed anything like that, so when I get some
time I may try to isolate it, if I can reproduce it.

But, in case anyone else knows the problem, here it is

BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#1]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a120   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: ddfe1f40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2170, threadinfo=3Dddfe1000 task=3Dc148a070)
Stack: <0>de05d000 ddc3d9e0 00000011 00000003 e0ac9d00 de05d000 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 c51b9014 de05d064 e0aa80bc e0aa7fa0 de05d000 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 de05d040 c51b9014 000186a3 00000007 c51b9=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:ddfe1f40
 <6>note: nfsd[2170] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#2]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a160   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: dff43f40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2167, threadinfo=3Ddff43000 task=3Ddf599550)
Stack: <0>de7f5000 ddc3d9e0 00000011 00000003 e0ac9d00 de7f5000 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 d7196014 de7f5064 e0aa80bc e0aa7fa0 de7f5000 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 de7f5040 d7196014 000186a3 00000007 d7196=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:dff43f40
 <6>note: nfsd[2167] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#3]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a1a0   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: de555f40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2171, threadinfo=3Dde555000 task=3Ddfe23030)
Stack: <0>dd7cda00 ddc3d9e0 00000011 00000003 e0ac9d00 dd7cda00 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 c54bb014 dd7cda64 e0aa80bc e0aa7fa0 dd7cda00 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 dd7cda40 c54bb014 000186a3 00000007 c54bb=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:de555f40
 <6>note: nfsd[2171] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#4]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a1e0   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: ddfccf40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2166, threadinfo=3Dddfcc000 task=3Ddf488a90)
Stack: <0>ddfebe00 ddc3d9e0 00000011 00000003 e0ac9d00 ddfebe00 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 c5629014 ddfebe64 e0aa80bc e0aa7fa0 ddfebe00 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 ddfebe40 c5629014 000186a3 00000007 c5629=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:ddfccf40
 <6>note: nfsd[2166] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#5]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a220   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: de477f40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2169, threadinfo=3Dde477000 task=3Ddebdba70)
Stack: <0>de05d600 ddc3d9e0 00000011 00000003 e0ac9d00 de05d600 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 db0ed014 de05d664 e0aa80bc e0aa7fa0 de05d600 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 de05d640 db0ed014 000186a3 00000007 db0ed=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:de477f40
 <6>note: nfsd[2169] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
e0a9a3d2
*pde =3D 00000000
Oops: 0002 [#6]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:00.0/class
Modules linked in: it87 hwmon_vid hwmon i2c_isa parport_pc lp parport nfsd =
exportfs lockd autofs4 sunrpc iptable_filter ip_tables x_tables binfmt_misc=
 dm_mod ohci_hcd eepro100 uhci_hcd ehci_hcd sis_agp agpgart i2c_sis630 i2c_=
core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd=
_pcm snd_timer snd soundcore snd_page_alloc e100 via_rhine sis900 mii crc32=
 ide_cd cdrom usbcore
CPU:    0
EIP:    0060:[<e0a9a3d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm1 #1)
EIP is at nfsd_cache_lookup+0x169/0x2e3 [nfsd]
eax: 00000000   ebx: dd05a260   ecx: ddc3da38   edx: 00000000
esi: c815319e   edi: 00000000   ebp: 00000007   esp: ddf70f40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2165, threadinfo=3Dddf70000 task=3Ddfe1aa90)
Stack: <0>ddfeb200 ddc3d9e0 00000011 00000003 e0ac9d00 ddfeb200 e0aa80bc e0=
aa7fa0
       e0aa80bc e0a93049 db575014 ddfeb264 e0aa80bc e0aa7fa0 ddfeb200 e0ab2=
7d2
       0000003d dd7eaba0 e0aa7fa0 ddfeb240 db575014 000186a3 00000007 db575=
008
Call Trace:
 <e0a93049> nfsd_dispatch+0x39/0x16f [nfsd]   <e0ab27d2> svc_process+0x38c/=
0x5c6 [sunrpc]
 <e0a93509> nfsd+0x19a/0x315 [nfsd]   <e0a9336f> nfsd+0x0/0x315 [nfsd]
 <c0101005> kernel_thread_helper+0x5/0xb
Code: 28 8b 54 24 0c 89 53 30 8b 53 24 a1 e8 ba 3b c0 89 43 34 89 d0 c1 e8 =
18 31 d0 8b 54 24 04 83 e0 3f 8d 0c 82 8b 03 8b 53 04 85 c0 <89> 02 74 03 8=
9 50 04 8b 01 85 c0 89 03 74 03 89 58 04 89 19 80
EIP: [<e0a9a3d2>] nfsd_cache_lookup+0x169/0x2e3 [nfsd] SS:ESP 0068:ddf70f40
 <6>note: nfsd[2165] exited with preempt_count 1

--=20
Zan Lynx <zlynx@acm.org>

--=-J7X/cuQXOp3onmdryQe3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMysEG8fHaOLTWwgRAsYtAJ9xXZ8L2T5DiOhifw+AMzsOaXyFfwCfeC0s
QhZXqsK4OpoI/Uar2o03hzU=
=/s/d
-----END PGP SIGNATURE-----

--=-J7X/cuQXOp3onmdryQe3--

