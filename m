Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUBURNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUBURNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:13:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:19153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbUBURND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:13:03 -0500
Date: Sat, 21 Feb 2004 09:18:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Stephen Hemminger <shemminger@osdl.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <20040221141608.GB310@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Pavel Machek wrote:
>
> > +	wrmsr(MSR_IA32_UCODE_WRITE,
> > +		(unsigned long) uci->mc->bits, 
> > +		(unsigned long) uci->mc->bits >> 16 >> 16);
> 				             ~~~~~~~~~~~~
> 
> I see what you are doing, but this is evil. At least comment /* ">> 32"
> is undefined on i386 */ ?

Sorry, but you're wrong.

">> 32" is underfined PERIOD! It has nothing to do with x86, it's a C
standards issue. It's undefined on any 32-bit architecture. (shifting by
the wordsize or bigger is simply not a defined C operation).

The above is not evil. The above is the standard way of doing this in C if 
you know the word-size is 32-bits or bigger.

		Linus
