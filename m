Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRA3LYX>; Tue, 30 Jan 2001 06:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA3LYO>; Tue, 30 Jan 2001 06:24:14 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:38648 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129733AbRA3LX4>; Tue, 30 Jan 2001 06:23:56 -0500
Date: Tue, 30 Jan 2001 09:23:27 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
cc: "David S. Miller" <davem@redhat.com>, David Howells <dhowells@redhat.com>,
        Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
In-Reply-To: <20010131001737.C6620@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0101300921480.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Chris Wedgwood wrote:
> On Tue, Jan 30, 2001 at 12:39:24AM -0800, David S. Miller wrote:
> 
>     Please see older threads about this, it has been discussed to
>     death already (hint: sizeof(atomic_t), sizeof(unsigned long)).
> 
> can we not define a macro so architectures that can do do atomically
> inc/dec with unsigned long will? otherwise it uses the spinlock?

Why bother ?

In most places where we update mm->rss, we are *already*
holding the spinlock anyway, this correction is just for
a few places.

The big patch Rasmus made seems to contain spin_lock(&foo)
in places where we already have the lock, leading to
instant SMP deadlock. I suspect Rasmus' patch should be
about half the size it is currently...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
