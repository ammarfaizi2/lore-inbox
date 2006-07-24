Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWGXHZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWGXHZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 03:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWGXHZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 03:25:38 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:51653
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751433AbWGXHZi (ORCPT <RFC822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 24 Jul 2006 03:25:38 -0400
Message-Id: <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Joshua Hudson <joshudson@gmail.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links
In-Reply-To: Your message of "Mon, 24 Jul 2006 10:45:45 +0400."
             <17604.27801.796726.164279@gargle.gargle.HOWL>
From: Valdis.Kletnieks@vt.edu
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it> <E1G4Kpi-0001Os-AK@be1.lrz> <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
            <17604.27801.796726.164279@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153725928_9426P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 03:25:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153725928_9426P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jul 2006 10:45:45 +0400, Nikita Danilov said:
> Joshua Hudson writes:

>  > In my filesystem, any attempt to create a loop of hard links
>  > is detected and cancelled. 
> 
> Can you elaborate a bit on this exciting mechanism? Obviously an ability
> to efficiently detect loops would be a break-through in a
> reference-counted garbage collection, somehow missed for last 40

It's actually pretty trivial to do if it's a toy filesystem and all the
relevant inodes are in-memory already.  The hard-to-solve part is getting
around the (apparent) need to walk across essentially the entire tree
structure making sure that you aren't creating a loop.  This can get
rather performance piggy - even /home on my laptop has some 400K
inodes on it, and a 'find /home -type d' takes 28 seconds.  That's a *long*
time to lock and freeze a filesystem.

Where it gets *really* messy is that it isn't just mkdir that's the problem -
once you let there be more than one path from the fs root to a given directory,
it gets *really* hard to make sure that any given 'mv' command isn't going to
to screw things up (is 'mv a/b/c/d ../../w/z/b' safe? How do you know, without
examining a *lot* of stuff under a/ and ../../w/?


--==_Exmh_1153725928_9426P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExHXocC3lWbTT17ARAt3vAKDPWfSPgPb4OgAQSNndxLzHVqc87QCfb/2P
T0uD6jEzzqzLwAjywo82kH0=
=NknJ
-----END PGP SIGNATURE-----

--==_Exmh_1153725928_9426P--
