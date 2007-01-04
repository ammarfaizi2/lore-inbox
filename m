Return-Path: <linux-kernel-owner+w=401wt.eu-S932227AbXADS4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbXADS4F (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXADS4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:56:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:55740 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227AbXADS4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:56:01 -0500
In-Reply-To: <Pine.LNX.4.64.0701040937460.3661@woody.osdl.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org> <Pine.LNX.4.64.0701040937460.3661@woody.osdl.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f73987269d58cee1b67fcf1d30c9df34@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 19:53:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> (in which case, nearly all real-world code is broken)
>>
>> Not "nearly all" -- but lots of code, yes.
>
> I wouldn't say "lots of code". I would say "all real projects".

All projects that tell the compiler they're written in ISO C,
while they're not, can easily break, sure.  You can't say this
is GCC's fault; sure in some cases decisions were made that
resulted in more of those programs breaking than was really
necessary, but it's obviously *impossible* to prevent all
from breaking.

And yes it's true: most people do not program in ISO C at all,
_even if they think they do_, simply because they are not aware
of all the rules.  For some of the areas where most of the
mistakes are made, for example aliasing rules and signed overflow,
GCC provides helpful options to switch behaviour to something
that makes those people's programs work.  You can also use those
options if you have made a conscious decision that you want to
write your code in one of the resulting dialects of C.


Segher

p.s.  If it's decided to not use -fwrapv, a debug option that
sets -ftrapv can be introduced -- it will make it a BUG() if
any (accidental) signed overflow happens after all.

