Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSC1Nuc>; Thu, 28 Mar 2002 08:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313158AbSC1NuX>; Thu, 28 Mar 2002 08:50:23 -0500
Received: from vaak.stack.nl ([131.155.140.140]:58641 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S313157AbSC1NuT>;
	Thu, 28 Mar 2002 08:50:19 -0500
Date: Thu, 28 Mar 2002 14:50:17 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA31BF6.7030609@didntduck.org>
Message-ID: <20020328144259.A6796-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Brian Gerst wrote:

> Andrew Morton wrote:
> > Lesson for the day: this is one of the reasons why this idiom:
> > 	some_type *p;
> > 	p = malloc(sizeof(*p));
> > 	...
> > 	memset(p, 0, sizeof(*p));
> > is preferable to
> > 	some_type *p;
> > 	p = malloc(sizeof(some_type));
> > 	...
> > 	memset(p, 0, sizeof(some_type));

> I'm not sure I follow you here.  Compiling this code (gcc 2.96):
....

It is not about what comes out of the compiler, it is about the fact that
in the second case, when some_type becomes another_type, you have to
replace some_type at 3 locations, easy to forget one. In the first case,
your compiler checks what the size of your variable is, the memset will
never fill beyond the end of your allocated memory.

It is about preventing patching again and again for someone forgot to use
:s/something/anotherthing/g. Besides, the code looks much better imho.

Jos

