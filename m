Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSEIHnk>; Thu, 9 May 2002 03:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSEIHnj>; Thu, 9 May 2002 03:43:39 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:54025 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315630AbSEIHni>; Thu, 9 May 2002 03:43:38 -0400
Date: Thu, 9 May 2002 17:45:50 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: pazke@orbita1.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] __init and friends support for loadable modules
Message-Id: <20020509174550.79d08e5b.rusty@rustcorp.com.au>
In-Reply-To: <9276.1020866527@ocs3.intra.ocs.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2002 00:02:07 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> On Wed, 8 May 2002 14:29:33 +0400, 
> Andrey Panin <pazke@orbita1.ru> wrote:
> >attached patch adds support for	freeing .init sections of loadable modules
> >after init_module() function exits. Modutils have support for this since 19=
> >98,
> >but kernel support didn't exist.
> 
> The main reason I have not done this myself is the interaction between
> freeing code areas and the exception and unwind tables.  When you free
> code, you should remove or nullify the related unwind and exception
> entries.  Another module could be loaded into the area that used to
> contain init code and it would then be mapped by the first module's
> tables, oops.

Excellent catch, Keith.  I missed this in my current implementation, and
will have to patch the exception tables in the init release callback.  I
also get around this because I allow archs to refuse to have separate
init and core sections if they want.

BTW, I just got ppc64 in-kernel relocations working.  I am starting on
ia64, in the theory that if you can do ia64, you can do anything.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
