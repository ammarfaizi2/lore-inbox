Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753858AbWKGAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbWKGAIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbWKGAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:08:43 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:14215 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1753855AbWKGAIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:08:42 -0500
Date: Mon, 6 Nov 2006 17:08:40 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Message-ID: <20061107000840.GF6012@schatzie.adilger.int>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Tso <tytso@mit.edu>
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454FC20F.8040206@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2006  17:15 -0600, Eric Sandeen wrote:
> Christoph Hellwig wrote:
> > I agree with the conclusion, but the patch is incomplete.  You went down
> > all the way to find out what the fileystems do in this messages, so add
> > the hunks to override the defaults for non-standard filesystems to the
> > patch aswell to restore the pre-inode diet state.
> 
> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
> :)  So it's less broken with my patch than without, so at least it's
> moving forward.  So... Ted's patches get in w/o fixing up all the other
> filesystems (left as an exercise to the patch reader) but mine can't? :)

Actually, rather than blindly revert to pre-patch behaviour it would be
worthwhile to determine if PAGE_SIZE isn't the better value.  In some
cases people don't understand that i_blksize is the "optimal IO size"
and instead assume it is the filesystem blocksize.  I saw a few that were
e.g. 512 and that can't be very useful.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

