Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTAJJDr>; Fri, 10 Jan 2003 04:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTAJJDP>; Fri, 10 Jan 2003 04:03:15 -0500
Received: from dp.samba.org ([66.70.73.150]:46494 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264711AbTAJJBa>;
	Fri, 10 Jan 2003 04:01:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Eric Weigle <ehw@lanl.gov>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] checksum.h header fixes for 2.4 
In-reply-to: Your message of "Thu, 09 Jan 2003 13:06:46 PDT."
             <20030109200646.GG3329@lanl.gov> 
Date: Fri, 10 Jan 2003 18:47:50 +1100
Message-Id: <20030110091014.9B5252C40A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030109200646.GG3329@lanl.gov> you write:
> All-
> 
> I'm making a loadable module that will send IP packets; and need to do IP
> checksums. Unfortunately a simple #include of checksum.h fails because that
> file does not itself include the headers required to compile correctly.
> Several of the arch-specific files are this way.
> 
> * Some files use VERIFY_READ, VERIFY_WRITE, access_ok from uaccess.h but do
> not include uaccess.h
> 
> * Some files have an IPv6 checksum with struct in6_addr, but do not include
> linux/in6.h. x86_64 just defines the structure instead of including the
> file. Either way works, but it's inconsistent. I've moved them all to the
> #include, but they could all go to the struct in6_addr way too.

Two general rules I like:
1) Never include asm/xxx when there is a linux/xxx.
2) asm/ headers shouldn't include linux/ headers.  It's
   too easy to cause insoluble loops.

I this case, I suspect #include <net/checksum.h> is what you really
want.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
