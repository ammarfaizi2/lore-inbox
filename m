Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbRHDGVI>; Sat, 4 Aug 2001 02:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHDGU6>; Sat, 4 Aug 2001 02:20:58 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:63463 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S268399AbRHDGUp>; Sat, 4 Aug 2001 02:20:45 -0400
Message-ID: <3B6B95E5.B49CC888@kegel.com>
Date: Fri, 03 Aug 2001 23:27:49 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
CC: Christopher Smith <x@xman.org>, Zach Brown <zab@zabbo.net>
Subject: Re: Could /dev/epoll deliver aio completion notifications? (was: Re: 
 sigopen() vs. /dev/sigtimedwait)
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com> <20010803183853.H1080@ppetru.net> <3B6B59AF.9826F928@kegel.com> <3B6B662F.3E83C22F@kegel.com> <20010804011838.W3034@erasmus.off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> 
> > On the other hand, if /dev/epoll were flexible enough that it could
> > deliver AIO completion notifications,
> 
> As far as I know, Ben LaHaise (bcrl@redhat.com) already has a fine
> method conceived for receiving batches of async completion, including an
> "async poll".  It should give the sort of behaviour you want and is also
> useful for other AIO things, obviously :)
> 
> You should really chat with him.

I suppose it shouldn't suprise me that real kernel hackers like Ben
just work on cool things quietly, and bufoons like me get excited
at the merest thought, and have to broadcast them on l-k.  Sigh.

A little digging finds a few references to Ben's aio work:

http://uwsg.iu.edu/hypermail/linux/kernel/0102.0/0384.html
http://www.kvack.org/~blah/aio/v2.4.5-ac9-bcrl4-aio.diff

His patch creates /dev/aio, among other things, and includes
the wonderful excerpt

diff -urN /md0/kernels/2.4/v2.4.5-ac9/include/asm-i386/errno.h aio-2.4.5-ac9/include/asm-i386/errno.h
--- /md0/kernels/2.4/v2.4.5-ac9/include/asm-i386/errno.h        Mon Feb 26 10:20:14 2001
+++ aio-2.4.5-ac9/include/asm-i386/errno.h      Wed Jun 13 17:08:50 2001
@@ -128,5 +128,6 @@
 
 #define        ENOMEDIUM       123     /* No medium found */
 #define        EMEDIUMTYPE     124     /* Wrong medium type */
+#define        ENOCLUE         125     /* userland programmer induced race condition */

:-)

Given how occupied Ben is with urgent matters like tracking down the
VM suckage, I don't expect he has much time for chatting about this stuff.

OK, guess I'll content myself with working through Ben's (and Davide's)
code and understanding it.  Sorry for all the line noise, folks.
- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
