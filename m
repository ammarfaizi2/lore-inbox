Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCBTkS>; Fri, 2 Mar 2001 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCBTj7>; Fri, 2 Mar 2001 14:39:59 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:37895
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S129438AbRCBTjr>; Fri, 2 Mar 2001 14:39:47 -0500
Date: Fri, 02 Mar 2001 14:38:56 -0500
From: Chris Mason <mason@suse.com>
To: Steve Lord <lord@sgi.com>
cc: Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
Message-ID: <412990000.983561936@tiny>
In-Reply-To: <200103021925.f22JPPU02085@jen.americas.sgi.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, March 02, 2001 01:25:25 PM -0600 Steve Lord <lord@sgi.com> wrote:

>> For why ide is beating scsi in this benchmark...make sure tagged queueing
>> is on (or increase the queue length?).  For the xlog.c test posted, I
>> would expect scsi to get faster than ide as the size of the write
>> increases.
> 
> I think the issue is the call being used now is going to get slower the
> larger the device is, just from the point of view of how many buffers it
> has to scan.

filemap_fdatawait, filemap_fdatasync, and fsync_inode_buffers all restrict
their scans to a list of dirty buffers for that specific file.  Only
file_fsync goes through all the dirty buffers on the device, and the ext2
fsync path never calls file_fsync.

Or am I missing something?

-chris



