Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280943AbRKGUTK>; Wed, 7 Nov 2001 15:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKGUTA>; Wed, 7 Nov 2001 15:19:00 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36347 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280943AbRKGUSv>;
	Wed, 7 Nov 2001 15:18:51 -0500
Date: Wed, 7 Nov 2001 13:18:33 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107131833.G5922@lynx.no>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>; from roy@karlsbakk.net on Wed, Nov 07, 2001 at 04:00:55PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  16:00 +0100, Roy Sigurd Karlsbakk wrote:
> I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> I see no difference at all. After a chrash, it really wants to run fsck
> anyway.

If you are getting a real* fsck for an "ext3" filesystem there are two
possibilities:

1) You actually have ext2, not ext3 - check /proc/mounts to be sure.
2) After 20 (by default) crashes, ext3 filesystems are fsck'd anyways.
   This is NOT because ext3 is bad/unreliable, but because hardware,
   RAM, kernels can be bad.  Use "tune2fs -c 50" to change this interval
   to every 50 mounts.  It is a bad idea to turn it off completely.

(*) Note that e2fsck WILL run on each boot, but will only recover the journal
    and clean up orphan inodes.  That will take < 2 seconds, and is not a sign
    that something is wrong with the filesystem.

> I've tried ReiserFS before, with no fsck after chrashes - is this
> because ReiserFS is better, or is it more like a hope-it's-ok-thinkig?

The latter - Hans and other reiserfs folks acknowledge that reiserfsck
is NOT safe enough to run on each boot, so they don't suggest running it
unless you have a problem.  e2fsck IS very good, so it can run on each
boot.  There are still lots of problems reported with reiserfs, and Hans
acknowledges that many of them are due to memory/hardware/kernel problems,
so it IS still a good idea to run fsck periodically at boot, but reiserfsck
cannot do that yet.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

