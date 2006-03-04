Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWCDP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWCDP5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 10:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWCDP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 10:57:33 -0500
Received: from 213-205-70-242.net.novis.pt ([213.205.70.242]:28855 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751809AbWCDP5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 10:57:33 -0500
Message-ID: <4409B8DC.9040404@artenumerica.com>
Date: Sat, 04 Mar 2006 15:57:16 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: support@artenumerica.com, Nuno Galamba <ngalamba@fc.ul.pt>
Subject: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously 2.6.12]
References: <4405D383.5070201@artenumerica.com> <20060302011735.55851ca2.akpm@osdl.org> <440865A9.4000102@artenumerica.com>
In-Reply-To: <440865A9.4000102@artenumerica.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6723FE3DC25A644930D4AAE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6723FE3DC25A644930D4AAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi again

Still on the same dual EM64T machine with a Tyan Tiger i7525 (S2672)
motherboard and 4 GB RAM for which I reported 2.6.12 oom killings a few
days ago:

I upgraded to Ubuntu Dapper and installed its latest 2.6.15 kernel,
which incorporates 2.6.15.4.  Started with the original "binary"
linux-image-2.6.15-16-amd64-xeon package,
and got a few oom killings even without running the same large test
programs as before.  Then recompiled the kernel with
CONFIG_PREEMPT_NONE, CONFIG_SCHED_SMT, no CONFIG_PREEMPT_BKL,
and the dump_stack() call suggested by Andrew Morton for
mm/oom_kill.c [in out_of_memory()].

Repeated tests with Gaussian... and got oom-killer events similar to
those found with 2.6.12.   At
http://jmce.artenumerica.org/en/tmp/linux-2.6.15-oom_killings/kern.log
are the kernel messages from the killing of two Gaussian runs;
I just show below the beginning, until the first killing.

Any suggestions on patches or some pre-2.6.16 version I should try?


Call Trace:<ffffffff8015efcb>{out_of_memory+23}
<ffffffff80130465>{__wake_up+56}
       <ffffffff80161177>{__alloc_pages+572}
<ffffffff8017fc25>{bio_copy_user+219}
       <ffffffff801debbf>{blk_rq_map_user+133} <ffffffff801e1b61>{sg_io+351}
       <ffffffff801e1ff8>{scsi_cmd_ioctl+494}
<ffffffff80130465>{__wake_up+56}
       <ffffffff80265aac>{sock_def_readable+52}
<ffffffff802c5d68>{unix_dgram_sendmsg+1085}
       <ffffffff88077e35>{:sd_mod:sd_ioctl+371}
<ffffffff801e0058>{blkdev_driver_ioctl+93}
       <ffffffff801e0726>{blkdev_ioctl+1613}
<ffffffff8018ce76>{do_select+1137}
       <ffffffff8026321e>{sys_sendto+251} <ffffffff8018c941>{__pollwait+0}
       <ffffffff801813d2>{block_ioctl+27} <ffffffff8018c091>{do_ioctl+33}
       <ffffffff8018c36c>{vfs_ioctl+643} <ffffffff8018c3e0>{sys_ioctl+91}
       <ffffffff8010fa46>{system_call+126}
oom-killer: gfp_mask=0xd1, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
cpu 1 hot: low 0, high 0, batch 1 used:0
cpu 1 cold: low 0, high 0, batch 1 used:0
cpu 2 hot: low 0, high 0, batch 1 used:0
cpu 2 cold: low 0, high 0, batch 1 used:0
cpu 3 hot: low 0, high 0, batch 1 used:0
cpu 3 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:151
cpu 0 cold: low 0, high 62, batch 15 used:50
cpu 1 hot: low 0, high 186, batch 31 used:165
cpu 1 cold: low 0, high 62, batch 15 used:56
cpu 2 hot: low 0, high 186, batch 31 used:5
cpu 2 cold: low 0, high 62, batch 15 used:54
cpu 3 hot: low 0, high 186, batch 31 used:12
cpu 3 cold: low 0, high 62, batch 15 used:2
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:118
cpu 0 cold: low 0, high 62, batch 15 used:56
cpu 1 hot: low 0, high 186, batch 31 used:82
cpu 1 cold: low 0, high 62, batch 15 used:59
cpu 2 hot: low 0, high 186, batch 31 used:30
cpu 2 cold: low 0, high 62, batch 15 used:53
cpu 3 hot: low 0, high 186, batch 31 used:10
cpu 3 cold: low 0, high 62, batch 15 used:14
HighMem per-cpu: empty
Free pages:       14924kB (0kB HighMem)
Active:491535 inactive:494210 dirty:148758 writeback:0 unstable:0
free:3731 slab:13610 mapped:483530 pagetables:1658
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12464kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 3255 4013 4013
DMA32 free:12752kB min:6564kB low:8204kB high:9844kB active:1475208kB
inactive:1723432kB present:3333792kB pages_scanned:66 all_unreclaimable? no
lowmem_reserve[]: 0 0 757 757
Normal free:2152kB min:1528kB low:1908kB high:2292kB active:490804kB
inactive:253408kB present:775680kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 28*4kB 27*8kB 20*16kB 20*32kB 33*64kB 2*128kB 0*256kB 0*512kB
1*1024kB 0*2048kB 2*4096kB = 12872kB
Normal: 16*4kB 9*8kB 14*16kB 0*32kB 6*64kB 1*128kB 1*256kB 0*512kB
1*1024kB 0*2048kB 0*4096kB = 2152kB
HighMem: empty
Swap cache: add 79, delete 77, find 7/11, race 0+0
Free swap  = 3517888kB
Total swap = 3518152kB
Free swap:       3517888kB
1245184 pages of RAM
232833 reserved pages
219286 pages shared
2 pages swap cached
Out of Memory: Killed process 13792 (l502.exe).


Best regards
                    J Esteves

-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enigF6723FE3DC25A644930D4AAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFECbjiesWiVDEbnjYRAsqBAKCLEbXwOlum3+Q/H8uZodWTy/dTlACg2C5s
Xt0nljlyYeBzZ/kh9UCEsPg=
=VAvx
-----END PGP SIGNATURE-----

--------------enigF6723FE3DC25A644930D4AAE--
