Return-Path: <linux-kernel-owner+w=401wt.eu-S1753845AbXACF6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbXACF6r (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 00:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXACF6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 00:58:47 -0500
Received: from 1wt.eu ([62.212.114.60]:1716 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbXACF6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 00:58:46 -0500
Date: Wed, 3 Jan 2007 06:55:02 +0100
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: s0348365@sms.ed.ac.uk, torvalds@osdl.org, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070103055502.GP24090@1wt.eu>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701030212.l032CDXe015365@harpo.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 03:12:13AM +0100, Mikael Pettersson wrote:
> On Tue, 2 Jan 2007 17:43:00 -0800 (PST), Linus Torvalds wrote:
> > > The suggestions I've had so far which I have not yet tried:
> > > 
> > > -	Select a different x86 CPU in the config.
> > > 		-	Unfortunately the C3-2 flags seem to simply tell GCC
> > > 			to schedule for ppro (like i686) and enabled MMX and SSE
> > > 		-	Probably useless
> > 
> > Actually, try this one. Try using something that doesn't like "cmov". 
> > Maybe the C3-2 simply has some internal cmov bugginess. 
> 
> That's a good suggestion. Earlier C3s didn't have cmov so it's 
> not entirely unlikely that cmov in C3-2 is broken in some cases.

Agreed! When I developped the cmov emulator, I used an early C3 for the
tests (well, a "Samuel2" to be precise), because it did not report "cmov"
in its flags. I first thought "wow, my emulator is amazingly fast!" because
it took something like 50 cycles to do cmovne %eax,%ebx.

Then I realized that this processor performed cmov itself between
registers, and only triggered the invalid opcode when one of the operand
was a memory reference. And this time, for a hard-coded instruction, it
was really slow...

For this reason, I would not be surprized at all that there would be some
buggy behaviour in the cmov right there. Maybe a bug in the decoder unit
making it skip a byte when the next instruction in the prefetch queue is
a cmov affecting same registers... When vendors can do dirty things such
as executing unsupported instructions, we can expect anything from them.

> Configuring for P5MMX or 486 should be good safe alternatives.

I generally use the P5MMX target for such processors.

> /Mikael

Regards,
Willy

