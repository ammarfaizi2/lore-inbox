Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSHAVin>; Thu, 1 Aug 2002 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSHAVin>; Thu, 1 Aug 2002 17:38:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317329AbSHAVil>; Thu, 1 Aug 2002 17:38:41 -0400
Date: Thu, 1 Aug 2002 14:42:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208012313200.8911-100000@serv>
Message-ID: <Pine.LNX.4.33.0208011430450.1647-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, Roman Zippel wrote:

> > Go read the standards. Some IO is not interruptible.
> 
> Which standard? Which "some IO"?

Any regular file IO is supposed to give you the full result. 

If you write() to a file, and get a partial return value back due to a
signal, there are programs that will assume that the disk is full (there
are also programs that will just lose your data).

This is not "sloppy programming". See the read() system call manual, which 
says

     Upon successful completion, read(), readv(), and pread() return the num-
     ber of bytes actually read and placed in the buffer.  The system guaran-
     tees to read the number of bytes requested if the descriptor references a
     normal file that has that many bytes left before the end-of-file, but in
     no other case.

Note the "The system guarantees to read the number of bytes requested .." 
part.

Stop arguing about this. It's a FACT.

		Linus

