Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSB1QAx>; Thu, 28 Feb 2002 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293378AbSB1P6c>; Thu, 28 Feb 2002 10:58:32 -0500
Received: from 216-42-72-159.ppp.netsville.net ([216.42.72.159]:46287 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293441AbSB1P4k>; Thu, 28 Feb 2002 10:56:40 -0500
Date: Thu, 28 Feb 2002 10:55:46 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <3746210000.1014911746@tiny>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 28, 2002 09:36:52 AM -0600 James Bottomley <James.Bottomley@steeleye.com> wrote:

> Doug Gilbert prompted me to re-examine my notions about SCSI drive caching, 
> and sure enough the standard says (and all the drives I've looked at so far 
> come with) write back caching enabled by default.

Really.  Has it always been this way?

> 
> Since this is a threat to the integrity of Journalling FS in power failure 
> situations now, I think it needs to be addressed with some urgency.
> 
> The "quick fix" would obviously be to get the sd driver to do a mode select at 
> probe time to turn off the WCE and RCD bits (this will place the cache into 
> write through mode), which would match the assumptions all the JFSs currently 
> make.  I'll see if I can code up a quick patch to do this.

Ok.

> 
> A longer term solution might be to keep the writeback cache but send down a 
> SYNCHRONIZE CACHE command as part of the back end completion of a barrier 
> write, so the fs wouldn't get a completion until the write was done and all 
> the dirty cache blocks flushed to the medium.

Right, they could just implement ORDERED_FLUSH in the barrier patch.

> 
> Clearly, there would also have to be a mechanism to flush the cache on 
> unmount, so if this were done by ioctl, would you prefer that the filesystem 
> be in charge of flushing the cache on barrier writes, or would you like the sd 
> device to do it transparently?

How about triggered by closing the block device.  That would also cover
people like oracle that do stuff to the raw device.

-chris

