Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbRGXEzY>; Tue, 24 Jul 2001 00:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266942AbRGXEzO>; Tue, 24 Jul 2001 00:55:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6660 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266929AbRGXEzL>;
	Tue, 24 Jul 2001 00:55:11 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107240455.f6O4tF3283816@saturn.cs.uml.edu>
Subject: Re: Minor net/core/sock.c security issue?
To: davem@redhat.com (David S. Miller)
Date: Tue, 24 Jul 2001 00:55:15 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        chris@scary.beasts.org (Chris Evans), linux-kernel@vger.kernel.org
In-Reply-To: <15196.61008.690839.396406@pizda.ninka.net> from "David S. Miller" at Jul 23, 2001 08:41:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David S. Miller writes:
> Albert D. Cahalan writes:

>> Long term, __builtin_min() and __builtin_max() would be nice.
>
> I would even avoid this, what is the signedness of their
> arguments and return values?  The answer is: I don't care,
> because I have to look it up.
> 
> And if I have to look it up, I know that most people _won't_ look it
> up and will just guess or assume.  Most people are therefore likely to
> misuse it.

The obvious answer is to enforce that the signedness of their
arguments and return values all match. Anything else won't compile.
This is safer than plain open code, because it forces the programmer
to fix any signedness mismatch.

The whole point of being built-in is that stuff like this can be
handled.

Possibly bad ideas:

The full range of signed/unsigned could be made to work, as if you
were using 33-bit or 65-bit signed math. It might even be sane to take
the return type from whatever is getting fed the return value. It
would be cool to use the exception tables if something goes out of
range, though maybe that would be too slow.


