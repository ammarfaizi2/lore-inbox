Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTA2RR0>; Wed, 29 Jan 2003 12:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbTA2RR0>; Wed, 29 Jan 2003 12:17:26 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:14776 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266702AbTA2RRY>; Wed, 29 Jan 2003 12:17:24 -0500
Message-ID: <20030129172631.29782.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: terje.eggestad@scali.com, leechin@mail.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Date: Wed, 29 Jan 2003 12:26:30 -0500
Subject: Re: debate on 700 threads vs asynchronous code
X-Originating-Ip: 67.122.112.129
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I do method (C)... but many people seem to say that, hey, pthreads does almost just that with a constant memory overhead of remembering the stack per blocking thread... so there is no time difference, just that pthreads consumes slightly more memory.  That is the issue I am trying to get my head around.

That particular question, no one has answered... in Linux, the scheduler will not go around crazy trying to schedule prcosses that are all waiting on IO.  NOw the only time I see a degrade in threads would be if all are runnable.... in that case a async scheme with two threads would let each task run to completion, not thrashing the kernel.  Is that correct to say?
----- Original Message -----
From: Terje Eggestad <terje.eggestad@scali.com>
Date: 27 Jan 2003 10:48:22 +0100
To: Lee Chin <leechin@mail.com>
Subject: Re: debate on 700 threads vs asynchronous code

> Apart from the argument already given on other replies, you should
> keep in mind that you probably need to give priority to doing receive.
> THat include your clients, but if you don't you run into the risk of
> significantly limiting your bandwidth since the send queues around your
> system fill up. 
> 
> Try doing that with threads. 
> 
> 
> Actually I would recommend the approach c)
> 
> c)  Write an asynchronous system with only 2 or three threads where I
> manage the connections and keep the state of each connection in a data
> structure.  
> 
> 
> On fre, 2003-01-24 at 00:19, Lee Chin wrote:
> > Hi
> > I am discussing with a few people on different approaches to solving a scale problem I am having, and have gotten vastly different views
> > 
> > In a nutshell, as far as this debate is concerned, I can say I am writing a web server.
> > 
> > Now, to cater to 700 clients, I can
> > a) launch 700 threads that each block on I/O to disk and to the client (in reading and writing on the socket)
> > 
> > OR
> > 
> > b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder
> > 
> > Which way will yeild me better performance, considerng both approaches are implemented optimally?
> > 
> > Thanks
> > Lee
> -- 
> _________________________________________________________________________
> 
> Terje Eggestad                  mailto:terje.eggestad@scali.no
> Scali Scalable Linux Systems    http://www.scali.com
> 
> Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
> P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
> N-0619 Oslo                     fax:    +47 22 62 89 51
> NORWAY            
> _________________________________________________________________________
> 

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

