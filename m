Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293105AbSB1SEi>; Thu, 28 Feb 2002 13:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293673AbSB1SBS>; Thu, 28 Feb 2002 13:01:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1446 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293646AbSB1R7N>;
	Thu, 28 Feb 2002 12:59:13 -0500
Date: Thu, 28 Feb 2002 09:58:57 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Chris Mason <mason@suse.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020228095857.B4353@beaverton.ibm.com>
Mail-Followup-To: Chris Mason <mason@suse.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <3746210000.1014911746@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3746210000.1014911746@tiny>; from mason@suse.com on Thu, Feb 28, 2002 at 10:55:46AM -0500
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason [mason@suse.com] wrote:
> 
> ..snip..
> > 
> > Clearly, there would also have to be a mechanism to flush the cache on 
> > unmount, so if this were done by ioctl, would you prefer that the filesystem 
> > be in charge of flushing the cache on barrier writes, or would you like the sd 
> > device to do it transparently?
> 
> How about triggered by closing the block device.  That would also cover
> people like oracle that do stuff to the raw device.
> 
> -chris

Doing something in sd_release should be covered in the raw case. 
raw_release->blkdev_put->bdev->bd_op->release "sd_release".

At least from what I understand of the raw release call path :-).
-Mike
-- 
Michael Anderson
andmike@us.ibm.com

