Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUGIQgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUGIQgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUGIQgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:36:21 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:14021 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265041AbUGIQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:36:16 -0400
From: jmerkey@comcast.net
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 16:36:14 +0000
Message-Id: <070920041636.14668.40EEC97D000D82330000394C2200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_14668_1089390974_0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_14668_1089390974_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit


> Do you create a subdirectory for every user?  

Yes.  Snort creates a subdirectory for each IP address identified as generation an attack
or alert.  This number can get very large, BTW.

If yes, then there
> is a limit of 32000 subdirectories in a single directory for Linux.
> It is possible to bump this up to 65000 or so (include/linux/ext3_fs.h
> EXT3_LINK_MAX), but not more, because of i_nlink size limits.  

I may alter the on disk structures to increase this to something larger, say 16,000,000,
which would break ext3 on other systems.  I will look at the code for this to see if this is 
even possible without the FS meta data growing so huge, it renders performance poor.
These types of limits should probably be done away with with an architectural change, BTW.
Food for thought for the future.

If you have
> so many entries in a single directory I'd also suggest the htree patches
> to ext3 (I can send you patches if you want) to improve performance,
> but they are not strictly required.

I'd like to review the patches, at least they may help the current situation in the interrim.

> 
> If you are actually running out of inodes, then you can use "-i" or "-N"
> to mke2fs to increase the number of inodes in a new filesystem.  Since
> this defaults to 1 inode per 8kB of space, it seems unlikely that you
> would run out of inodes before blocks unless you have lots of small files
> (maildir perhaps?  even then "modern" emails usually average > 8kB in size
> because of HTML crap, lots of headers, attachments, etc).

I think we are running into the directory entry limitation.  I have enough inodes for this 
application (at least it appears so).

Thanks for the help.  Sorry it took me a day to respond back.  I was in West Germany
(Heinsberg) for the past month with my new German wife (she's from Stolzberg), and I 
am still re-adjusting my sleep cycle back to Utah time.   Wanted to visit Nurnberg and 
see Suse's building -- maybe next visit.  

Thanks for the help.

:-)

Jeff


> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/
> 


> On Jul 08, 2004  17:51 +0000, jmerkey@comcast.net wrote:
> > On a Linux 2.4.21 system running snort with a very large organization
> > (30,000 +) workstations I am seeing a "too many files" mesage from ext3
> > which results in snort dying and rolling our of memory.  Is there a way
> > to specifiy a larger number of inode entries dynamically when creating
> > an Ext3 file system which gets around this limitation.  In theory, a file
> > system should not create a limitation on how many files it can contain,
> > but I understand that inode base FS's have this limitation.
> 
> Do you create a subdirectory for every user?  If yes, then there
> is a limit of 32000 subdirectories in a single directory for Linux.
> It is possible to bump this up to 65000 or so (include/linux/ext3_fs.h
> EXT3_LINK_MAX), but not more, because of i_nlink size limits.  If you have
> so many entries in a single directory I'd also suggest the htree patches
> to ext3 (I can send you patches if you want) to improve performance,
> but they are not strictly required.
> 
> If you are actually running out of inodes, then you can use "-i" or "-N"
> to mke2fs to increase the number of inodes in a new filesystem.  Since
> this defaults to 1 inode per 8kB of space, it seems unlikely that you
> would run out of inodes before blocks unless you have lots of small files
> (maildir perhaps?  even then "modern" emails usually average > 8kB in size
> because of HTML crap, lots of headers, attachments, etc).
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/
> 


--NextPart_Webmail_9m3u9jl4l_14668_1089390974_0
Content-Type: message/rfc822

From: Andreas Dilger <adilger@clusterfs.com>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Thu, 8 Jul 2004 18:21:53 +0000
Content-Type: Multipart/mixed;
 boundary="NextPart_Webmail_9m3u9jl4l_14668_1089390974_1"

--NextPart_Webmail_9m3u9jl4l_14668_1089390974_1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA7ZC3pIg59Q01vtYRAqAgAKDE+Qn1SZqFCRXdOiHNSMmSVtOH/ACeMBdo
IWwwWr3GQyq2NqxQq4EYtqw=
=0zfp
-----END PGP SIGNATURE-----

--NextPart_Webmail_9m3u9jl4l_14668_1089390974_1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--NextPart_Webmail_9m3u9jl4l_14668_1089390974_0--
