Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUAEB2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUAEB2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:28:23 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:15765
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265833AbUAEB2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:28:13 -0500
Message-ID: <3FF8BDBB.4060708@tmr.com>
Date: Sun, 04 Jan 2004 20:28:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org> <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl> <3FF7A910.40703@tmr.com> <Pine.LNX.4.58.0401041232440.2162@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401041232440.2162@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 4 Jan 2004, Bill Davidsen wrote:
> 
>>Since that's a matter of taste I can't disagree. The point was that the 
>>original post used
>>   *(a ? &b : &c) = d;
>>which generates either warnings or errors if b or c is a register 
>>variable, because you are not allowed to take the address of a register. 
> 
> 
> The thing is, the above case is the _only_ case where there is any point
> to using a conditional expression and an assignment to the result in the
> same expression.

We disagree, see below.

> If you have local variables (register or not), the sane thing to do is
> 
> 	if (a)
> 		b = d;
> 	else
> 		c = d;
> 
> or variations on that. That's the readable code.

But may lead to errors in maintenence. Your first example below avoids 
that problem. Imagine instead of "d" you have a 40-50 character RHS. Now 
imagine that the code needs to be changed. If you have the long 
expression in two places then it invites the possiblility of someone 
changing only one of them. You may never make mistakes, but the rest of 
us do, and the conditional LHS avoids that.
> 
> The only case where conditional assignment expressions are useful is when
> you are literally trying to avoid doing branches, and the compiler isn't
> smart enough to avoid them otherwise. 
> 
> Check the compiler output some day. Try out what
> 
> 	int a, b;
> 
> 	void test_assignment_1(int val)
> 	{
> 		*(val ? &a : &b) = 1;
> 	}

You pointed out that this generates good code, I pointed out that it 
also avoids future errors and is not just a trick for broken compilers. 
I take your point about generating good code, I'm sorry you can't see 
that avoiding code duplication is good practice even without the benefit 
of better code.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
