Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281863AbRLOC0J>; Fri, 14 Dec 2001 21:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281836AbRLOCZ7>; Fri, 14 Dec 2001 21:25:59 -0500
Received: from CPE-203-51-26-3.nsw.bigpond.net.au ([203.51.26.3]:39043 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S281835AbRLOCZw>; Fri, 14 Dec 2001 21:25:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: [PATCH] 2.5.1-pre10 #ifdef CONFIG_KMOD Cleanup Part II. 
In-Reply-To: Your message of "Fri, 14 Dec 2001 10:38:17 MDT."
             <Pine.LNX.4.40.0112141019100.11489-100000@waste.org> 
Date: Sat, 15 Dec 2001 12:26:29 +1100
Message-Id: <E16F3av-0003TC-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.40.0112141019100.11489-100000@waste.org> you write:
> On Thu, 13 Dec 2001, Rusty Russell wrote:
> 
> > 2) Adds request_module_start()/request_module_end() macros, eg.
> >
> > 	struct protocol protoptr;
> >
> > 	request_module_start("proto-%u", protonum) {
> > 		/* search for protocol, set protoptr. */
> >
> > 	} request_module_end(protoptr != NULL);
> >
> >    This loops once if !CONFIG_KMOD or protoptr != NULL after first
> >    iteration, otherwise calls request_module and loops a second time.
> 
> Clever, but very un-C-like. Perhaps something like this:
> 
> do {
>   /* search for protocol, set protoptr. */
> } while (protoptr != NULL || request_module("proto-%u",protonum)==0);
> 
> ..with request_module returning -EBUSY if the module is already loaded.

This can spin forever 8(.  I would love to have just a
request_module_loop() macro, eg:

	request_module_loop("proto-%u", protonum) {
		...
	}

But it turns out not to be possible without more C 9x compliance
(ie. local variable decls in for () loops).

> > 3) Adds a request_module_unless() macro, eg:
> >
> > 	protoptr = request_module_unless(protoptrs[proto],
> > 					 "proto-%u", protonum);
> 
> Also weird.

Ack.  However, I was looking for positive suggestions 8)

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
