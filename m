Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUABWOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUABWOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:14:20 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:3730 "EHLO
	gaimboi.tmr.com") by vger.kernel.org with ESMTP id S265661AbUABWOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:14:19 -0500
Message-ID: <3FF5E952.70308@tmr.com>
Date: Fri, 02 Jan 2004 16:57:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Actually, those language extensions (while documented for a long time) are 
> pretty ugly. 
> 
> Some of that ugliness turns into literal bugs when C++ is used.
> 
> The cast/conditional expression as lvalue are _particularly_ ugly 
> extensions, since there is absolutely zero point to them. They are very 
> much against what C is all about, and writing something like this:
> 
> 	a ? b : c = d;
> 
> is something that only a high-level language person could have come up 
> with. The _real_ way to do this in C is to just do
> 
> 	*(a ? &b : &c) = d;
> 
> which is portable C, does the same thing, and has no strange semantics.

I would probably write
   ( a ? b : c ) = d;
instead, having learned C when some compilers parsed ? wrong without 
parens. Actually I can't imagine writing that at all, but at least with 
parens humans can read it easily. Ugly code.

Your suggestion is not portable, if b or c are declared "register" there 
are compilers which will not allow taking the address, and gcc will give 
you a warning.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
