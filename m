Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131912AbRCYB3H>; Sat, 24 Mar 2001 20:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131913AbRCYB24>; Sat, 24 Mar 2001 20:28:56 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:42504 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131912AbRCYB2o>; Sat, 24 Mar 2001 20:28:44 -0500
Date: Sat, 24 Mar 2001 22:05:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <20010325001338.C11686@redhat.com>
Message-ID: <Pine.LNX.4.21.0103242203290.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001, Stephen C. Tweedie wrote:

> Rik, do you think it is really necessary to take the page lock and
> release it inside lookup_swap_cache?  I may be overlooking something,
> but I can't see the benefit of it ---

I don't think we need to do this, except to protect us from
using a page which isn't up-to-date yet and locked because
of disk IO.

Reclaim_page() takes the pagecache_lock before trying to
free anything, so there's no reason to lock against that.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

