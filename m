Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266906AbRGHPn5>; Sun, 8 Jul 2001 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbRGHPnr>; Sun, 8 Jul 2001 11:43:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:48398 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266906AbRGHPnd>;
	Sun, 8 Jul 2001 11:43:33 -0400
Date: Sun, 8 Jul 2001 12:43:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107081640570.308-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33L.0107081241280.22014-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Mike Galbraith wrote:

> is very oom with no disk activity.  It _looks_ (xmm and vmstat) like
> it just ran out of cleanable dirty pages.  With or without swap,

... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
bug. I've seen this for quite a while now on our quad xeon test
machine, with some kernel versions it can be reproduced in minutes,
with others it won't trigger at all.

And after a recompile it's usually gone ...

I hope there is somebody out there who can RELIABLY trigger
this bug, so we have a chance of tracking it down.

> tar
> Trace; c012f2da <__wait_on_buffer+6a/8c>
> Trace; c01303c9 <bread+45/64>
> Trace; c01500ea <ext2_read_inode+fe/3c8>
> Trace; c01411f5 <get_new_inode+d1/15c>
> Trace; c0141416 <iget4+c2/d4>
> Trace; c0150b03 <ext2_lookup+43/68>
> Trace; c0138401 <path_walk+529/748>
> Trace; c0137aed <getname+5d/9c>
> Trace; c01389d8 <__user_walk+3c/58>
> Trace; c0135cc6 <sys_lstat64+16/70>
> Trace; c0106ae3 <system_call+33/38>

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

