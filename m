Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSLZEV1>; Wed, 25 Dec 2002 23:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSLZEV1>; Wed, 25 Dec 2002 23:21:27 -0500
Received: from dp.samba.org ([66.70.73.150]:54469 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262392AbSLZEVX>;
	Wed, 25 Dec 2002 23:21:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stem compression for kallsyms 
In-reply-to: Your message of "Tue, 24 Dec 2002 02:12:27 BST."
             <20021224011227.GA3171@averell> 
Date: Thu, 26 Dec 2002 14:24:21 +1100
Message-Id: <20021226042938.5A4932C06D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021224011227.GA3171@averell> you write:
> 
> This patch implements simple stem compression for the kallsyms symbol 
> table. Each symbol has as first byte a count on how many characters
> are identical to the previous symbol. This compresses the often
> common repetive prefixes (like subsys_) fairly effectively.
> 
> On a fairly full featured monolithic i386 kernel this saves about 60k in 
> the kallsyms symbol table.
> 
> The changes are very simple, so the 60k are not shabby.
> 
> One visible change is that the caller of kallsyms_lookup has to pass in 
> a buffer now, because it has to be modified. I added an arbitary
> 127 character limit to it.
> 
> Still >210k left in the symbol table unfortunately. Another idea would be to 
> delta encode the addresses in 16bits (functions are all likely to be smaller 
> than 64K).  This would especially help on 64bit hosts. Not done yet, however.
> 
> No, before someone asks, I don't want to use zlib for that. Far too fragile 
> during an oops and overkill too and it would require to link it into all
> kernels.

Hi Andi,

	For the IDE oopser, I used the 16-bit size trick and a very
simple static huffman encoding, which IIRC brought the size down to
~100k (I can't find numbers at the moment).  I relied on a linked-list
of tables (for things which were more than 16 bits apart), which is
not such a great idea for the kallsyms table.  Maybe eliminate
aliases, and then use a 0 size to prefix a full new pointer?

Anyway, here's the post if you're interested:
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.2/0062.html

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
