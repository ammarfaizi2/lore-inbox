Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUA1V2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUA1V2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:28:08 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:17058 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266195AbUA1V2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:28:04 -0500
Date: Wed, 28 Jan 2004 14:28:01 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Chuck Campbell <campbell@accelinc.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel and ext3 filesystems
Message-ID: <20040128212801.GC1092@schnapps.adilger.int>
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20040124033208.GA4830@helium.inexs.com> <20040123215848.28dac746.akpm@osdl.org> <20040126145633.GA26983@helium.inexs.com> <20040126124141.6b6b84ba.akpm@osdl.org> <20040127012717.GA19704@thunk.org> <20040128205810.GA8287@helium.inexs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128205810.GA8287@helium.inexs.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 28, 2004  14:58 -0600, Chuck Campbell wrote:
> I mounted this ext3 filesystem as ext2 on my 2.2.16 kernel system. I made 
> some changes to some files (simple edits), and now when I reboot the box in
> 2.2.16, I get the following:
> 
> mount: wrong fs type, bad option, bad superblock on /dev/hdb2,
>        or too many mounted filesystems
> 
> in /var/log/messages I see:
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> EXT2-fs: ide0(3,66): couldn't mount because of unsupported optional features.
> 
> 
> I'm reticent to run any e2fsck as old as 2.2.16 kernel version against
> this filesystem, in fear of damaging it.  Is this a sane thing to consider,
> or do I need to put this disk back into a more recent box and try to mount it/
> fsck it there?

e2fsck is not tied to any particular kernel version.  You should be able to
see the features that ext2 is complaining about with "dumpe2fs -h /dev/hdb2"
in the "Features" line.  I'm guessing it's "needs_recovery" that ext2 doesn't
like.  That means that you didn't unmount the ext3 filesystem cleanly and
now ext2 can't mount it.  Running any non-prehistoric version of e2fsck
will fix it, but as always newer versions are better.  Once e2fsck has
cleaned up the journal, it can be mounted by older kernels as ext2 again.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

