Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281859AbRKXAlv>; Fri, 23 Nov 2001 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281860AbRKXAlm>; Fri, 23 Nov 2001 19:41:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24823 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281859AbRKXAli>;
	Fri, 23 Nov 2001 19:41:38 -0500
Date: Fri, 23 Nov 2001 17:41:20 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011123174120.Q1308@lynx.no>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <9tmocg$jfn$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Nov 23, 2001 at 04:07:44PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  16:07 -0800, H. Peter Anvin wrote:
> By author:    Andreas Dilger <adilger@turbolabs.com>
> > Don't do that.  That is only good if the filesystem thinks that there
> > is no journal, or it is using a hidden inode for the journal (i.e. if
> > you run "tune2fs -l /dev/whatever" and it doesn't have "has_journal"
> > listed in the filesystem features (this is what happened with 2.4.10).
> > Otherwise, you will delete your real journal, tune2fs will complain,
> > and then you will need to run e2fsck to clean up after yourself, before
> > re-creating your journal again.
> > 
> > If you have a filesystem with a .journal file, and you want to "hide"
> > it, just run e2fsck 1.25 while the filesystem is unmounted, and it
> > will do it for you.  If you don't want to have a .journal in the first
> > place, run tune2fs -j while the filesystem is unmounted.
> 
> This is all fine and good except for the root partition (I'm pleased
> to hear that e2fsck 1.25 will move the journal to the hidden inode for
> non-root partitions.)  It would be nice if this was done automagically
> by the mounting code instead of by fsck; that way migration would
> truly be painless.

Hmm, it could be added into the in-kernel ext3 journal recovery code, maybe,
possibly, but it would be ugly I think.  I really don't see it as being a
problem (other than a purely cosmetic one) to have a .journal file in your
root fs.  I lived with these for a couple of years OK (even some of the
early ext3 tools called them "journal.dat" (i.e. not a leading dot, ugh).

In 2.5 it would be easy (and preferrable for other reasons) to have e2fsck
run from the initramfs on the root fs before it is mounted.  That solves
the problem nicely without adding bloat into the kernel.  We could even
remove the in-kernel journal recovery at that point if we thought that the
initramfs was a reliable environment to host _critical_ boot tools. 

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

