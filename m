Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUCKDIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUCKDIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:08:44 -0500
Received: from alt.aurema.com ([203.217.18.57]:55959 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262967AbUCKDIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:08:37 -0500
Message-ID: <404FD81D.3010502@aurema.com>
Date: Thu, 11 Mar 2004 14:08:13 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>	<20040310100215.1b707504.rddunlap@osdl.org>	<Pine.LNX.4.53.0403101324120.18709@chaos>	<404F9E28.4040706@aurema.com> <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 11 Mar 2004, Peter Williams wrote:
> 
>>Richard B. Johnson wrote:
>>
>>>People who develop kernel code know the difference between
>>>'==' and '=' and are never confused my them.
>>
>>And you never make typing mistakes?  That's admirable or should I say 
>>incredible.
> 
> 
> The thing is, people tend to make fewer typing mistakes of that kind, than 
> just plain logic errors from not thinking right about something.
> 
> And while "0 == foo" may be logically the same thing as "foo == 0", the 
> fact is, the latter is what people are used to seeing. And by being used 
> to seeing it, they have an easier time thinking about it.
> 
> As a result, using the former just tends to increase peoples confusion by
> making code harder to read, which in turn tends to increase the chance of 
> bugs.
> 
> So don't do it. The kind of bug that the "0 == x" syntax protects against
> is LESS LIKELY to happen than the kind of bug it tends to cause.
> 
> 		Linus

OK.  I'll change all of such occurences in our EBS patches.

As somebody pointed out -Wall will (help) detect most of these errors by 
suggesting () be placed around any expression of the form a = b that 
occurs inside a simple boolean expression which will cause those people 
who care about eliminating warning messages to reevaluate the code and 
make sure they really meant a = b and replace it with (a = b) to get rid 
of the warning error.

The reason that I say "most" rather than "all" is (that testing shows) 
that if the a = b is part of a more complex expression and is already in 
() in order to (for instance) ensure the desired precedence -Wall will 
not flag it as a possible problem.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


