Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRADQeF>; Thu, 4 Jan 2001 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbRADQdz>; Thu, 4 Jan 2001 11:33:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64773 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129387AbRADQdj>; Thu, 4 Jan 2001 11:33:39 -0500
Date: Thu, 4 Jan 2001 12:41:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <m3ae982yq5.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0101041236400.1355-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Jan 2001, Christoph Rohland wrote:

> Chris Mason <mason@suse.com> writes:
> > Just noticed the filemap_fdatasync code doesn't check the return value from
> > writepage.  Linus, would you take a patch that redirtied the page, puts it
> > back onto the dirty list (at the tail), and unlocks the page when writepage
> > returns 1?
> > 
> > That would loop forever if the writepage func kept returning 1 though...I
> > think that's what we want, unless someone like ramfs made a writepage func
> > that always returned 1.
> 
> shmem has such a writepage for locked shm segments. 

The correct thing seems to be wait for this lock in case of
fdatasync/sync/etc, then.

What about a sync parameter to ->writepage() ? 

> return 1 if the swap space is exhausted. So everybody using shared
> anonymous, SYSV shared or POSIX shared memory can hit this.

In case of swap exhausted I think we should just fail.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
