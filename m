Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBVXF3>; Thu, 22 Feb 2001 18:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRBVXFT>; Thu, 22 Feb 2001 18:05:19 -0500
Received: from hermes.mixx.net ([212.84.196.2]:48140 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129225AbRBVXFI>;
	Thu, 22 Feb 2001 18:05:08 -0500
Message-ID: <3A959AE2.6BAFF36E@innominate.de>
Date: Fri, 23 Feb 2001 00:04:02 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>, tytso@valinux.com,
        Linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
In-Reply-To: <E14VvfG-00035D-00@beefcake.hdqt.valinux.com> <200102221816.f1MIGWt04170@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Daniel writes:
> > All references to "." and ".." are now intercepted and never reach the
> > filesystem level.
> 
> Ted writes:
> >    From: Daniel Phillips <phillips@innominate.de>
> >
> >    I'll leave that up to somebody else - we now have two alternatives, the
> >    100%, no-compromise INCOMPAT solution, and the slightly-bruised but
> >    still largely intact forward compatible solution.  I'll maintain both
> >    solutions for now code so it's just as easy to choose either in the end.
> >
> > Well, the $64,000 question is exactly how much performance does it cost?
> > My guess is that it will be barely measurable, but only benchmarks will
> > answer that question.
> 
> One important question as to the disk format is whether the "." and ".."
> interception by VFS is a new phenomenon in 2.4 or if this also happened
> in 2.2?  If so, then having these entries on disk will be important
> for 2.2 compatibility, and you don't want to have different on-disk formats
> between 2.2 and 2.4.

The answer is 'yes', it's been in since at least the beginning of 2.2:

 
http://innominate.org/cgi-bin/lksr/linux/fs/namei.c?rev=1.1&content-type=text/x-cvsweb-markup&cvsroot=v2.2

Search for '.'.

By the way, out whole linux cvsweb tree is here:

	http://lksr.org/ 

will all versions of linux back to linux-0.97.pl5, with a makefile that
starts out with:

	#
	# Makefile for linux.
	# If you don't have '-mstring-insns' in your gcc (and nobody but me has
:-)
	# remove them from the CFLAGS defines.
	#

Getting back on topic, this makes the idea of getting rid of the actual
on-disk "." and ".." entries a little less scary, though I am keeping in
mind the fact that having those entries on disk could in some extreme
circumstance help fsck recover a a corrupted directory tree little
better and more automatically.

I resolve not to take a position on this subject, and I will carry
forward both a 'squeaky clean' backward-compatible version that sets an
INCOMPAT flag, and a 'slightly tarnished' but very clever version that
is both forward and backward-compatible, along the lines suggested by
Ted.  Both flavors have the desireable property that old versions of
fsck with no knowledge of the new index structure can remove the indices
automatically, with fsck -y.

--
Daniel
