Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTEAE2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTEAE2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:28:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41478 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262352AbTEAE2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:28:47 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Thu, 1 May 2003 04:40:58 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b8q8gq$4o3$1@penguin.transmeta.com>
References: <87d6j34jad.fsf@student.uni-tuebingen.de.suse.lists.linux.kernel> <Pine.LNX.4.44.0304301801210.20283-100000@home.transmeta.com.suse.lists.linux.kernel> <p73ade730d1.fsf@oldwotan.suse.de>
X-Trace: palladium.transmeta.com 1051764058 8127 127.0.0.1 (1 May 2003 04:40:58 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 May 2003 04:40:58 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <p73ade730d1.fsf@oldwotan.suse.de>, Andi Kleen  <ak@suse.de> wrote:
>Linus Torvalds <torvalds@transmeta.com> writes:
>
>> Yeah, except if you want best code generation you should probably use
>> 
>> 	static inline int fls(int x)
>> 	{
>> 		int bit;
>> 		/* Only well-defined for non-zero */
>> 		asm("bsrl %1,%0":"=r" (bit):"rm" (x));
>
>"g" should work for the second operand too and it'll give gcc
>slightly more choices with possibly better code.

"g" allows immediates, which is _not_ correct.

>But the __builtin is probably preferable if gcc supports it because
>a builtin can be scheduled, inline assembly can't.

You're over-estimating gcc builtins, and underestimating inline
assembly. 

gcc builtins usually generate _worse_ code than well-written inline
assembly, since builtins try to be generic (at least the ones that are
cross-architecture).

And inline asms schedule as well as any built-in, unless they are marked
volatile (either explicitly or implicitly by not having any outputs).

And the proof is in the pudding: I'll bet you a dollar my code generates
better code. AND my code works on the intel compiler _and_ with older
gcc's.

The fact is, gcc builtins are almost never worth it. 

		Linus
