Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272277AbTHIIOY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 04:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272278AbTHIIOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 04:14:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14857 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272277AbTHIIOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 04:14:23 -0400
Date: Sat, 9 Aug 2003 10:13:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030809081346.GC29616@alpha.home.local>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809002117.GB26375@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 01:21:17AM +0100, Jamie Lokier wrote:
> Albert Cahalan wrote:
> > // tell gcc what to expect:   if(unlikely(err)) die(err);
> > #define likely(x)       __builtin_expect(!!(x),1)
> > #define unlikely(x)     __builtin_expect(!!(x),0)
> > #define expected(x,y)   __builtin_expect((x),(y))
> 
> You may want to check that GCC generates the same code as for
> 
> 	#define likely(x)	__builtin_expect((x),1)
> 	#define unlikely(x)	__builtin_expect((x),0)
> 
> I tried this once, and I don't recall the precise result but I do
> recall it generating different code (i.e. not optimal for one of the
> definitions).

anyway, in __builtin_expect(!!(x),0) there is a useless conversion, because
it's totally equivalent to __builtin_expect((x),0) (how could !!x be 0 if x
isn't ?), but I'm pretty sure that the compiler will add the test.

Willy

