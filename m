Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbTLaXso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTLaXso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:48:44 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:3325 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S265296AbTLaXsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:48:43 -0500
Date: Wed, 31 Dec 2003 16:48:24 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20031231164824.I6144@schatzie.adilger.int>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
	Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Dec 31, 2003 at 10:55:36PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 31, 2003  22:55 +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 	h) nfsd uses device number as a substitute for export ID if said
> ID is not given explicitly.  That, BTW, is a big problem for crackpipe
> dreams about random device numbers - export ID _must_ be stable across
> reboots.

We had a problem with this and Lustre, when we NFS export it.  Lustre is
already a network filesystem so we don't have a device number.  I had a
discussion with Neil Brown about this and suggested that we allow NFS to
get a _real_ stable export ID from the filesystem (e.g. superblock UUID
or similar) instead of the device number hackery which only has a vague
relationship to stable.

We implemented it for Lustre with a filesystem option FS_NFSEXP_FSID
that tells nfsd it can export such a filesystem in the absence of
FS_REQUIRES_DEV and then put our export ID into sb->s_dev (although I'd
prefer something slightly cleaner than that).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

