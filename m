Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154447-16160>; Sat, 19 Sep 1998 20:16:08 -0400
Received: from yonge.cs.toronto.edu ([128.100.1.8]:62170 "HELO yonge.cs.toronto.edu" ident: "root") by vger.rutgers.edu with SMTP id <154575-16160>; Sat, 19 Sep 1998 19:54:24 -0400
Subject: Re: Today Linus redesigns the networking driver interface (was Re: tulip driver in ...)
From: David Holland <dholland@cs.toronto.edu>
To: tytso@MIT.EDU (Theodore Y. Ts'o)
Date: Sat, 19 Sep 1998 23:30:21 -0400
Cc: torvalds@transmeta.com, kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk, davem@dm.cobaltmicro.com, matti.aarnio@sonera.fi, linux-kernel@vger.rutgers.edu, becker@cesdis1.gsfc.nasa.gov
In-Reply-To: <199809192249.SAA08252@dcl.MIT.EDU> from "Theodore Y. Ts'o" at Sep 19, 98 06:49:56 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <98Sep19.233024edt.37911-17305@qew.cs.toronto.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

 > The one thing which the BSD implementations have that we *don't* have is
 > the ability mask just one kind of interrupts (say, serial or networking
 > interrupts) during some critical section of code.  The only thing we can
 > do is use cli(), which blocks all interrupts.
 > 
 > So one of the things which the BSD networking stack can do is to (in
 > some critical section of code), prevent network interupts from being
 > handled.  If a network interrupt comes in during the critical section of
 > code, it is queued, and would be executed only after the networking code
 > had unblocked network interrupts.  (However, if a disk interrupt
 > happened during the critical section, it would be handled.)

The trouble is that on the x86, disabling just some interrupts means
you have to talk to the interrupt controller, which is excessively
slow.

There was a paper by Chris Small a couple of years ago that suggested
that the best thing to do (on the x86, anyway) was to use cli/sti for
small critical sections and talk to the interrupt controller only if
you were going to have interrupts off for a good while.

I can dig up the exact reference if you like, or you should be able to
find it under http://www.eecs.harvard.edu/~chris.

-- 
   - David A. Holland             | (please continue to send non-list mail to
     dholland@cs.utoronto.ca      | dholland@hcs.harvard.edu. yes, I moved.)

     Any netkit mail should be sent to netbug@ftp.uk.linux.org, not me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
