Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQLERnn>; Tue, 5 Dec 2000 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLERnX>; Tue, 5 Dec 2000 12:43:23 -0500
Received: from zeus.kernel.org ([209.10.41.242]:34052 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129663AbQLERnL>;
	Tue, 5 Dec 2000 12:43:11 -0500
Date: Tue, 5 Dec 2000 17:09:50 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
Message-ID: <20001205170950.D10663@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0012042232220.7166-100000@weyl.math.psu.edu> <Pine.LNX.4.10.10012041955000.860-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10012041955000.860-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 04, 2000 at 08:00:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 04, 2000 at 08:00:03PM -0800, Linus Torvalds wrote:
> 
> On Mon, 4 Dec 2000, Alexander Viro wrote:
> > 
> This _is_ what clear_inode() does in pre5 (and in pre4, for that matter):
> 
> 	void clear_inode(struct inode *inode)
> 	{  
> 	        if (!list_empty(&inode->i_dirty_buffers))
> 	                invalidate_inode_buffers(inode);

That is still buggy.  We MUST NOT invalidate the inode buffers unless
i_nlink == 0, because otherwise a subsequent open() and fsync() will
have forgotten what buffers are dirty, and hence will fail to
synchronise properly with the disk.

Al, I agreed with your observation on bforget() needing the
remove_inode_queue() call.  Is there anywhere else we need it?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
