Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAZLht>; Fri, 26 Jan 2001 06:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRAZLhk>; Fri, 26 Jan 2001 06:37:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:38109 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129562AbRAZLh2>;
	Fri, 26 Jan 2001 06:37:28 -0500
Date: Fri, 26 Jan 2001 11:35:07 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode->i_dirty_buffers redundant ?
Message-ID: <20010126113507.J11607@redhat.com>
In-Reply-To: <200101251047.QAA16434@vxindia.veritas.com> <20010125164432.A12984@redhat.com> <3A708722.C21EC12A@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A708722.C21EC12A@innominate.de>; from phillips@innominate.de on Thu, Jan 25, 2001 at 09:05:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 09:05:54PM +0100, Daniel Phillips wrote:
> "Stephen C. Tweedie" wrote:
> > We also maintain the 
> > per-page buffer lists as caches of the virtual-to-physical mapping to
> > avoid redundant bmap()ping.
> 
> Could you clarify that one, please?

The buffer contains a physical label for the block's location on disk.
The page cache is indexed purely by logical location, so doing IO
to/from the page cache requires us to lookup the physical locations of
each block within the page.

Caching the buffer_heads for page cache pages means that once those
lookups are done once, further IO on the same page can bypass the
lookup and go straight to disk.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
