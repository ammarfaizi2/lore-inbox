Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272317AbRH3Q2N>; Thu, 30 Aug 2001 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRH3Q2E>; Thu, 30 Aug 2001 12:28:04 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:48912 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S272317AbRH3Q1u>; Thu, 30 Aug 2001 12:27:50 -0400
Date: Thu, 30 Aug 2001 12:28:05 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108301217280.9230-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Linus Torvalds wrote:

> You obviously do not understand the issue at all.

No offence, but you obviously assume too much.

> It doesn't _matter_ that the int covers the whole space of "unsigned
> char".
> 
> What if the "int" happens to be negative?

If the "int" happens to be negative, the comparison will say that the
"int" is smaller than the "unsigned char". This is the expected result.
What exactly is wrong with this?

So I have this number, -200, which is stored in an int. I have this other
number, 200, which is stored in an unsigned char. Everybody in his right
mind will agree that -200 is smaller than 200, the compiler will do just
that, yet you disagree???

> Basically, when you compare a "long" to a "xxx", and the xxxx is unsigned,
> WHAT ARE THE RESULTS?

So now you're turning it around. If you compare a long with unsigned char,
there is no issue. If you compare long with unsigned int, you get the
right result on the alpha and a warning on x86. If you compare long with
unsigned long, you get a warning period.

> And the answer is that you simply DO NOT KNOW! If the xxxx is "unsigned
> int", the sign of the compare actually depends on whether "int" is smaller
> than "long" on the particular architecture you're compiling for. So the
> sign of the compare actually ends up being different on an alpha than on a
> x86.

And read above. You get the right result on the alpha and a warning on the 
x86. I don't see the problem with that.

If you want to be 100% paranoid, change the sign-compare warning into an 
error, so people don't ignore it. That's a much better alternative, and 
gcc supports it.

> Stating the type you compare in explicitly means that you do not get
> surprised.

No. It means I suppress the gcc warning before I get a chance to see it. 
It does NOT necessarily mean I (and by "I" I mean your average programmer) 
think about the range issues, I just think Linux min/max are broken.

> And not getting surprisied is a good thing.

Duplicating types all over the place is a bad thing, however.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

