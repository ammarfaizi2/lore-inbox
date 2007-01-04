Return-Path: <linux-kernel-owner+w=401wt.eu-S1030211AbXADXE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbXADXE1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXADXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:04:27 -0500
Received: from nile.gnat.com ([205.232.38.5]:40640 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030211AbXADXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:04:26 -0500
X-Greylist: delayed 3696 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 18:04:26 EST
In-Reply-To: <d913acf949f84c6dec496a1f52c1f9f5@kernel.crashing.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>  <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org> <d913acf949f84c6dec496a1f52c1f9f5@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7171DDC6-A144-4DFD-96F1-B2DEEF09C5B0@adacore.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       s0348365@sms.ed.ac.uk, bunk@stusta.de, mikpe@it.uu.se
Content-Transfer-Encoding: 7bit
From: Geert Bosch <bosch@adacore.com>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 17:02:48 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 4, 2007, at 13:34, Segher Boessenkool wrote:

> The "signed wrap is undefined" thing doesn't fit in this category
> though:
>
> -- It is an important optimisation for loops with a signed
>    induction variable;

It certainly isn't that important. Even SpecINT compiled with
-O3 and top-of-tree GCC *improves* 1% by adding -fwrapv.
If the compiler itself can rely on wrap-around semantics and
doesn't have to worry about introducing overflows between
optimization passes, it can reorder simple chains of additions.
This is more important for many real-world applications than
being able to perform some complex loop-interchange.
Compiler developers always make the mistake of overrating
their optimizations.

If GCC does really poorly on a few important loops that matter,
that issue is easily addressed. If GCC generates unreliable
code for millions of boring lines of important real-world C,
the compiler is worthless.

   -Geert
