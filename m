Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271225AbRHPNkR>; Thu, 16 Aug 2001 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270902AbRHPNkI>; Thu, 16 Aug 2001 09:40:08 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:64774 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S268511AbRHPNjw>;
	Thu, 16 Aug 2001 09:39:52 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 16 Aug 2001 15:35:41 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816153541.A9265@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816.053415.10296707.davem@redhat.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To be honest, you really shouldn't care about this.  If you are
> writing a block device, the block/scsi/ide/whatever layer should take
> care to only give you memory that can be DMA'd to/from.
> 
> Same goes for the networking layer.

bttv is neither blkdev nor networking ...

The current kernel's bttv (0.7.x) uses vmalloc_32() for video buffers
and remaps these pages to userspace then.  My current devel versions
(0.8.x) use a completely different approach:  mmap() simply returns
shared anonymous memory, and bttv uses kiobufs then to lock pages for
I/O.  

This has the adwantage that the video buffers don't waste unswappable
kernel memory any more.  It also easy to write video data to any
userspace address (read() does that for example, so I don't have to
copy_to_user() the big video frames).

On the other hand I have a new problem now:  I have to deal with highmem
pages (that works with the highmem-I/O patches) and with pages which are
outside the DMA-able memory area (hmm...).

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
