Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272206AbRH3NKg>; Thu, 30 Aug 2001 09:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272208AbRH3NK0>; Thu, 30 Aug 2001 09:10:26 -0400
Received: from cs.columbia.edu ([128.59.16.20]:56317 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S272206AbRH3NKS>;
	Thu, 30 Aug 2001 09:10:18 -0400
Date: Thu, 30 Aug 2001 09:10:33 -0400
Message-Id: <200108301310.f7UDAXx05887@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001 20:28:20 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> wrote:

> If you compare a signed integer with a unsigned char, the char gets
> promoted to a _signed_ integer, and the comparison is signed. It is NOT
> a unsigned comparison.
> 
[...]
> 
> Somebody mentioned -Wsign-compare. Try it with the example above. It won't
> warn at all, exactly because under C both sides of such a compare have the
> _same_ sign, even if one is a "unsigned char", and the other is a "signed
> int".

And why should the compiler warn at all? The range of "int" completely 
covers the range of "unsigned char", so the result of the comparison will 
always be correct if the types were chosen correctly.

... unless of course the programmer used an unsigned char when what he 
really wanted was a signed char. But in that case even your typed min 
macro won't save him, because what should the forced type be anyway? If 
it's "int", nothing changes; if it's "signed char", you risk truncating 
the int. So you end up with something like

	min(int, a, (char)b)

and I fail to see how this is any better than

	min(a, (char)b)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
