Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279959AbRKDXBR>; Sun, 4 Nov 2001 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279968AbRKDXBI>; Sun, 4 Nov 2001 18:01:08 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:14559 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S279959AbRKDXAu>; Sun, 4 Nov 2001 18:00:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christian Laursen <xi@borderworlds.dk>
Subject: Re: Ext2 directory index, updated
Date: Mon, 5 Nov 2001 00:01:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <m3hesatcgq.fsf@borg.borderworlds.dk> <20011104222259Z17054-18972+2@humbolt.nl.linux.org>
In-Reply-To: <20011104222259Z17054-18972+2@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104230046Z17057-18972+12@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 11:24 pm, Daniel Phillips wrote:
> On November 4, 2001 11:09 pm, Christian Laursen wrote:
> > Daniel Phillips <phillips@bonn-fries.net> writes:
> > However, when I accidentally killed the uml, it left me with an unclean
> > filesystem which fsck refuses to touch because it has unsupported 
features.
> > 
> > Even the latest version does this.
> > 
> > Is there a patch for fsck, that fixes this somewhere?
> 
> [...]
> There is an easy way to turn that FEATURE_COMPAT flag back off so you can 
> fsck, but I don't know it and I should.

It's debug2fs, details to come.

The COMPAT_FEATURE thing is a problem, we *are* supposed to be able to fsck
a volume that has indexed directories on it with old versions of fsck, and 
it's only the COMPAT_FEATURE flag that prevents this.  You tried fsck -f 
and it didn't work, right?

For using the -o index option on a non-throwaway volume, we should do this:

 void ext2_add_compat_feature (struct super_block *sb, unsigned feature)
 {
+	return;
 	if (!EXT2_HAS_COMPAT_FEATURE(sb, feature))
 	{

And afterwards you can rm -rf your test directory, though actually normal 
ext2 shouldn't see anything unusual about it.  The real reason for rm'ing the 
test directory is so that I can tweak the index format in upcoming prerelease 
versions.

I've disabled the add_compat_feature here for now, because until fsck can 
handle it, it just causes trouble.  I'll go read Andreas' writeup on the 
COMPAT flags again and see if I can come up with a more friendly 
interpretation.

--
Daniel
