Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292082AbSCDH3k>; Mon, 4 Mar 2002 02:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSCDH3a>; Mon, 4 Mar 2002 02:29:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27147 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292082AbSCDH30>;
	Mon, 4 Mar 2002 02:29:26 -0500
Message-ID: <3C8321DE.EE6A47B0@zip.com.au>
Date: Sun, 03 Mar 2002 23:27:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <3C82E5A1.714081EA@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> ...
> >
> > You're not even trying to apply this to swap cache right now are you?
> 
> This is a disagreement akpm and I have, actually :)
> 

Misunderstanding, rather.

Swapfiles aren't interesting, IMO.  And I agree that mkswap or swapon
should just barf if the file has any holes in it.

But what I refer to here is, simply, delayed allocate for swapspace.
So swap_out() sticks the target page into the swapcache, marks it
dirty and takes a space reservation for the page out of the swapcache's
address_space.  But no disk space is allocated at swap_out() time.
Instead, the real disk mapping is created when the VM calls
a_ops->vm_writeback() against the swapcache page's address_space.  

All of which rather implies a ripup-and-rewrite of half the swap
code.  It would certainly require a new allocator. So I just mentioned
the possibility.  Glad you're interested :)

-
