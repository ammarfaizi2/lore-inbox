Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUHTV7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUHTV7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUHTV7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:59:08 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9736 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268766AbUHTV7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:59:03 -0400
Date: Fri, 20 Aug 2004 23:58:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pankaj Agarwal <pankaj@pnpexports.com>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: how to identify filesystem type
Message-ID: <20040820215858.GA5771@pclin040.win.tue.nl>
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de> <000901c486c9$40d92e60$6d59023d@dreammachine> <20040820204656.GW8967@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820204656.GW8967@schnapps.adilger.int>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:46:56PM -0600, Andreas Dilger wrote:

> There is a tool available as part of e2fsprogs (1.34 maybe?) which is
> called "blkid" that identifies block devices.  Currently fsck uses this
> to know what fsck.fstype to use, and it was my hope to have mount(8)
> use this also (never got around to doing that work).
> 
> The benefits of blkid are that you can use it as a regular user, even
> without read access to the disk (it will return cached values generated
> by root if you don't have read access to the block device), it also will
> print LABEL and UUID information to identify the filesystem, if you use
> it repeatedly from some application it doesn't re-scan all of the devices
> each time (important for large numbers of block devices).

I suppose this code started as part of mount(8). For example,

# mount --guess-fstype /dev/hdb2
reiserfs

However, I cannot stress often enough that these are unreliable guesses.
It is really undesirable when standard infrastructure starts depending
on 99.7% guesses.

Consequently, "blkid" is a really bad name. It gives no indication
of the guessed nature of its results.

(I see that my current version is also broken:
# blkid -v
blkid 1.0.0 (12-Feb-2003)
# blkid
...
/dev/sda4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
/dev/sda1: UUID="1ac5969c-8fdf-4f69-934a-c6103d93c05d" TYPE="ext2" 
/dev/sdb4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
/dev/sdb1: LABEL="CF_CARD032M" UUID="2001-1207" TYPE="msdos" 
...
Here no /dev/sda1 and no /dev/sdb4 exist.)

Andries

