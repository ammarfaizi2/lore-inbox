Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266537AbUBLRXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBLRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:20:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17131 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266540AbUBLRTC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:19:02 -0500
Message-Id: <200402121718.i1CHITFf018390@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Michael Frank <mhf@linuxmail.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Giuliano Pochini <pochini@shiny.it>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl 
In-Reply-To: Your message of "Fri, 13 Feb 2004 01:05:20 +0800."
             <200402130105.22554.mhf@linuxmail.org> 
From: Valdis.Kletnieks@vt.edu
References: <XFMail.20040212104215.pochini@shiny.it> <402B5502.2010207@cyberone.com.au>
            <200402130105.22554.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1981806468P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 12:18:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1981806468P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 01:05:20 +0800, Michael Frank said:

> What I am getting at is being annoyed with updatedb ___saturating___ 
> the the disk so easily as the "ancient" method of renicing does not 
> consider the fact that the CPU pwrformance has increased 20-50 fold 
> over disk performace.
> 
> Bottom line: what about assigning "io niceness" to processes, which
> would also help with actively scheduling io toward processes 
> needing it.

The problem is that unlike CPU niceness, where you can literally rip the
CPU away from a hog and give it to some more deserving process, it's not
as easy to rip an active disk I/O away so somebody else can have it.

If the updatedb issues a seek/read combo to the disk, and your process gets
into the I/O queue even 200 nanoseconds later, it *still* has to wait for that
I/O to finish before it can start its seeks and reads.

For an extreme example, consider those IDE interfaces where fixating or
blanking a CD/RW will cause *all* the disks to lock up for the duration.
No matter how high your priority is, you *cant* get that I/O out the door
for the next 60-70 seconds unless you're willing to create a coaster.


--==_Exmh_1981806468P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAK7VlcC3lWbTT17ARAgY6AKCenkR4g/dtGZ9yvbgoqLQp0z7v6wCg5Dq5
FNCohFB963AMCsKJFZwzfa0=
=2h6m
-----END PGP SIGNATURE-----

--==_Exmh_1981806468P--
