Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbQLER7h>; Tue, 5 Dec 2000 12:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLER71>; Tue, 5 Dec 2000 12:59:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18358 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130192AbQLER7P>;
	Tue, 5 Dec 2000 12:59:15 -0500
Date: Tue, 5 Dec 2000 12:28:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@redhat.com>, Christoph Rohland <cr@sap.com>,
        Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <20001205170950.D10663@redhat.com>
Message-ID: <Pine.GSO.4.21.0012051225000.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Stephen C. Tweedie wrote:

> That is still buggy.  We MUST NOT invalidate the inode buffers unless
> i_nlink == 0, because otherwise a subsequent open() and fsync() will
> have forgotten what buffers are dirty, and hence will fail to
> synchronise properly with the disk.

Correction: they _will_ eventually end up on disk, but yes, fsync() may
miss them.

> Al, I agreed with your observation on bforget() needing the
> remove_inode_queue() call.  Is there anywhere else we need it?

unmap_buffer(). Same story, but on the data side. I don't see anything else
right now.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
