Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUBURfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUBURfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:35:11 -0500
Received: from gprs159-17.eurotel.cz ([160.218.159.17]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261586AbUBURfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:35:05 -0500
Date: Sat, 21 Feb 2004 18:34:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
Message-ID: <20040221173449.GA277@elf.ucw.cz>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz> <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	wrmsr(MSR_IA32_UCODE_WRITE,
> > > +		(unsigned long) uci->mc->bits, 
> > > +		(unsigned long) uci->mc->bits >> 16 >> 16);
> > 				             ~~~~~~~~~~~~
> > 
> > I see what you are doing, but this is evil. At least comment /* ">> 32"
> > is undefined on i386 */ ?
> 
> Sorry, but you're wrong.
> 
> ">> 32" is underfined PERIOD! It has nothing to do with x86, it's a C
> standards issue. It's undefined on any 32-bit architecture. (shifting by
> the wordsize or bigger is simply not a defined C operation).

Yep, that is what I wanted to say. [This driver only has meaning for
i386 and ia32e => if we have 32-bit architecture, it must be i386.]

> The above is not evil. The above is the standard way of doing this in C if 
> you know the word-size is 32-bits or bigger.

I'm just afraid that someone will mail you a patch replacing that with
>> 32 and you'll overlook it.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
