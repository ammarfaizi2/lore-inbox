Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWCARCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWCARCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWCARCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:02:12 -0500
Received: from 213-205-70-85.net.novis.pt ([213.205.70.85]:30348 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751714AbWCARCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:02:11 -0500
Message-ID: <4405D383.5070201@artenumerica.com>
Date: Wed, 01 Mar 2006 17:01:55 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: support@artenumerica.com
Subject: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4BBFBCDF22445C00D2586EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4BBFBCDF22445C00D2586EB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greetings

On a dual EM64T Xeon with 4GB of RAM, I am getting apparently "innocent"
processes killed by oom-killer with gfp_mask=0xd1 (with all or almost
all swap space still available).

This happens when running a couple of Gaussian and other computational
chemistry software processes each using ~ 800MB-1GB of RAM.  Sometimes
oom-killer kills one or two of those processes, with the kernel messages
shown below.  Unfortunately I don't have a simpler recipe to induce this
behavior... (it may even be triggered only by some Gaussian runs with a
particular set of input parameters; it doesn't happen always).

I haven't tried 2.6.15 kernels yet, but according to recent reports in
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
even those may still have oom-killer problems (like this?).

Since I'm not yet familiar with the meaning of much of the data output
in the following kernel messages, could someone suggest some appropriate
course of action to troubleshoot this?  Any recommended kernel
versions/patches/settings?


oom-killer: gfp_mask=0xd1
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31
cpu 0 cold: low 0, high 62, batch 31
cpu 1 hot: low 62, high 186, batch 31
cpu 1 cold: low 0, high 62, batch 31
cpu 2 hot: low 62, high 186, batch 31
cpu 2 cold: low 0, high 62, batch 31
cpu 3 hot: low 62, high 186, batch 31
cpu 3 cold: low 0, high 62, batch 31
HighMem per-cpu: empty
Free pages:       13436kB (0kB HighMem)
Active:396041 inactive:586624 dirty:180807 writeback:0 unstable:0
free:3359 slab:22149 mapped:256439 pagetables:1997
DMA free:24kB min:28kB low:32kB high:40kB active:0kB inactive:0kB
present:16384kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 4848 4848
Normal free:13412kB min:8892kB low:11112kB high:13336kB active:1584168kB
inactive:2346492kB present:4964352kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 24kB
Normal: 1*4kB 4*8kB 6*16kB 113*32kB 1*64kB 5*128kB 3*256kB 0*512kB
0*1024kB 0*2048kB 2*4096kB = 13412kB
HighMem: empty
Swap cache: add 10, delete 10, find 3/6, race 0+0
Free swap  = 7036300kB
Total swap = 7036304kB
Out of Memory: Killed process 9308 (l804.exe).


I also got similar messages running the same software
after setting /proc/sys/vm/overcommit_memory as "2".

Some machine details:
Tyan Tiger i7525 (S2672) motherboard;
2 Intel Xeon 3.2 GHz CPUs (2MB cache each);
4GB of ECC RAM;
Radeon X300 VGA card.

This is running Ubuntu 5.10 (Breezy) for x8_64 systems, with a 2.6.12
kernel (Ubuntu linux-source-2.6.12-10.28) recompiled
with small configuration differences from the default Ubuntu one
(no K8 NUMA, processor family Intel EM64T, SMP support,
CONFIG_SCHED_SMT, some unneeded hardware support suppressed, ...).

Feel free to request any additional data which could be helpful (kernel
configuration. hardware details, ...).

Best regards and thanks in advance

                            J Esteves
-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enigA4BBFBCDF22445C00D2586EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEBdOKesWiVDEbnjYRAowvAJ9WKxjPdZSZ+KX2d/b+1WHqQh86vwCeOAqH
uBpQdcbEnjfRKX+3PJrgZnQ=
=2yny
-----END PGP SIGNATURE-----

--------------enigA4BBFBCDF22445C00D2586EB--
