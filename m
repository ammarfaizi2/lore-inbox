Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753847AbWKFWBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbWKFWBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbWKFWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:01:48 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:48308 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1753845AbWKFWBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:01:47 -0500
Date: Mon, 6 Nov 2006 15:01:40 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: =?utf-8?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061106220140.GD6012@schatzie.adilger.int>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>,
	=?utf-8?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454FAAF8.8080707@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2006  15:36 -0600, Eric Sandeen wrote:
> OTOH if one filesystem (say, pipes) can wrap the numbers very quickly,
> while other spaces are otherwise more immune, then having it global puts
> everything using it at a bit more risk.

One option is having a per-sb counter (to avoid wraps on not-heavily-used
filesystems), and also a per-sb flag that indicates if the counter has
wrapped.  If that happens, it would be possible to do a lookup in the
inode hash for a conflicting inode number, and skip those.  It is more
overhead, but only hit in the case where there is danger (i.e. post wrap).

There should also be a flag indicating if the caller is actually using
the inum supplied by new_inode or not, to avoid the overhead if it just
replaces i_ino with its own value.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

