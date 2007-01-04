Return-Path: <linux-kernel-owner+w=401wt.eu-S932164AbXADRuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbXADRuc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbXADRuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:50:32 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:39699 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168AbXADRub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:50:31 -0500
Date: Thu, 4 Jan 2007 09:47:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: Albert Cahalan <acahalan@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0701040937460.3661@woody.osdl.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
 <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
 <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
 <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Segher Boessenkool wrote:
> 
> > (in which case, nearly all real-world code is broken)
> 
> Not "nearly all" -- but lots of code, yes.

I wouldn't say "lots of code". I would say "all real projects".

NOBODY will guarantee you that they follow all standards to the letter. 
Some use compiler extensions knowingly, but pretty much _everybody_ ends 
up depending on subtle issues without even realizing it. It's almost 
impossible to write a real program that has no bugs, and if they don't 
show up in testing (because the compiler didn't generate buggy assembly 
code from source code that had the _potential_ for bugs), they often won't 
get fixed.

The kernel does things like compare pointers across objects, and the 
kernel EXPECTS it to work. I seriously doubt that the kernel is even 
unusual in this. The common way to avoid AB-BA deadlocks in any threaded 
code (whether kernel or user space) is to just take two locks in a 
specific order, and the common way to do that for locks of the same type 
is simply to compare the addresses).

The fact that this is "undefined" behaviour matters not a _whit_. Not for 
the kernel, and I bet not for a lot of other applications either.

So "nearly all" is probably _understating_ things rather than overstating 
it as you claim. Anybody who thinks that they have proven the correctness 
of their program is likely lying. It's a good thing if they have _tested_ 
all the code-paths, but they've invariably been tested with a compiler 
that doesn't go out of its way to try to generate "legal but idiotic" 
code. So the testing won't generally find cases where the compiler may 
have been _allowed_ to do something else.

The end result: any nontrivial project always has dodgy code. Because 
people simply don't write perfect code.

Compiler people who don't realize this aren't compiler people. They're 
academics involved with mental masturbation.

		Linus
