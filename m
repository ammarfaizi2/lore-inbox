Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRB0W7z>; Tue, 27 Feb 2001 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRB0W7g>; Tue, 27 Feb 2001 17:59:36 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:10651 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129875AbRB0W7a>;
	Tue, 27 Feb 2001 17:59:30 -0500
Date: Tue, 27 Feb 2001 17:59:03 -0500
Message-Id: <200102272259.RAA13893@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Jeremy Jackson <jerj@coplanar.net>
CC: Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Serial List <linux-serial@vger.kernel.org>
In-Reply-To: Jeremy Jackson's message of Mon, 26 Feb 2001 22:19:20 -0500,
	<3A9B1CB8.B989A10@coplanar.net>
Subject: Re: CLOCAL and TIOCMIWAIT
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 26 Feb 2001 22:19:20 -0500
   From: Jeremy Jackson <jerj@coplanar.net>

   I had written a simple program 10-20 lines C to count pulses at rate
   of 1 per second give or take.  It turned out that the driver disabled
   the UART's generation of interrupts completely for certain signals.
   I don't remember which exactly, but I think it was DCD; I was using
   CLOCAL so the hangups wouldn't close the descriptor.  The problems
   was that by disabling the interrupt at the source, the ioctl's to
   read the bits stopped working!  not what I wanted.

This was a bug which was fixed for 2.2 in the 8250/16550 serial driver;
CLOCAL should change the behaviour open/close/hangup processing, as per
POSIX, but it shouldn't change the behaviour of TIOCMIWAIT or TIOCMGET.

   > My question is: what's the correct interpretation of CLOCAL?? If the
   > serial driver's interpretation is the correct one, I'll be more than happy
   > to change the Cyclades' driver to comply with that, I just want to make
   > sure that this is the expected behavior before I patch the driver.

CLOCAL's behaviour is defined under POSIX, although the behaviour of
TIOCMIWAIT and TIOMGET aren't.  So one could make the argument that 
(to use Al Gore's words) there "no controlling legal authority" saying
that an implementation where TIOCMIWAIT depending on CLOCAL being clear
is illegal or violates some standard.  However, it seems downright silly.

So I would argue that it would be better to make things consistent by
making CLOCAL only affect those things which are specifically specified
by POSIX.1, and not make it affect the behaviour of TIOCMIWAIT and
TIOCMGET, et. al.

							- Ted
