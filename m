Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272103AbRHWJ3V>; Thu, 23 Aug 2001 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRHWJ3J>; Thu, 23 Aug 2001 05:29:09 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:50836 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272241AbRHWJ3E>; Thu, 23 Aug 2001 05:29:04 -0400
Importance: Normal
Subject: Re: Allocation of sk_buffs in the kernel
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF551C0474.A161B459-ONC1256AB1.00337905@de.ibm.com>
From: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Date: Thu, 23 Aug 2001 11:29:11 +0200
X-MIMETrack: Serialize by Router on d12ml040/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 23/08/2001 11:29:11
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Maybe Jens should use something like WAITQUEUE_DEBUG if he want to
know
> > > where alloc_skb and friends were called, see include/linux/wait.h 8)
> > Do you mean I should use something LIKE the WAITQUEUE_DEBUG (eg.
> > implementing something like that in skbuff.c) or I should use
> > WAITQUEUE_DEBUG?
> no, just use the same idea that is used to debug wait_queues
OK, then I interpreted the code in wait.h right ;)

> > Are there any examples how to use the WAITQUEUE_DEBUG?

> oops, I mean the __waker thing, for debugging you could get the address
of
> the caller with current_text_addr() and store it in an extra sk_buff
field
> so that later on you could know who create the skb.
But where should I fill this field in the sk_buff? I know that alloc_skb
creates an sk_buff, so this would be of no use for me. Or do you mean to
add something like that to the initialization of the sk_buff struct, like a
"long allocator = current_text_addr()" in skbuff.h? Is something like this
possible? I'm not sure about it....

> About the example of WAITQUEUE_DEBUG:
>
> after being awaken you could do this:

>                 dprintk("sleeper=%p, waker=%lx\n",
>                          current_text_addr(), wait.__waker);

> in a inline function does the trick, but this is just an example of a
> function that uses an extra debug field in a structure that is alocated
> somewhere and you want to know who allocated it later on.

> Yes, you'll have to decode the address from syslog, gotcha?
But the __waker member is filled by a macro from wait.h, if I had seen it
right. Where would you issue such a dprintk call?

Sorry about my missing knowledge about wait queues, but I don't get the
point where to fill the member. That I could print it later on, thats
clear, but how to fill it?

CU,
Jens

