Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTJQGsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 02:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTJQGsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 02:48:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263319AbTJQGsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 02:48:10 -0400
Date: Fri, 17 Oct 2003 08:48:08 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Greg Stark'" <gsstark@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031017064808.GY1128@suse.de>
References: <785F348679A4D5119A0C009027DE33C105CDB2D0@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2D0@mcoexc04.mlm.maxtor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Mudama, Eric wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Stark
> >
> > Ideally postgres just needs to call some kind of fsync 
> > syscall that guarantees
> > it won't return until all buffers from the file that were 
> > dirty prior to the
> > sync were flushed and the disk was really synced. It's fine 
> > for buffers that
> > were dirtied later to get synced as well, as long as all the 
> > old buffers are
> > all synced.
> 
> This checkpointing doesn't exist in ATA, only in SCSI I think.  You can get
> similar behavior in ATA-7 capable drives (which I don't think are on the
> market yet) by issuing FUA commands.  These will not return good status
> until the data is on the media, and they can be intermingled with other
> cached writes without destroying overall performance.
> 
> If there was some way to define a file as FUA instead of normal, then you'd
> know every write to it would be on the media if the status was good.
> However, you may have committed your journal or whatever and have possibly
> significantly stale data on the drive's cache in the user data area.
> 
> As far as the actual file-system call mechanism to achive this, I have no
> idea... I know very little about linux internals, I just try to answer
> disk-related questions.

Yes that would be very nice, but unfortunately I think FUA in ATA got
defined as not implying ordering (the FUA write would typically go
straight to disk, ahead of any in-cache dirty data). Which makes it less
useful, imo.

-- 
Jens Axboe

