Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKOW6z>; Wed, 15 Nov 2000 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbQKOW6p>; Wed, 15 Nov 2000 17:58:45 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:28686 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129345AbQKOW6f>; Wed, 15 Nov 2000 17:58:35 -0500
Message-ID: <3A130EE7.8D94F292@mvista.com>
Date: Wed, 15 Nov 2000 14:32:07 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: In line ASM magic? What is this?
In-Reply-To: <20001115213912Z129178-521+471@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> 
> ** Reply to message from George Anzinger <george@mvista.com> on Wed, 15 Nov
> 2000 12:55:46 -0800
> 
> > I am trying to understand what is going on in the following code.  The
> > reference for %2, i.e. "m"(*__xg(ptr)) seems like magic (from
> > .../include/i386/system.h).  At the same time, the code "m" (*mem) from
> > the second __asm__ below (my code) seems to generate the required asm
> > code.  Before I go with the simple version, could someone tell me why?
> > Inquiring minds want to know.
> >
> > struct __xchg_dummy { unsigned long a[100]; };
> > #define __xg(x) ((struct __xchg_dummy *)(x))
> >
> >               __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %b1,%2"
> >                                    : "=a"(prev)
> >                                    : "q"(new), "m"(*__xg(ptr)), "0"(old)
> >                                    : "memory");
> >
> >
> >       __asm__ __volatile__(
> >                              LOCK "cmpxchgl %1,%2\n\t"
> >                              :"=a" (result)
> >                              :"r" (new),
> >                               "m" (*mem),
> >                               "a0" (test)
> >                              : "memory");
> 
> I've been a lot of gcc inline asm recently, and I still consider it a black
> art.  There are times when I just throw in what I think makes sense, and then
> look at the code the compiler generated.  If it's wrong, I try something else.
> 
> Both versions look correct to me.  The "m" simply tells the compiler that
> __xg(ptr) is a memory location, and the contents of that memory location should
> NOT be copied to a register.  The confusion occurs because its unintuitive that
> the "*" is required.  Otherwise, it would have been "r", which basically tells
> the compiler to copy the contents to a register first.
> 
I know the feeling.  I am currently strugling with "inconsistant
constraints".  Still, I must assume that form 1 was used instead of 2
for some reason....

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
