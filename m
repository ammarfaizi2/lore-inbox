Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266738AbRGXDDG>; Mon, 23 Jul 2001 23:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGXDCq>; Mon, 23 Jul 2001 23:02:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:39440 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266738AbRGXDCp>;
	Mon, 23 Jul 2001 23:02:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107240302.f6O32iB279266@saturn.cs.uml.edu>
Subject: Re: Minor net/core/sock.c security issue?
To: davem@redhat.com (David S. Miller)
Date: Mon, 23 Jul 2001 23:02:44 -0400 (EDT)
Cc: chris@scary.beasts.org (Chris Evans), linux-kernel@vger.kernel.org
In-Reply-To: <15196.45004.237634.928656@pizda.ninka.net> from "David S. Miller" at Jul 23, 2001 04:14:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David S. Miller writes:

> In short, min/max usage is pretty broken.  And it is broken for
> several reasons:
>
> 1) Signedness, what you have discovered.
>
> 2) Arg evaluation.
>
> 3) Multiple definitions
...
> There is even commentary about this in include/linux/netfilter.h along
> with Rusty's attempt to make reasonable macros.  I personally disagree
> with keeping them as macros because of the arg multiple evaluation
> issues.
>
> I think the way to fix this is to either:
> 
> 1) have standard inline functions with names that suggest the
>    signedness, much like Rusty's netfilter macros.
>
> 2) Just open code all instances of min/max, there will be no
>    mistaking what the code does in such a case.
>
> In both cases, min/max simply die and nobody can therefore misuse them
> anymore.

The macros won't die. You could make global ones like this:

#define min(a,b) Never do this due to signed/unsigned issues.
#define max(a,b) Never do this due to signed/unsigned issues.
#define MIN(a,b) Never do this due to signed/unsigned issues.
#define MAX(a,b) Never do this due to signed/unsigned issues.

Long term, __builtin_min() and __builtin_max() would be nice.
I'm guessing the g++ <? and >? operators don't handle signs right,
but in case they do then that is an even better option.
