Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSBGMHO>; Thu, 7 Feb 2002 07:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSBGMHD>; Thu, 7 Feb 2002 07:07:03 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:4618 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287307AbSBGMGr>; Thu, 7 Feb 2002 07:06:47 -0500
Date: Thu, 7 Feb 2002 13:06:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] VM_IO fixes
In-Reply-To: <3C621B44.10C424B9@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202071259510.5900-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Feb 2002, Andrew Morton wrote:

> Any filesystem which implements its own mmap() method, and which
> does not call generic_file_mmap() needs to be changed to clear
> VM_IO inside its mmap function.  All in-kernel filesystems are
> OK, as is XFS.  And the only breakage this can cause to out-of-kernel
> filesystems is failure to include mappings in core files, and
> inability to use PEEKUSR.

You forgot shared memory via mm/shmem.c and ipc/shm.c.
Another possibility is to test whether the driver provides a nopage
function, as i/o areas are usually mapped with io_remap_page_range. The
only exception I found are drivers under drivers/sgi/char, which use some
really dirty tricks in their nopage function.

bye, Roman

