Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbSLFWY5>; Fri, 6 Dec 2002 17:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbSLFWY5>; Fri, 6 Dec 2002 17:24:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62952 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267640AbSLFWY4>;
	Fri, 6 Dec 2002 17:24:56 -0500
Date: Fri, 06 Dec 2002 14:29:27 -0800 (PST)
Message-Id: <20021206.142927.88817589.davem@redhat.com>
To: James.Bottomley@steeleye.com
Cc: adam@yggdrasil.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212062226.gB6MQsr04565@localhost.localdomain>
References: <adam@yggdrasil.com>
	<200212062226.gB6MQsr04565@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@steeleye.com>
   Date: Fri, 06 Dec 2002 16:26:54 -0600

   adam@yggdrasil.com said:
   > 	This makes me lean infinitesmally more toward a parameter to
   > dma_alloc rather than a separate dma_alloc_not_necessarily_consistent
   > function, because if there ever are other dma_alloc variations that we
   > want to support, it is more likely that there may be overlap between
   > the users of those features and then the number of different function
   > calls would have to grow exponentially (or we might then talk about
   > changing the API again, which is not the end of the world, but is
   > certainly more difficult than not having to do so). 
   
   I think I like this.
   
I don't.

If the concept isn't all that important, why bother?

See, if you have to allocate a whole new routine, you'll think
about whether it makes sense or not.

It's like adding a new system call, and the same arguments apply.

I don't want a 'flags' thing, because that tends to be the action
which opens the flood gates for putting random feature-of-the-day new
bits.

If you have to actually get a real API change made, it will get review
and won't "sneak on in".  I also don't want architectures adding arch
specific flag bits that some drivers end up using, for example.
The suggested scheme allows that, and I can guarentee you that people
will do things like that.

You must take the time to get the semantics right and make sure they
really do handle the cases that are problematic.  Random flag bits
passed to a "do everything" dma_alloc function don't encourage that at
all.
