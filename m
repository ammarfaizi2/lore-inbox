Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSEPOaL>; Thu, 16 May 2002 10:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSEPOaL>; Thu, 16 May 2002 10:30:11 -0400
Received: from waste.org ([209.173.204.2]:20427 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313118AbSEPOaK>;
	Thu, 16 May 2002 10:30:10 -0400
Date: Thu, 16 May 2002 09:29:49 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: "chen, xiangping" <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <200205160519.g4G5JhL29381@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0205160920220.14957-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Peter T. Breuer wrote:

> "Oliver Xymoron wrote:"
> > If the system runs out of memory, it may try to flush pages that are
> > queued to your NBD device. That will try to allocate more memory for
> > sending packets, which will fail, meaning the VM can never make progress
> > freeing pages. Now your box is dead.
>
> The system can avoid this by
>
>  a) not flushing sync  (i.e. giving up on pages that won't flush immediately)
>  b) being nondeterministic about it .. not always retrying the same
>     thing again and again.

Helpful but insufficient. What is to stop getting into a situation where
_all_ memory that is pageable is only pageable via network? Even if you
have a big box, if you do large streaming writes to about 20 NBD devices,
you'll discover that each device queue can hold many megabytes of dirty
data.. Try pulling out your ethernet cable for a moment and watch the
thing strangle itself.

Harder to get into this situation with NFS, but still doable.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

