Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRFJTsZ>; Sun, 10 Jun 2001 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbRFJTsP>; Sun, 10 Jun 2001 15:48:15 -0400
Received: from nwhn-sh20-port180.snet.net ([204.60.209.180]:16904 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S261684AbRFJTsF>;
	Sun, 10 Jun 2001 15:48:05 -0400
Message-Id: <200106101941.PAA00669@karaya.com>
X-Mailer: exmh version 2.0zeta 7/24/97
To: Scott Long <smlong@teleport.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Threads and the LDT (Intel-specific)? 
In-Reply-To: Your message of "Sun, 10 Jun 2001 11:53:29 PDT."
             <01061011532900.01126@abacus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 15:40:59 -0300
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smlong@teleport.com said:
> I'm trying to do something a bit unorthodox: I want to share the
> address space between threads, but I want a certain region of the
> address space to be writeable only for a particular thread -- for all
> other threads this region is read-only. 

UML does this in a somewhat portable (but strange) way.  Threads don't share 
address spaces, as far as the OS is concerned, but the areas where the 
executable is mapped in are copied to a file, those areas are mapped out, and 
the files mapped shared in their place.  This happens once, in the first 
thread, and all subsequent threads get the executable mapped shared 
automatically, even though they are separate processes and separate address 
spaces from the point of view of the kernel.

So, once this is set up, a thread just makes an area read-write (or readonly) 
and that mapping is private.

				Jeff


