Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTJNFHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 01:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTJNFHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 01:07:32 -0400
Received: from waste.org ([209.173.204.2]:50852 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262183AbTJNFHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 01:07:31 -0400
Date: Tue, 14 Oct 2003 00:07:13 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM code question
Message-ID: <20031014050712.GY5725@waste.org>
References: <20031014013227.GA20406@cse.unsw.EDU.AU> <20031014014427.GL16158@holomorphy.com> <3F8B56E4.1060902@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8B56E4.1060902@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 11:52:36AM +1000, Nick Piggin wrote:
> 
> 
> William Lee Irwin III wrote:
> 
> >On Tue, Oct 14, 2003 at 11:32:27AM +1000, Darren Williams wrote:
> >
> >>I have a small question wrt some VM code.
> >>source file is include/linux/kernel.h
> >>#define container_of(ptr, type, member) ({                      \
> >>       const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
> >>       (type *)( (char *)__mptr - offsetof(type,member) );})
> >>what is the use of the 0 (zero) in the typeof? I am thinking
> >>that we are casting 0 to (type *) then referencing 'member' of
> >>'type', however why do we require the 0 ?
> >>Just curious
> >>
> >
> >It's an address calculation method. We subtract the address of the
> >start of the structure from the address of the member inside the
> >structure.
> >
> 
> AFAIKS the 0 is not part of the address calculation method though. It
> is only used in the argument to the typeof operator. I think 0 is used
> simply because its as good a place as any, right?

It could be simplified to:

 ((type *)((char *)(ptr) - offsetof(type, member)))

The other bit is just there to throw errors if you cast in a pointer
of the wrong type. To do this, we've got to create a pointer of the
same type as &type.member so that assigning to it without casting will
throw a warning if ptr isn't of the right type. But we can't do
typeof(&type.member), as type is a type name and not an object. So
0 is simply the shortest, safest thing to cast to a (type *).

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
