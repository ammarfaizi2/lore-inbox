Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313355AbSC2FQm>; Fri, 29 Mar 2002 00:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313356AbSC2FQc>; Fri, 29 Mar 2002 00:16:32 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:37883 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313355AbSC2FQW>; Fri, 29 Mar 2002 00:16:22 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 28 Mar 2002 22:14:20 -0700
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
Message-ID: <20020329051420.GO21133@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3CA356AE.2E61F712@zip.com.au> <Pine.GSO.4.21.0203281838310.25746-100000@weyl.math.psu.edu> <3CA3B48F.25F9042D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2002  16:25 -0800, Andrew Morton wrote:
> BTW, ext3 keeps a kdev_t on-disk for external journals.  The
> external journal support is experimental, added to allow people
> to evaluate the usefulness of external journalling.  If we
> decide to retain the capability we'll be moving it to a UUID
> or mount-based scheme.  So if the kdev_t is being a problem,
> I think we can just break it.

Actually, I believe it would be keeping a "dev_t" on the disk, so
if we are using it from within the kernel we should be using
"to_kdevt()" or whatever the function is called.

That reminds me - I _do_ have the mount-based stuff for journal
devices set up.  At fs mount time, the ext3 code calls a helper
function which will locate the journal by its UUID.  The only
real reason for the s_journal_dev might be for e2fsck to locate
the journal device more easily, but it is also pretty easy to
find the journal by UUID in user space.

I'm just woefully behind on getting patches out of my tree.  At least
with my OLS paper I'm "forced" to finish off the ext3 online resizing
code within the next 3 months or so.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

