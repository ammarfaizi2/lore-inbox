Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRCENYP>; Mon, 5 Mar 2001 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRCENYA>; Mon, 5 Mar 2001 08:24:00 -0500
Received: from ns.suse.de ([213.95.15.193]:51977 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129250AbRCENX2>;
	Mon, 5 Mar 2001 08:23:28 -0500
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <412990000.983561936@tiny>
From: Andi Kleen <ak@suse.de>
Date: 05 Mar 2001 14:23:23 +0100
In-Reply-To: Chris Mason's message of "2 Mar 2001 20:43:19 +0100"
Message-ID: <oupvgpotkms.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:


> filemap_fdatawait, filemap_fdatasync, and fsync_inode_buffers all restrict
> their scans to a list of dirty buffers for that specific file.  Only
> file_fsync goes through all the dirty buffers on the device, and the ext2
> fsync path never calls file_fsync.
> 
> Or am I missing something?

If the filesystems tested had blocksize < PAGE_SIZE the fsync would try
to sync everything, not walk the dirty buffers directly.
So e.g. if one of the file systems tested was generated with old ext2 utils
that do not use 4K block size then some performance difference could be 
explained.


-Andi

