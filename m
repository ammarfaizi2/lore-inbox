Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132982AbRDUWak>; Sat, 21 Apr 2001 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132984AbRDUWaa>; Sat, 21 Apr 2001 18:30:30 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:55062 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S132982AbRDUWaV>;
	Sat, 21 Apr 2001 18:30:21 -0400
Message-ID: <20010422003013.A18236@win.tue.nl>
Date: Sun, 22 Apr 2001 00:30:13 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Ville Holma" <ville.holma@pp.htv.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: a way to restore my hd ?
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>; from Ville Holma on Sat, Apr 21, 2001 at 06:52:01PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 06:52:01PM +0300, Ville Holma wrote:

> EXT2-fs: #blocks per group too big: 2147516416

> debian:~# e2fsck /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> Corruption found in superblock.  (frags_per_group = 2147516416).

> debian:~# e2fsck -b -2147450879 /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> e2fsck: Attempt to read block from filesystem resulted in short read while
> trying to open /dev/hdb7

(1) e2fsck is very good at correcting minor problems. But if something
really bad happened, e2fsck will make matters only worse. If your data
is valuable, keep e2fsck far away. (For example, make a copy with dd
before starting to fiddle with the disk contents.)

(2) No doubt you do not really have a disk with over 2^31 blocks,
so this suggestion from e2fsck is just a bug in e2fsck.
Maybe -b 32768 would have been more successful.

It might be interesting to look at the contents of the superblock
to see what kind of corruption occurred. Bad memory tends to change
a single bit. Here your data suggests more than one corrupted bit.
With disk I/O problems one often sees lots of errors - maybe blocks
with all zeros or all ones, or all data shifted by one or more bits, etc.

