Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGVNEb>; Mon, 22 Jul 2002 09:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGVNEa>; Mon, 22 Jul 2002 09:04:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38153 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314548AbSGVNEa>; Mon, 22 Jul 2002 09:04:30 -0400
Message-ID: <3D3C024C.5040108@evision.ag>
Date: Mon, 22 Jul 2002 15:02:04 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: martin@dalecki.de, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
References: <Pine.GSO.4.21.0207220843320.6045-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 22 Jul 2002, Marcin Dalecki wrote:
> 
> 
>>>The kernel is full of GNUisms, and this one is actually usefull.
>>
>>Its is not half as full as you may think.
> 
> 
> Trailing comma in enums has _exactly_ the same status as .foo = bar in
> structure initializers.  Both appear in C99 and were compiler-specific
> extensions before that.

Yes the C99 people did give in on this point :-). But only until
recently. And really the only way to find out what the warinigs
are about is to have a look at cparse.y...

> If -pedantic is unhappy about one but not another - take it with gcc
> folks, it's a bug in gcc.
> 
> Speaking of GNUisms, inline assembler is one and it's by far the worst
> obstacle to portability. 

Sure, but this extension is actually a justifyed one.

 > Speaking of *REALLY* ugly stuff - may I point
> you to abuses of ##?  Yes, it's legal C.  No, using it is a Bad Idea(tm).
> And the actual uses of _that_ one in the tree can give you the second
> look at your breakfast - grep around and you'll see.

Da, kanieczna. Ja znaju: It's resulting in semi "self modifying" code.
Sometimes usefull but not in 80% where they are actually used is the
({ ... }) extension for example as well. In most of the cases where its
used we should simply rely on the fact that gcc got now much better at
doing function inlining instead. See the spinlock patch for example.
Best abuse example are the byte swapping macros...

But one quite justifyed example of usage is the
wait_event_interruptible(), where it's used to assert repeated condition
evaluation. However this puts the fact aside that 
wait_event_interruptible() isn't a polite abstraction in first place...

