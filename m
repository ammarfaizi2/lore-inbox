Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRLGGlY>; Fri, 7 Dec 2001 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285428AbRLGGlO>; Fri, 7 Dec 2001 01:41:14 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:3824 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S282784AbRLGGkz>; Fri, 7 Dec 2001 01:40:55 -0500
Message-ID: <3C1064BB.329B966F@kegel.com>
Date: Thu, 06 Dec 2001 22:42:03 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> >> As far as I can see bonnie++ doesn't use putc_unlocked, but putc.
> >
> >Plain old Bonnie suffered from the same thing.  I long ago made it
> >use putc_unlocked() here because throughput was horrible otherwise.
> 
> Oh, yeah, blame it on bonnie.
> 
>         "Our C library 'putc' is horribly sucky"
> 
>         "Well, then, use something else then".
> 
> Isn't somebody ashamed of glibc and willing to try to fix it? It might
> be as simple as just testing a static flag "have I used pthread_create"
> or even a function pointer that gets switched around at pthread_create..

That sounds racy.  Better to make the change at compile time, maybe?
Say, 

#ifdef __USE_REENTRANT 
#define putc(_ch, _fp) _IO_putc (_ch, _fp)
#else
#define putc(_ch, _fp) _IO_putc_unlocked (_ch, _fp)
#endif

That's pedantically safe, I think.  

- Dan
