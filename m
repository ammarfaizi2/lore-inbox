Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132747AbRDUQqx>; Sat, 21 Apr 2001 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRDUQqo>; Sat, 21 Apr 2001 12:46:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59404 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132752AbRDUQqk>;
	Sat, 21 Apr 2001 12:46:40 -0400
Date: Sat, 21 Apr 2001 13:42:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
In-Reply-To: <Pine.LNX.4.33.0104211741020.346-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104211336390.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Mike Galbraith wrote:

> 30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:29 count:164 [164? 1]
> 30:04: [pid-4] page:c10599a8 deact:0 cache:0 age:26 count:164

> 1.  what kind of page has 164 references?

mmap(/lib/libc.so, FLAGS);

> 2.  why deactivate pages (lots) with count > 2?  PINGpong.

They're not deactivated, they're removed from this proces' virtual
memory mapping.

What I _am_ worried about is the fact that we do this to pages with
a really high page age. These things are in active use and cannot
be swapped out any time soon, yet we do claim swap space for it ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

