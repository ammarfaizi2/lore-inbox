Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRADQ7t>; Thu, 4 Jan 2001 11:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADQ7k>; Thu, 4 Jan 2001 11:59:40 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20471 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129325AbRADQ7J>; Thu, 4 Jan 2001 11:59:09 -0500
Date: Thu, 4 Jan 2001 14:58:19 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, Chris Mason <mason@suse.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <Pine.LNX.4.21.0101041236400.1355-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101041437550.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Marcelo Tosatti wrote:
> On 4 Jan 2001, Christoph Rohland wrote:
> > Chris Mason <mason@suse.com> writes:

> > > That would loop forever if the writepage func kept returning 1 though
	[snip]

> > return 1 if the swap space is exhausted. So everybody using shared
> > anonymous, SYSV shared or POSIX shared memory can hit this.
> 
> In case of swap exhausted I think we should just fail.

No. In case of swap exhausted the page needs to be moved to
the active list so we don't clog up the inactive_dirty list
and have the possibility of a deadlock (already done).

In case of "write ordering not yet satisfied", the writepage
function should leave the page on the inactive_dirty list and
maybe write out something else (reiserfs, ext3, xfs...).

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
