Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWDCWpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWDCWpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWDCWpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:45:53 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:8916 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964882AbWDCWpx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:45:53 -0400
Subject: [OOPS] related to swap?
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8b1fp6y2gzJmlaN2cKsb"
Date: Tue, 04 Apr 2006 00:49:53 +0200
Message-Id: <1144104593.30036.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8b1fp6y2gzJmlaN2cKsb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

<OBSERVE>
Yes, i run a tainted kernel! either live with it or ignore this mail =3D)

I have a bad cold so things is a wee bit incoherent...

I'm basically just trying to get the facts out there, if someone
finds this interesting, then just mail me for additional details
and information.
</OBSERVE>

Hi,=20

Summary: I seem to have some odd problems with swap on my machine, swap
seems to deadlock the box, if enabled.

About the machine:
AMD64 X2, 3GB memory, SATA raid5 array using XFS as root fs.
SATA controllers: sata_nv(4 disks) and sata_sil24(1 disk)
Kernels involved in testing: 2.16(|.1|-git15).
GCC 4.1.0 (Yes, i play chicken with compilers)
(since it's gentoo: CFLAGS=3D"-O2 -march=3Dk8 -pipe")

Lengthier information and explanation:
A long time ago i ceased the opportunity and got a AMD64 box, compiled
gentoo for AMD64 (this was when other 64 bit distributions was still in
beta). After a while i noticed that 64 bit userland consumes more memory
so i got 'some more' =3D).

I had already had a sata disk fail on me when my root disk started to
fail, so i opted for putting the root on a raid, since raid6 seemed a
bit to experimental i opted for raid5, =3D).

And to continue it all, i have been using reiserfs since 2.4.x-testX
kernels, and i have really liked it... Although the initial versions
with unordered logs could ruin files =3D)... But reading filesystem
benchmarks etc etc and talking to friends led me to want to test XFS
which seems to work ok, although slower than reiserfs on aprox the same
machine.<rant>And reiserfsck works on a ro filesystem</rant>.

I started to test sky2 drivers and had all kinds of odd problems when i
switched to X2, some are related to the chipset overheating (passive
cooling a nf4 pcie chipset is hard). But i am atm using forcedeth so i
can get a stable system first and then test the sky2 driver some more
(forcedeth works just fine on simular boxes).

After a while i got some oopses, one of which made me suspect swap...
My swap layout: one part per disk, 5 disks, each part is about 512MB.
I, at first, reformatted them several times and checked the partitions
for bad blocks but nothing was found. Then i stopped using them with the
same priority in fear of it was that that went wrong but during one of
the tests (10+h up running distcc jobs and then starting swap lead to a
deadlock within 15 mins) i started to wonder if something else was
wrong. I have never had the energy to perform a full memtext86+ but all
the memory errors i have found on other boxes has revealed themselves
quicker.

Here is the only logged crash:
Unable to handle kernel paging request at 0000001f00000038 RIP:
<ffffffff8017dad9>{iput+24}
PGD b20a4067 PUD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in: udf snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec
snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc
snd_util_mem snd_hwdep snd soundcore sky2 nvidia forcedeth
Pid: 246, comm: kswapd0 Tainted: P      2.6.16.1 #2
RIP: 0010:[<ffffffff8017dad9>] <ffffffff8017dad9>{iput+24}
RSP: 0018:ffff8100bdd89d98  EFLAGS: 00010283
RAX: 0000001f00000000 RBX: ffff81003d994030 RCX: ffff81003d994060
RDX: ffff81003d994060 RSI: 0000000000000004 RDI: ffff81003d994030
RBP: ffff81004bbb16c0 R08: 0000000000000003 R09: ffff81004bbb1788
R10: 0000000000000001 R11: ffff81004bbb1788 R12: 000000000000006d
R13: 00000000000000d0 R14: 0000000000000000 R15: 0000000000000200
FS:  00002b55f66fe400(0000) GS:ffffffff806fe000(0000)
knlGS:00000000f55daba0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000001f00000038 CR3: 00000000b27ca000 CR4: 00000000000006e0
Process kswapd0 (pid: 246, threadinfo ffff8100bdd88000, task
ffff8100bdd7ee00)
Stack: ffff81004bbb1700 ffffffff8017cb72 ffff8100bdfa8fc0
000000000000c094
       000000000000008b ffffffff8017cbc7 0000000000000080
ffffffff80152d87
       00000000000a5616 ffffffff80554680
Call Trace: <ffffffff8017cb72>{prune_dcache+264}
<ffffffff8017cbc7>{shrink_dcache_memory+21}
       <ffffffff80152d87>{shrink_slab+226}
<ffffffff80153019>{balance_pgdat+551}
       <ffffffff8046b88c>{thread_return+0} <ffffffff801532a5>{kswapd
+273}
       <ffffffff8013ebc9>{autoremove_wake_function+0}
<ffffffff8010b806>{child_rip+8}
       <ffffffff80117c75>{flat_send_IPI_mask+0}
<ffffffff80153194>{kswapd+0}
       <ffffffff8010b7fe>{child_rip+0}

Code: 48 8b 40 38 75 0a 0f 0b 68 30 8a 4b 80 c2 7a 04 48 85 c0 74
RIP <ffffffff8017dad9>{iput+24} RSP <ffff8100bdd89d98>
CR2: 0000001f00000038
 <0>xfs_iget_core: ambiguous vns: vp/0xffff81003d994000,
invp/0xffff810063f2f000
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/xfs/support/debug.c:57
invalid opcode: 0000 [2] SMP
CPU 1
Modules linked in: udf snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec
snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc
snd_util_mem snd_hwdep snd soundcore sky2 nvidia forcedeth
Pid: 7758, comm: rsync Tainted: P      2.6.16.1 #2
RIP: 0010:[<ffffffff8029062f>] <ffffffff8029062f>{cmn_err+213}
RSP: 0018:ffff81007120da68  EFLAGS: 00010246
RAX: 0000000000000050 RBX: ffffffff804c11c0 RCX: 0000000000000046
RDX: 00000000000008fd RSI: 0000000000000297 RDI: ffffffff8056dae4
RBP: 0000000000000000 R08: ffffffff80550288 R09: ffff8100b8c148c0
R10: 0000000000000096 R11: ffffffff80117c75 R12: 0000000000000297
R13: ffff8100bc932800 R14: 0000000029434610 R15: 0000000000000000
FS:  00002b38e552ed70(0000) GS:ffff810003ff94c0(0000)
knlGS:00000000f75deba0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000008b5d78 CR3: 00000000ac835000 CR4: 00000000000006e0
Process rsync (pid: 7758, threadinfo ffff81007120c000, task
ffff8100bdd7ee00)
Stack: 0000003000000020 ffff81007120db58 ffff81007120da88
ffffffff802c1cb3
       0000000000000000 ffff810031ab6508 ffff81003d994000
ffff810063f2f000
       0000000000000000 ffff81007120dc38
Call Trace: <ffffffff802c1cb3>{_atomic_dec_and_lock+51}
       <ffffffff80256509>{xfs_da_brelse+112}
<ffffffff8028f292>{linvfs_alloc_inode+52}
       <ffffffff8017df0b>{alloc_inode+243}
<ffffffff8029047e>{vn_initialize+172}
       <ffffffff8026ba2b>{xfs_iget+389} <ffffffff8046d039>{__down_read
+18}
       <ffffffff8027f156>{xfs_dir_lookup_int+97}
<ffffffff8028258c>{xfs_lookup+79}
       <ffffffff8028db49>{linvfs_lookup+48} <ffffffff80173f91>{do_lookup
+196}
       <ffffffff80175d9b>{__link_path_walk+2466}
<ffffffff801762da>{link_path_walk+89}
       <ffffffff8017671c>{do_path_lookup+594} <ffffffff801751fd>{getname
+347}
       <ffffffff80176f73>{__user_walk_fd+55}
<ffffffff8017002c>{vfs_lstat_fd+21}
       <ffffffff80170217>{sys_newlstat+25}
<ffffffff8010a90e>{system_call+126}

Code: 0f 0b 68 59 3d 4c 80 c2 39 00 48 81 c4 d0 00 00 00 5b 5d 41
RIP <ffffffff8029062f>{cmn_err+213} RSP <ffff81007120da68>
 BUG: rsync/7758, lock held at task exit time!
 [ffff81000d5d2630] {inode_init_once}
.. held by:             rsync: 7758 [ffff8100bdd7ee00, 117]
... acquired at:               do_lookup+0x81/0x173


--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-8b1fp6y2gzJmlaN2cKsb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQBEMaaR7F3Euyc51N8RAvA0AJ9xgYawSjr9x1Q3zzZAJ0fSVo0M9QCdE1xJ
NaFBxcjmWooDImVplFld1ts=
=HPkj
-----END PGP SIGNATURE-----

--=-8b1fp6y2gzJmlaN2cKsb--

