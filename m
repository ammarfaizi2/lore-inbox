Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSFLTrm>; Wed, 12 Jun 2002 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317320AbSFLTrl>; Wed, 12 Jun 2002 15:47:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2221 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317316AbSFLTrk>;
	Wed, 12 Jun 2002 15:47:40 -0400
Date: Wed, 12 Jun 2002 21:45:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <dent@cosy.sbg.ac.at>,
        <adilger@clusterfs.com>, <da-x@gmx.net>, <patch@luckynet.dynu.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: <E17Hhjo-0007rM-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206122125210.17567-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jun 2002, Rusty Russell wrote:

> The number of structures and functions which need only "struct xxx *"
> is very high: removing typedefs is something about with ~zero pain
> (unlike dropping the sometimes-dubious loveaffair with inlines).
> 
> Rusty.
> PS.  I blame Ingo: list_t indeed!

the reason why i added list_t to the scheduler code was mainly for
aesthetic reasons. I'm still using 80x25 text consoles mainly, which are
more sensitive to code length. Also, 'struct list_head' did not reflect
the kind of lightweight list type we have, 'list_t' does that better. Eg.:

unsigned int void some_function(list_t *head, list_t *next, list_t *prev)
{
}

instead of:

unsigned int some_function(struct list_head *head, struct list_head *next,
			 struct list_head *prev)
{
}

but if typedefs create other problems then these arguments are secondary i
guess. I'm completely against redefining base types for no particular
reason, like counter_t.

But i think it would be useful to introduce some sort of '_t convention',
where _t always means a complex (or potentially complex - opaque) type. It
makes code so much more compact and readable, and it does not hide
anything - _t *always* means a complex type in the way i use it.

To see this in action check out 2.5's drivers/md/raid5.c for example,
replace all the _t types with their full-blown struct equivalents and
compare code readability. And this is not broken code in any way, it's
just code that uses lots of complex types.

	Ingo

