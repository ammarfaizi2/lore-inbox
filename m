Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUBZXBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUBZW6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:58:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261231AbUBZW5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:57:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
	<or1xohpjzn.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Feb 2004 19:57:31 -0300
In-Reply-To: <Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
Message-ID: <or4qtdfnz8.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> Ok. I did the silly one-liner, but if the "don't care" approach really 
> improves code generation, feel free to send one that fixes both the P5 and 
> PII cases..

FWIW, I think the silly one-liner is actually an improvement, since
then we use a hardware register for the counter, instead of a stack
location.  I was concerned about not increasing the register pressure
with the patch; it looked very tight already, and I couldn't tell it
wouldn't be exceeded with some older compiler that failed to eliminate
the frame pointer, for example.

If that's the way to go, I'll post a patch that leaves the +r alone.
If using a stack location for the counter could possibly be as
efficient as using a register, I'd convert  "+r" (lines) to "+g".  Any
preferences?

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Happy GNU Year!                     oliva@{lsd.ic.unicamp.br, gnu.org}
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist                Professional serial bug killer
