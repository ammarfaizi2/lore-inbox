Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318042AbSG2GSV>; Mon, 29 Jul 2002 02:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSG2GSU>; Mon, 29 Jul 2002 02:18:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17636 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318042AbSG2GST>;
	Mon, 29 Jul 2002 02:18:19 -0400
Date: Sun, 28 Jul 2002 23:10:17 -0700 (PDT)
Message-Id: <20020728.231017.40779367.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207282256460.872-100000@home.transmeta.com>
References: <20020728.224302.36837419.davem@redhat.com>
	<Pine.LNX.4.44.0207282256460.872-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 28 Jul 2002 23:16:24 -0700 (PDT)

 [ This is Linus speaking in all the quoted material below... ]

   >    But the thing is, nobody should normally have a reference to such a
   >    page anyway. The only way they happen is by something mapping a
   >    page from user space, and saving it away, while the user space goes
   >    away and drops its references to the page.
 ...
   But hopefully nobody should have the problematic last reference to a LRU
   page _except_ the user space itself. That should be safe for page cache
   pages thanks to the truncate change.

[ Now DaveM is talking :-) ]

So let's say that we have a page going out a socket.  The socket's FD
has multiple references so when the user exit()'s the anonymous page
is still "in-flight" but the socket isn't closed and thus we won't
wait for the write to complete.

So when the user's reference is dropped, does that operation kill it
from the LRU or will the socket's remaining reference to that page
defer the LRU removal?
