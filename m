Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130757AbRAWS27>; Tue, 23 Jan 2001 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130743AbRAWS2t>; Tue, 23 Jan 2001 13:28:49 -0500
Received: from [62.172.234.2] ([62.172.234.2]:41661 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129933AbRAWS2l>; Tue, 23 Jan 2001 13:28:41 -0500
Date: Tue, 23 Jan 2001 18:28:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Rohland <cr@sap.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: set_page_dirty/page_launder deadlock
In-Reply-To: <qww4ryv308j.fsf@sap.com>
Message-ID: <Pine.LNX.4.21.0101231819440.1244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2001, Christoph Rohland wrote:
> On Sun, 14 Jan 2001, Linus Torvalds wrote:
> > Well, as the new shm code doesn't return 1 any more, the whole
> > locked page handling should just be deleted. ramfs always just
> > re-marked the page dirty in its own "writepage()" function, so it
> > was only shmfs that ever returned this special case, and because of
> > other issues it already got excised by Christoph..
> 
> No, that's not completely right. There may be rare cases like out of
> swap that shmem_write does return 1. But couldn't it simply set the
> page dirty like ramfs_writepage?

I notice that shmem_writepage() in 2.4.1-pre10 is still doing an
early "return 1" without UnlockPage(page): surely that's wrong?

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
