Return-Path: <linux-kernel-owner+w=401wt.eu-S965050AbXADRZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbXADRZM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbXADRZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:25:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:33135 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965043AbXADRZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:25:10 -0500
In-Reply-To: <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk,
       bunk@stusta.de, mikpe@it.uu.se, torvalds@osdl.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 18:24:08 +0100
To: "Albert Cahalan" <acahalan@gmail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Lack of the flag does not break any valid C code, only code
>> making unwarranted assumptions (i.e., buggy code).
>
> Right, if "C" means "strictly conforming ISO C" to you.

Without any further qualification, it of course does, yes.

> (in which case, nearly all real-world code is broken)

Not "nearly all" -- but lots of code, yes.

> FYI, the kernel also assumes that a "char" is 8 bits.
> Maybe you should run away screaming.

No, that's fine with me.  It's fine with GCC as well
of course.

>> Anyway, with 4.1 you shouldn't see frequent problems due to
>
> Right, it gets much worse with the current gcc snapshots.

Yes.  And that problem will be fixed some way pretty soon --
simply because it _has_ to be fixed.

> IMHO you should play such games with "g++ -O9", but that's
> a discussion for a different mailing list.

For a different mailing list indeed; let me just point out
that for certain important quite common cases it's an ~50%
overall speedup.

>> "not using -fwrapv while my code is broken WRT signed overflow"
>> yet; and if/when problems start to happen, to "correct" action
>> to take is not to add the compiler flag, but to fix the code.
>
> Nope, unless we decide that the performance advantages of
> a language change are worth the risk and pain.

If the kernel breaks all over the place, of course you should add
the flag.  But it won't, it would break *all* programs all over
the place then, and that wouldn't be acceptable to GCC.  If instead
only a few kernel code bugs pop up, it's easy to fix.

Aaaaanyway -- my only real point was to point out that there's
no doomsday scenario here, yes current GCC TOT seems to regress
here (for some definition of that word), but GCC development
is in stage 1, that sort of thing happens.  It'll stabilise
again.

In the meantime, building git HEAD kernels with GCC 4.1 and
4.2 will probably rattle out quite a few bugs still, both
in the kernel and in GCC -- neither is used all that often
it seems?


Segher

