Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSFJPQm>; Mon, 10 Jun 2002 11:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFJPQl>; Mon, 10 Jun 2002 11:16:41 -0400
Received: from pop.gmx.de ([213.165.64.20]:9011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315459AbSFJPQk>;
	Mon, 10 Jun 2002 11:16:40 -0400
Date: Mon, 10 Jun 2002 18:14:50 +0300
From: Dan Aloni <da-x@gmx.net>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] introduce list_move macros (revisited)
Message-ID: <20020610151450.GB9581@callisto.yi.org>
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0206090641330.24893-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 06:42:17AM -0600, Lightweight patch manager wrote:
>
[snip]
> + */
> +#define list_move(list,head) \
> +        do { __list_del(list->prev, list->next); \
> +             list_add(list,head); } \
> +        while(0)
> +
[snip]
>

I have a few comments about this, that were not already been said on this thread:

 * How about making it safer by assigning 'list' to something first,
   instead of letting the preprocessor evaluate it 3 times, which 
   can cause problems like, when 'list' evaluates to a function call?
 * At least surround 'list' with (), as in (list)->prev, so operator
   priorities would not give you trouble.
 * Why are you adding the definitions in the end of list.h? It would
   have been more originized if it was just after list_del_init, i.e,
   along with the other list mutators.
 * The comments for the macros are not clear at all. They don't tell
   what's the purpose of these macros, which is to delete an entry from
   a list and add it to another - which is what an average user will seek
   when reading list.h.

And about macros, I quote from Documentation/SubmittingPatches:

	3) 'static inline' is better than a macro

	Static inline functions are greatly preferred over macros.
	They provide type safety, have no length limitations, no formatting
	limitations, and under gcc they are as cheap as macros.

	Macros should only be used for cases where a static inline is clearly
	suboptimal [there a few, isolated cases of this in fast paths],
	or where it is impossible to use a static inline function [such as
	string-izing].

	'static inline' is preferred over 'static __inline__', 'extern inline',
	and 'extern __inline__'.

--
Dan Aloni
da-x@gmx.net
