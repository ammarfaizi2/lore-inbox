Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUGHSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUGHSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUGHSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:21:56 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:12759 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264098AbUGHSVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:21:54 -0400
Date: Thu, 8 Jul 2004 12:21:43 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040708182143.GD23346@schnapps.adilger.int>
Mail-Followup-To: jmerkey@comcast.net, linux-kernel@vger.kernel.org
References: <070820041751.25643.40ED899E0006C76E0000642B2200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <070820041751.25643.40ED899E0006C76E0000642B2200748184970A059D0A0306@comcast.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Jul 08, 2004  17:51 +0000, jmerkey@comcast.net wrote:
> On a Linux 2.4.21 system running snort with a very large organization
> (30,000 +) workstations I am seeing a "too many files" mesage from ext3
> which results in snort dying and rolling our of memory.  Is there a way
> to specifiy a larger number of inode entries dynamically when creating
> an Ext3 file system which gets around this limitation.  In theory, a file
> system should not create a limitation on how many files it can contain,
> but I understand that inode base FS's have this limitation.

Do you create a subdirectory for every user?  If yes, then there
is a limit of 32000 subdirectories in a single directory for Linux.
It is possible to bump this up to 65000 or so (include/linux/ext3_fs.h
EXT3_LINK_MAX), but not more, because of i_nlink size limits.  If you have
so many entries in a single directory I'd also suggest the htree patches
to ext3 (I can send you patches if you want) to improve performance,
but they are not strictly required.

If you are actually running out of inodes, then you can use "-i" or "-N"
to mke2fs to increase the number of inodes in a new filesystem.  Since
this defaults to 1 inode per 8kB of space, it seems unlikely that you
would run out of inodes before blocks unless you have lots of small files
(maildir perhaps?  even then "modern" emails usually average > 8kB in size
because of HTML crap, lots of headers, attachments, etc).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA7ZC3pIg59Q01vtYRAqAgAKDE+Qn1SZqFCRXdOiHNSMmSVtOH/ACeMBdo
IWwwWr3GQyq2NqxQq4EYtqw=
=0zfp
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
