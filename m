Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUADFrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 00:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUADFrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 00:47:55 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:55956
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265137AbUADFrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 00:47:53 -0500
Message-ID: <3FF7A910.40703@tmr.com>
Date: Sun, 04 Jan 2004 00:48:00 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <bsgav5$4qh$1@cesium.transmeta.com>	<Pine.LNX.4.58.0312252021540.14874@home.osdl.org>	<3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl>
In-Reply-To: <m365fsu48n.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> 
>>I would probably write
>>   ( a ? b : c ) = d;
>>instead, having learned C when some compilers parsed ? wrong without
>>parens. Actually I can't imagine writing that at all, but at least
>>with parens humans can read it easily. Ugly code.
>>
>>Your suggestion is not portable, if b or c are declared "register"
>>there are compilers which will not allow taking the address, and gcc
>>will give you a warning.
> 
> 
> One can write as well:
> 
> if (a)
>         b = d;
> else
>         c = d;
> 
> Might be more readable and it is what the compiler does.

Since that's a matter of taste I can't disagree. The point was that the 
original post used
   *(a ? &b : &c) = d;
which generates either warnings or errors if b or c is a register 
variable, because you are not allowed to take the address of a register. 
It seems gcc does it anyway by intuiting what you mean, but it's not 
portable in the sense of being error-free code.

It was a nit, I didn't mean to start a controversy, although if "d" is 
actually a complex expression it is certainly less typing as I showed 
it, and prevents a future maintainer from changing one RHS and not the 
other. That's defensive programming.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
