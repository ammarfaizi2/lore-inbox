Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSGLQen>; Fri, 12 Jul 2002 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGLQem>; Fri, 12 Jul 2002 12:34:42 -0400
Received: from mail.storm.ca ([209.87.239.66]:16604 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S316662AbSGLQel>;
	Fri, 12 Jul 2002 12:34:41 -0400
Message-ID: <3D2EF8DB.4DB091FF@storm.ca>
Date: Fri, 12 Jul 2002 11:42:19 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirk Reiser <kirk@braille.uwo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T15g-0007mP-00@speech.braille.uwo.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Reiser wrote:
> 
> ...  What I am striving to do is build a software based speech
> synthesizer into a linux driver. ... over 512k.  Obviously this is
> to large to want built-in to the kernel.

Can you do it in a module instead?

> The majority of the size is from libm.a.

Does dietlibc help?

> There are five functions I need from the library, log(),
> log10(), exp() cos() and sin().

Can you do something useful with integer versions of those functions?
Forth people have done astronomical calculations with only scaled
16-bit arithmetic. If it's accurate enough to aim telescopes, why
not for your job?

Given that phones work with fine 8-bit samples, I suspect speech can
be done just fine with 16-bit math.

base 2 log is easy; I've seen code for it on the web. Scaling that to
get natural log and log10 is straightforward.

exp() is trivial, provided you have the scaling right so it doesn't
overflow into insanity. How hard the scaling is depends on the
application.

I suspect there's a better way, but a brute force unoptimised shot
at 16-bit sin() and cos() just uses a 128 K table; 16 bits in, 16
out.
