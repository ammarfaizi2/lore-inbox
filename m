Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFJUBz>; Mon, 10 Jun 2002 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSFJUBy>; Mon, 10 Jun 2002 16:01:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315943AbSFJUBx>;
	Mon, 10 Jun 2002 16:01:53 -0400
Message-ID: <3D050559.749D93AF@zip.com.au>
Date: Mon, 10 Jun 2002 13:00:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <3D04FE64.B92706E8@zip.com.au> <Pine.LNX.4.44.0206101344170.6159-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> 
> Hi,
> 
> On Mon, 10 Jun 2002, Andrew Morton wrote:
> > __func__ does *not* work on egcs-1.1.2 and so cannot be used in Linux.
> >
> > `struct blah = { .open = driver_open };' *does* work in egcs-1.1.2
> > and is OK to use.
> 
> Gee. I guess we need a special host gcc to support our needs - on
> sparc(|64). We might have a patch that easily renames it in the sources of
> egcs...

?

> Anyway, what is the problem about new gcc on old sparc? It works at least
> on my sparc64, I can't complain.

I don't know - we need to find a davem to answer that question.

egcs-1.1.2 has a problem with the percpu infrastructure - it
fails to put the right things in the right sections.  The
workaround for that is to ensure that the percpu data structures
are always initialised at the definition site:

	/* Some compilers disobey section attribute on statics when not
	   initialized -- RR */
	static struct tasklet_head tasklet_vec __per_cpu_data = { NULL };
	static struct tasklet_head tasklet_hi_vec __per_cpu_data = { NULL };

Note the (otherwise unneeded) `= { NULL }'.  The result of getting
this wrong is a nasty and subtly-dead kernel.

It's not a very happy state of affairs.   I'll be using
2.91.66 on x86 from now on, so any problems (in the stuff
which I build and test) will be picked up.

-
