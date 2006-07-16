Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWGPQ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGPQ4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWGPQ4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:56:47 -0400
Received: from thunk.org ([69.25.196.29]:59040 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750735AbWGPQ4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:56:46 -0400
Date: Sun, 16 Jul 2006 12:56:48 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716165648.GB6643@thunk.org>
Reply-To: tytso@mit.edu
Mail-Followup-To: tytso@mit.edu, Christian Trefzer <ctrefzer@gmx.de>,
	Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716162831.GB22562@zeus.uziel.local>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 06:28:31PM +0200, Christian Trefzer wrote:
> I don't quite understand. You are supposed to dd_rescue the whole block
> device to a working drive and use fsck on the copy.  Whatever is lost in
> the process must of course be restored from a recent backup. But, as a
> friend of mine put it recently, people don't need backup, they only need
> restore ; )

If the disk is known to be bad, yes, and the number of bad blocks is
growing.  On the other hand, disks can and will have a few bad blocks,
or bad writes that don't mean the disk is going bad, and a modern
filesystem should be robust enough that a single failed sector doesn't
cause the filesystem to go completely kaput.

In fact, one of the scary trends with hard drives is that size is
continuing to grow expoentially, access times linearly (more or less),
and error rates (errors per kilobytes per unit time) are remaining
more or less constant.

The fact that reiserfs uses a single B-tree to store all of its data
means that very entertaining things can happen if you lose a sector
containing a high-level node in the tree.  It's even more entertaining
if you have image files (like initrd files) in reiserfs format stored
in reiserfs, and you run the recovery program on the filesystem.....

Yes, I know that reiserfs4 is alleged to fix this problem, but as far
as I know it is still using a single unitary tree, with all of the
pitfalls that this entails.

Now, that being said, that by itself is not a reason not to decide not
to include reseirfs4 into the mainline sources.  (I might privately
get amused when system administrators use reiserfs and then report
massive data loss, but that's my own failure of chairty; I'm working
on it.)  For the technical reasons why resierfs4 hasn't been
integrated, please see the mailing list archives.

						- Ted
