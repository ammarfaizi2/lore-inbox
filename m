Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUJPQq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUJPQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUJPQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:46:59 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:43995 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268786AbUJPQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:46:56 -0400
Date: Sat, 16 Oct 2004 10:46:46 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Best way to find where a lock is taken and not released?
Message-ID: <20041016164646.GD2061@schnapps.adilger.int>
Mail-Followup-To: Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097919013.4763.55.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oxb4CwPtu7fc4ajA"
Content-Disposition: inline
In-Reply-To: <1097919013.4763.55.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Oxb4CwPtu7fc4ajA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Oct 16, 2004  19:30 +1000, Nigel Cunningham wrote:
> I saw a hang the other day (2.6.8.1) where all other processes except
> the suspending to disk one were refrigerated and the process doing the
> suspending was stuck trying to take the dcache_lock via
> shrink_all_memory. Obviously some path called via shrink_all_memory had
> taken the lock and not released it, then tried to retake it _or_ another
> process had taken the lock and then not released it when backing out and
> entering the refrigator. My question is, what's the best way to find the
> path on which this occurs? Grepping, I see dcache_lock all over the
> show, so if there's a more efficient method that reading the files, I'd
> like to learn it. It occurs to me that I might try wrapping calls to
> lock and unlock that lock in printks, but I'm wondering if there's some
> better way I don't yet know.

Probably the easiest would be to add to the lock struct a pointer to
the task_struct and the EIP when it gets the lock, and clear them when
it releases the lock.  That way, when you see processes blocking on the
lock you can use crash or other tool to examine the lock and see which
process got the lock and also where.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Oxb4CwPtu7fc4ajA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBcVB1pIg59Q01vtYRAiQMAKCSR7AvqOx4+O4vdwoKVOyKwlbh+wCffnAk
+fESFRR6P4WlpF+khbaHKEk=
=xsVm
-----END PGP SIGNATURE-----

--Oxb4CwPtu7fc4ajA--
