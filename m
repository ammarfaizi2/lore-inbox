Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281382AbRKEWLR>; Mon, 5 Nov 2001 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKEWLK>; Mon, 5 Nov 2001 17:11:10 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61943 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281382AbRKEWK7>;
	Mon, 5 Nov 2001 17:10:59 -0500
Date: Mon, 5 Nov 2001 15:10:07 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christian Laursen <xi@borderworlds.dk>, linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
Message-ID: <20011105151006.G3957@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Christian Laursen <xi@borderworlds.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <m3hesatcgq.fsf@borg.borderworlds.dk> <20011104222259Z17054-18972+2@humbolt.nl.linux.org> <20011104230046Z17057-18972+12@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011104230046Z17057-18972+12@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Mon, Nov 05, 2001 at 12:01:59AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2001  00:01 +0100, Daniel Phillips wrote:
> For using the -o index option on a non-throwaway volume, we should do this:
> 
>  void ext2_add_compat_feature (struct super_block *sb, unsigned feature)
>  {
> +	return;
>  	if (!EXT2_HAS_COMPAT_FEATURE(sb, feature))
>  	{
> 
> And afterwards you can rm -rf your test directory, though actually normal 
> ext2 shouldn't see anything unusual about it.  The real reason for rm'ing the 
> test directory is so that I can tweak the index format in upcoming prerelease 
> versions.

Well, e2fsck _should_ really know about the fact that there are indexed
directories in the filesystem, which is what the COMPAT flag flag is for.
The only current issue is that e2fsck doesn't understand this compat flag.

> I've disabled the add_compat_feature here for now, because until fsck can 
> handle it, it just causes trouble.  I'll go read Andreas' writeup on the 
> COMPAT flags again and see if I can come up with a more friendly 
> interpretation.

No, COMPAT is the friendliest.  It means old kernels can read/write this
filesystem without problems, just that e2fsck can't/won't check it.  Even
though an old fsck _probably_ won't break such a filesystem, there is no
guarantee of that, and it definitely won't validate the indexes, so a
"successfull" fsck of an indexed directory doesn't mean anything until it
can understand this COMPAT flag.

That said, I agree that turning the COMPAT flag off for short term testing
is probably not fatal, but I thought we were not going to even suggest
using non-throwaway filesystems until the hash function was finalized?  In
the end, if an updated e2fsck detects the DIR_INDEX flag (and valid indexes
therein) it will turn on the COMPAT flag for us, so all will be well.  I
don't advise that we push for patch inclusion until e2fsck is done, however.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

