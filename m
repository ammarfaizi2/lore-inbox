Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261167AbRE0I0I>; Sun, 27 May 2001 04:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbRE0IZ5>; Sun, 27 May 2001 04:25:57 -0400
Received: from www.wen-online.de ([212.223.88.39]:24841 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261167AbRE0IZt>;
	Sun, 27 May 2001 04:25:49 -0400
Date: Sun, 27 May 2001 10:25:13 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: Alan Cox <laughing@shared-source.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac17
In-Reply-To: <001101c0e67c$844017e0$50a6b3d0@Toshiba>
Message-ID: <Pine.LNX.4.33.0105270950280.803-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001, Jaswinder Singh wrote:

> > Does it hang if you are doing other things than creating/destroying
> > tiny files (with unique names) as rapidly as possible?.. ie did you
> > start doing that to troubleshoot because it was hanging over a long
> > period of time?
> >
>
> If i create and delete files with same name , inode_cache & dentry_cache
> increases only one time , there is no problem .

Bingo.

> If i create and delete files with different name , inode_cache &
> dentry_cache increases continously and will eat my whole RAM and crash
> system.

This confirms it.

> And if i create and delete my file after long lapse , inode_cache &
> dentry_cache are restore after some time , their is no problem .
> But if i create and delete files very frequently , inode_cache &
> dentry_cache get no time for restore and eat my whole RAM and crash system.

Yes.. seems the caches need some size limits.  ramfs will lock you in
a heart beat if you hit oom. (i made a typo during iozone run.. oops:)

> If i donot create and delete files files frequently with different name ,
> their is no problem at all.
>
> > You snipped my suggestion.. did you try it?  If not, please do.  In
> > fact, go a bit further.  Make unconditional calls to kmem_cache_reap()
> > and shrink_icache_memory() as well.. prior to calling page_launder().
> > It's a long shot, but it might help.  If it does help, that will
> > tell developers what they need to know.  It costs you five minutes.
> >
> > Another option is to build 2.4.5-pre6 and add the patch Rik posted.
> > If my thinker is working right, that _will_ help (if not cure).
> >
> > Another option which virtually guarantees successful identification
> > of the problem (but costs more than five minutes) is for you to grab
> > a copy of IKD from your favorite kernel mirror and give memleak a try
> > locally.  It can be found in /pub/linux/kernel/people/andrea/ikd. If
> > you choose this option and have any trouble, drop me a note offline.
> >
>
> Thank you very much for your suggestions , i was getting this problem in my
> ARM target machine and right now i am working on SH target machines , and i
> am quite busy with my SH target machines now , i have to do lot of setups to
> change my target machines , i am sorry right now i am not in position to
> test your suggestions , but as soon as my SH target machine work is over , i
> will test all your suggestions and options.

I think you can forget these suggestions.  You've verified that it's
cache growth, so this football should be punted over to either Rik or
Al.. or better yet, both.

	Poont! ;-)

	-Mike

