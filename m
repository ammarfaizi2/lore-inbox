Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSHFUx3>; Tue, 6 Aug 2002 16:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHFUwW>; Tue, 6 Aug 2002 16:52:22 -0400
Received: from waste.org ([209.173.204.2]:36587 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316339AbSHFUvD>;
	Tue, 6 Aug 2002 16:51:03 -0400
Date: Tue, 6 Aug 2002 15:54:32 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Richard Bonomo <bonomo@sal.wisc.edu>
cc: linux-kernel@vger.kernel.org, Richard Bonomo <bonomo@maddog.sal.wisc.edu>
Subject: Re: backups/dumps/caches
In-Reply-To: <200208060032.g760WZP107993@maddog.sal.wisc.edu>
Message-ID: <Pine.LNX.4.44.0208061533520.14600-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Richard Bonomo wrote:

> Hello!
>
> I have been trying to come up to speed on
> the issue of dumping file systems from
> 2.4.x kernels using dumps.  I located
> Linus' unequivocal words about the dangers
> of using dump.   I have a couple of questions:
>
> 1. Do the same warnings apply to XFS and xfsdump?
>    (Is the caching system used with the newer
>     kernel used only with certain file system types?)

The essential problem with dump is that the current state of a filesystem
is a combination of what's in memory and what's on disk. With a journalled
filesystem, what's on disk at any given moment is self-consistent
(ignoring various levels of journalling). But dump can't see the whole
of the disk at any given moment, so it has no way of telling whether piece
A it read one second is consistent with piece B it read on the next.

There's no way to make this work cleanly short of snapshots (which 2.4 LVM
has), and the hacks to make dump mostly work (which is the best it can
ever possibly hope for on a live filesystem) were getting in the way of
doing other things right, so the dump approach of going under the
filesystem to the block device was officially declared stupid.

> 2. Perhaps, naively, is it possible to shut off
>   caching temporarily (and without rebooting),
>   accepting the performance hit, while a dump
>   is done, and then restart caching afterwards?

Yep. Switch to single user mode, sync all filesystems, unmount them for
good measure, dump, then switch back to multiuser mode.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

