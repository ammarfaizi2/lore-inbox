Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbTCGScF>; Fri, 7 Mar 2003 13:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbTCGScF>; Fri, 7 Mar 2003 13:32:05 -0500
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:19073
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id <S261700AbTCGScD>; Fri, 7 Mar 2003 13:32:03 -0500
From: "jds" <jds@soltis.cc>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems in kernel 2.4.20  stat() seems to return always size zero for any fifo (named pipe)
Date: Fri, 7 Mar 2003 12:58:11 -0600
Message-Id: <20030307184315.M54213@soltis.cc>
In-Reply-To: <Pine.LNX.3.95.1030306140516.11315A-100000@chaos>
References: <20030306180838.M2529@soltis.cc> <Pine.LNX.3.95.1030306140516.11315A-100000@chaos>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 170.169.46.200 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, do you have any idea of what's wrong?
I tryed to fix this in diferent ways but it doesn't seem to work.

Do you have any sugestion?



 



---------- Original Message ----------
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: jds <jds@soltis.cc>
Sent: Thu, 6 Mar 2003 14:21:49 -0500 (EST)
Subject: Re: problems in kernel 2.4.20  stat() seems to return always size
zero for any fifo (named pipe)

> On Thu, 6 Mar 2003, jds wrote:
> 
> > 
> >  Hi:
> > 
> > I have a problem using stat() with kernel 2.4.20
> > The size of ANY fifo is always 0.
> > There is no backward compatibility.
> > Probably it is a kernel bug in this particular version.
> > The problem shows up when using the ls, stat commands.
> > 
> > How reproducible:
> > Always
> [SNIPPED...]
> 
> Have you ever tried this before? I'm not aware that stat
> or lstat is supposed to return the byte-count of a pipe
> of FIFO. It certainly doesn't on my Sun SunOS 5.5.1 or
> Linux 2.4.18. In fact, the Sun prevents ^Z when reading
> the FIFO interactively so your script won't test it.
> 
> The second echo "abcd" >xx blocks so the pipe never
> accepts anything anyway, there are never any "bytes-
> in-the-pipe" that should be visible anyway. You can't
> write to a pipe until a reader is reading, and if the
> reader is suspended, there is no requirement for writing
> to be buffered, i.e., a write to be accepted for such
> a pipe.
> 
> Pipes do not work like you propose and, if they ever did,
> that was the bug.
> 
> > Expected Results:  prw-rw-r--    1 kostadin kostadin        5 Feb 21 13:54 xx
> > 
> > In Kernel 2.4.18-X the RedHat work perfect,
> > e inclusive in 2.4.20-X the Redhat
> >   beta 8.0.94
> >
> 
> Linux 2.4.18 does not accept writes to a pipe when a reader is
> not actively reading. As such, a byte-count cannot exist.
> 
> If you have a program that expects a byte-count from a FIFO,
> the program is broken. FIFOs must have readers before any
> writes are accepted.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think 
> about it.
------- End of Original Message -------

