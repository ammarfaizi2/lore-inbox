Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRH3QMd>; Thu, 30 Aug 2001 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272305AbRH3QMZ>; Thu, 30 Aug 2001 12:12:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272304AbRH3QMK>; Thu, 30 Aug 2001 12:12:10 -0400
Date: Thu, 30 Aug 2001 09:09:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108301310.f7UDAXx05887@buggy.badula.org>
Message-ID: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Aug 2001, Ion Badulescu wrote:
> >
> > Somebody mentioned -Wsign-compare. Try it with the example above. It won't
> > warn at all, exactly because under C both sides of such a compare have the
> > _same_ sign, even if one is a "unsigned char", and the other is a "signed
> > int".
>
> And why should the compiler warn at all? The range of "int" completely
> covers the range of "unsigned char", so the result of the comparison will
> always be correct if the types were chosen correctly.

You obviously do not understand the issue at all.

It doesn't _matter_ that the int covers the whole space of "unsigned
char".

What if the "int" happens to be negative?

Right. You get _totally_ different results for a unsigned and a signed
compare. For the signed compare, you do obviously get the "logical"
result, that the negative int is smaller than the unsigned char. But if
you're not _aware_ of the signedness, you may not think about the issues.

Basically, when you compare a "long" to a "xxx", and the xxxx is unsigned,
WHAT ARE THE RESULTS?

And the answer is that you simply DO NOT KNOW! If the xxxx is "unsigned
int", the sign of the compare actually depends on whether "int" is smaller
than "long" on the particular architecture you're compiling for. So the
sign of the compare actually ends up being different on an alpha than on a
x86.

Stating the type you compare in explicitly means that you do not get
surprised.

And not getting surprisied is a good thing.

		Linus

