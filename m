Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268834AbUHUDZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268834AbUHUDZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 23:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268835AbUHUDZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 23:25:41 -0400
Received: from thunk.org ([140.239.227.29]:2227 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268834AbUHUDZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 23:25:38 -0400
Date: Fri, 20 Aug 2004 23:25:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pankaj Agarwal <pankaj@pnpexports.com>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: how to identify filesystem type
Message-ID: <20040821032520.GA15772@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andries Brouwer <aebr@win.tue.nl>,
	Pankaj Agarwal <pankaj@pnpexports.com>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de> <000901c486c9$40d92e60$6d59023d@dreammachine> <20040820204656.GW8967@schnapps.adilger.int> <20040820215858.GA5771@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820215858.GA5771@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 11:58:58PM +0200, Andries Brouwer wrote:
> 
> I suppose this code started as part of mount(8). For example,
> 
> # mount --guess-fstype /dev/hdb2
> reiserfs

Actually, it was fsck's filesystem type detection code, and it's since
been completely rewritten.  

> However, I cannot stress often enough that these are unreliable guesses.
> It is really undesirable when standard infrastructure starts depending
> on 99.7% guesses.

It's certainly possible for mistakes to be made, but it is really
quite reliable at this point --- escpecially since various
filesystem's mkfs programs and various lvm partition initialization
progams are pretty good about erasing other filesystems' signatures as
part of the mkfs/partition init process.  

Everything is really a "guess" at some level; there is no guarantee
that /etc/fstab is 100% accurate, or that the partition table's type
fields are accurate.  I will say that the ID code in the blkid library
is pretty paranoid about sanity checks, although of course it could be
better.

> Consequently, "blkid" is a really bad name. It gives no indication
> of the guessed nature of its results.
> 
> (I see that my current version is also broken:
> # blkid -v
> blkid 1.0.0 (12-Feb-2003)
> # blkid
> ...
> /dev/sda4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
> /dev/sda1: UUID="1ac5969c-8fdf-4f69-934a-c6103d93c05d" TYPE="ext2" 
> /dev/sdb4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
> /dev/sdb1: LABEL="CF_CARD032M" UUID="2001-1207" TYPE="msdos" 
> ...
> Here no /dev/sda1 and no /dev/sdb4 exist.)

Blkid deliberately doesn't revalidate devices without any command-line
arguments, because certain devices might timeout or block for a
long-time.  If you use "blkid /dev/sdb4", or use the library
interfaces, it will revalidate any entries found in the cache file
before returning them.

						- Ted
