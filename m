Return-Path: <linux-kernel-owner+w=401wt.eu-S932288AbXAGAg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbXAGAg6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAGAg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:36:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3643 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932288AbXAGAg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:36:57 -0500
Date: Sun, 7 Jan 2007 00:36:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070107003644.GA4240@ucw.cz>
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <200701051553.04673.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701050757320.3661@woody.osdl.org> <200701051619.54977.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701050827290.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701050827290.3661@woody.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (I realise with problems like these it's almost always some sort of obscure 
> > hardware problem, but I find that very difficult to believe when I can toggle 
> > from 3 years of stability to 6-18 hours crashing by switching compiler. I've 
> > also ran extensive stability test programs on the hardware with absolutely no 
> > negative results.)
> 
> The thing is, I agree with you - it does seem to be compiler-related. But 
> at the same time, I'm almost positive that it's not in "pipe_poll()" 
> itself, because that function is just too simple, and looking at the 
> assembly code, I don't see how what you describe could happen in THAT 
> function.
> 
> HOWEVER.
> 
> I can easily see an NMI coming in, or another interrupt, or something, and 
> that one corrupting the stack under it because of a compiler bug (or a 
> kernel bug that just needs a specific compiler to trigger). For example, 
> we've had problems before with the compiler thinking it owns the stack 
> frame for an "asmlinkage" function, and us having no way to tell the 
> compiler to keep its hands off - so the compiler ended up touching 
> registers that were actually in the "save area" of the interrupt or system 
> call, and then returning with corrupted state.
> 
> Here's a stupid patch. It just adds more debugging to the oops message, 
> and shows all the code pointers it can find on the WHOLE stack.
> 
> It also makes the raw stack dumping print out as much of the stack 
> contents _under_ the stack pointer as it does above it too.
> 
> However, this patch is mostly useless if you have a separate stack for 
> IRQ's (since if that happens, any interrupt will be taken on a different 
> stack which we don't see any more), so you should NOT enable the 4KSTACKS 
> config option if you try this out.

stupid idea... perhaps gcc-4.1 generates bigger stackframe somewhere,
and stack overflows?

that hw monitoring thingie... I'd turn it off. Its interactions with
acpi are non-trivial and dangerous.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
