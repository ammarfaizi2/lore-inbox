Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCHPrd>; Thu, 8 Mar 2001 10:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRCHPrX>; Thu, 8 Mar 2001 10:47:23 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:8458 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129164AbRCHPrO>; Thu, 8 Mar 2001 10:47:14 -0500
Date: Thu, 08 Mar 2001 10:45:32 -0500
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, Jens Axboe <axboe@suse.de>
cc: David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <503800000.984066332@tiny>
In-Reply-To: <20010307205659.E9080@redhat.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, March 07, 2001 08:56:59 PM +0000 "Stephen C. Tweedie"
<sct@redhat.com> wrote:

> Hi,
> 
> On Wed, Mar 07, 2001 at 09:15:36PM +0100, Jens Axboe wrote:
>> On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
>> > 
>> > For most fs'es, that's not an issue.  The fs won't start writeback on
>> > the primary disk at all until the journal commit has been acknowledged
>> > as firm on disk.
>> 
>> But do you then force wait on that journal commit?
> 
> It doesn't matter too much --- it's only the writeback which is doing
> this (ext3 uses a separate journal thread for it), so any sleep is
> only there to wait for the moment when writeback can safely begin:
> users of the filesystem won't see any stalls.

It is similar under reiserfs unless the log is full and new transactions
have to wait for flushes to free up the log space.  It is probably valid to
assume the dedicated log device will be large enough that this won't happen
very often, or fast enough (nvram) that it won't matter when it does happen.

> 
>> A barrier operation is sufficient then. So you're saying don't
>> over design, a simple barrier is all you need?
> 
> Pretty much so.  The simple barrier is the only thing which can be
> effectively optimised at the hardware level with SCSI anyway.
> 

The simple barrier is a good starting point regardless.  If we can find
hardware where it makes sense to do cross queue barriers (big raid
controllers?), it might be worth trying.

-chris



