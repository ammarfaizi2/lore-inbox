Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129467AbQJ3WHd>; Mon, 30 Oct 2000 17:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129513AbQJ3WHX>; Mon, 30 Oct 2000 17:07:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:3833 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129467AbQJ3WHI>; Mon, 30 Oct 2000 17:07:08 -0500
Date: Mon, 30 Oct 2000 20:06:55 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301505590.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0010302005100.16609-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Alexander Viro wrote:

> The last one is in deactivate_page_nolock() - there we check the
> ->mapping without pagecache_lock and without page lock. Hell
> knows whether it's a bug or not. Rik?

Shouldn't be a problem, since we'll have the lock at a time
we actually /do/ something with those pointers.

In deactivate_page_nolock(), all we can modify is the list
in which the page resides, the flags indicating on which
list the page is and the referenced bit + page age. No other
stuff is touched.

Furthermore, the locking order (first pagecache lock, then
the page_list_lock) would make it difficult to do this right...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
