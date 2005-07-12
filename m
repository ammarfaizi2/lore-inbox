Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGLHN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGLHN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGLHN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:13:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58778 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261221AbVGLHN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:13:58 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Date: Tue, 12 Jul 2005 10:12:39 +0300
User-Agent: KMail/1.5.4
References: <20050711145616.GA22936@mellanox.co.il>
In-Reply-To: <20050711145616.GA22936@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121012.39215.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3c. * in types
> 	Leave space between name and * in types.
> 	Multiple * dont need additional space between them.
> 
> 	struct foo **bar;

unless you declare a fuction:

int*
function_style_for_easy_grep(...)
{
	...
}

I like this style because I can grep for ^function_style_for_easy_grep
and quickly find function def.

int
*function_style_for_easy_grep(...) ..

would make it harder.

> 3e. sizeof
> 	space after the operator
> 	sizeof a

I use sizeof(a) always (both for sizeof(type) and sizeof(expr)).

> 3i. if/else/do/while/for/switch
> 	space between if/else/do/while and following/preceeding
> 	statements/expressions, if any:
> 
> 	if (a) {
> 	} else {
> 	}
> 
> 	do {
> 	} while (b);

What's wrong with if(expr) ? Rationale?

> 4c. Breaking long lines
> 		Descendants are always substantially shorter than the parent
> 		and are placed substantially to the right.
> 			Documentation/CodingStyle
> 
> 	Descendant must be indented at least to the level of the innermost
> 	compound expression in the parent. All descendants at the same level
> 	are indented the same.
> 	if (foobar(.................................) + barbar * foobar(bar +
> 				     					foo *
> 									oof)) {
> 	}

Avoid this. If needed, use a temporary. Save a few brain cells of poor reader.
 
> 6. One-line statement does not need a {} block, so dont put it into one
> 	if (foo)
> 		bar;

Disagree. Common case of hard-to-notice bug:

	if(foo)
		bar()
...after some time code evolves into:
	if(foo)
		/*
		 * Wee need to barify it, or else pagecache gets foobar'ed
		 */
		bar();
...after some more time:
	if(foo)
		/*
		 * Wee need to barify it, or else pagecache gets foobar'ed.
		 * Also we need to bazify it.
		 */
		bar();
		baz();

Thus we may be better to slighty encourage use of {}s even if they are
not needed:

	if(foo) {
		bar();
	}
 
> 9a. Integer types
> 	Use unsigned long if you have to fit a pointer into integer.

This is a porting nightmare waiting to happen.
Why dont we have ptr_t instead? 

> 	long long is at least 64 bit wide on all platforms.

hugeint or hugeint_t

And also irqflags_t for spinlock_irqsave(&lock, flags),
jiffies_t for jiffies.
 
> 9b. typedef
> 	Using typedefs to hide the data type is generally discouraged.
> 	typedefs to function types are ok, since these can get very long.
> 
> typedef struct foo *(foo_bar_handler)(struct foo *first, struct bar *second,
> 				      struct foobar* thirsd);

? did you mean struct foo (*foo_bar_handler)(... or  struct foo* foo_bar_handler(...
--
vda

