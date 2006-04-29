Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWD2CuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWD2CuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWD2CuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:50:08 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:2028 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S932342AbWD2CuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:50:06 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Avi Kivity" <avi@argo.co.il>, <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	<d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
	<444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
	<20060427201531.GH13027@w.ods.org>
	<750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
	<4451E185.9030107@argo.co.il>
	<mj+md-20060428.105455.7620.atrey@ucw.cz>
	<4451FCCC.4010006@argo.co.il>
	<Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr>
	<44524A8A.3060308@argo.co.il>
	<Pine.LNX.4.61.0604281309250.7998@chaos.analogic.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 29 Apr 2006 04:50:04 +0200
In-Reply-To: <Pine.LNX.4.61.0604281309250.7998@chaos.analogic.com>
Message-ID: <m3d5f1umcj.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming the Cc list since probably nobody is interested in yet
another language flame]

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Fri, 28 Apr 2006, Avi Kivity wrote:
> > Developer performance equates to runtime performance.
> 
> Read what you wrote! It's absolutely, incredibly stupid!
> 
> The cost in developer time is borne once. The cost of performance
> is borne every time you run the application.

That last sentence is true.  The rest is you misunderstanding him.

Yes, for some things it is worth hand optimizing until you're blue in
the face, but most of the time the language doesn't matter at all.  No
matter what you do, 99% of the execution time will be spent waiting
for disk or waiting for user input.

Even if the task is CPU bound, a higher level language (C++/STL,
Python, Perl, vhatever) may be faster than most C implementations
because the time spent in the high level language is insignificant
compared to the time spent in the highly optimized libraries that come
with those languages (e.g. the regexp stuff in perl).  

And even if there is no optimized library it may still be better to
develop in a higher level language because the algorithms used may be
clearer than the same code in C because the C code needs so much
manual bookkeping to work.  If the algorithm is easier to understand
it is usually also easier to optimize, and remember that algorithmic
optimizations usually give magnitudes of better performance, while low
level optimizatios just provide a few percent.

Another thing to consider is that at program that always completes
successfully, although a bit slow, is usually a lot better than a
program that is fast for most data sets but segfaults for some others.
It is much too easy to make a simple off-by-one mistake in C or forget
to free some memory and get a memory leak.  A really good C programmer
will not make that kind of mistakes all that often, and with good C
libraries and a good program structure a C application can also be
easy to understand and optimize, but lets face it, most C programmers
and C programs aren't all that good.

With all that said, I personally belive that coding the kernel in C
and assembly is a very good choice.  The performance of the kernel
affects every application on the system, so saving a few bytes of
memory in a page table descriptor or a some tenths of a percent in a
hot path will mean a huge gain for the system as a whole.  And the
kernel maintainers are a bunch of extremely talented people who do a
tremendous job of keeping the kernel clean and maintainable.  With
almost 15 years of development spent on the kernel written in C, they
are starting to understand what works and what doesn't work.  If we
try to implement parts of the kernel in C++, we'll have to spend
another 10 years learning what works and doesn't work in C++. [1]

So for some things, such as the kernel, very resource constrained
systems, libraries that everyone use, C is a good choice.  But blindly
choosing C, based on some naive belief that C is always more
performant, that is just plain stupid.

Sorry for the rant, but this particular subject is a just a particular
itch of mine.

  /Christer (who prefers programming C and Python)

[1] Recommended reading: Safer C by Les Hatton.

> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

This part of legalese is just plain silly, if you didn't want the
world to read your mails, don't post to public mailing lists.

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
