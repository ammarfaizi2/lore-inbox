Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275468AbTHJEOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 00:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275469AbTHJEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 00:14:25 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:58265 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S275468AbTHJEOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 00:14:24 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: willy@w.ods.org, davem@redhat.com, jamie@shareable.org, chip@pobox.com,
       jamie@shareable.org, albert@users.sf.net
Content-Type: text/plain
Organization: 
Message-Id: <1060488233.780.65.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Aug 2003 00:03:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau writes:
>On Sat, Aug 09, 2003 at 01:21:17AM +0100, Jamie Lokier wrote:
>> Albert Cahalan wrote:

>>> // tell gcc what to expect:   if(unlikely(err)) die(err);
>>> #define likely(x)       __builtin_expect(!!(x),1)
>>> #define unlikely(x)     __builtin_expect(!!(x),0)
>>> #define expected(x,y)   __builtin_expect((x),(y))
>>
>> You may want to check that GCC generates the same code as for
>>
>>  #define likely(x) __builtin_expect((x),1)
>>  #define unlikely(x) __builtin_expect((x),0)
>>
>> I tried this once, and I don't recall the precise result
>> but I do recall it generating different code (i.e. not
>> optimal for one of the definitions).

I looked at the assembly (ppc, gcc 3.2.3) and didn't
see any overhead.

Note that the kernel code is broken for the likely()
macro, since 42 is a perfectly good truth value in C.

> anyway, in __builtin_expect(!!(x),0) there is a useless
> conversion, because it's totally equivalent to
> __builtin_expect((x),0) (how could !!x be 0 if x isn't ?),
> but I'm pretty sure that the compiler will add the test.

The !!x gives you a 0 or 1 while converting the type.
So a (char*)0xfda9c80300000000ull will become a 1 of
an acceptable type, allowing the macro to work as desired.


