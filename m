Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRDEPnB>; Thu, 5 Apr 2001 11:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132934AbRDEPml>; Thu, 5 Apr 2001 11:42:41 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:6922 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132932AbRDEPm2>;
	Thu, 5 Apr 2001 11:42:28 -0400
Date: Thu, 5 Apr 2001 11:41:38 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Steve Grubb <ddata@gate.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <001701c0bde4$59825240$871a24cf@master>
Message-ID: <Pine.LNX.4.30.0104051136430.13496-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Steve Grubb wrote:

> It would seem to me that after hearing how the macros are used in practice,
> wouldn't turning them into inline functions be an improvement? This is
> something gcc supports, it accomplishes the same thing, and has the added
> advantage of type checking.
> http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_4.html#SEC92
>
> Or perhaps type checking macro arguments would be another fertile area for
> the Stanford Checker...

There are benefits to macros too.  One that I like for debuggin is that
the C parser will unravel a macro within the context of the execution:

#ifdef DEBUG
#define KMALLOC(x,y) \
  printk(__FILE__ ":%d: kmalloc(%d,%d")\n", __LINE__,x,y); \
  kmalloc(x,y);
#else
#define KMALLOC(x,y) \
  kmalloc(x,y);
#endif

I think the benefit of a macro here is quite visible... you cannot do this
with an inline.

You may also look at some better reasons:

http://www.uwsg.iu.edu/hypermail/linux/kernel/9810.3/0323.html

[btw I found this by looking for 'macros vs inline' on google/linux]

Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/


