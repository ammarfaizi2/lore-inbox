Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUBZWlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUBZWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:41:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261221AbUBZWkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:40:35 -0500
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
Date: 26 Feb 2004 19:40:21 -0300
In-Reply-To: <Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
Message-ID: <or8yipforu.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

>> > There is nothing to say that gcc wouldn't do a re-load or something
>> > in between, so you really need to tell the _first_ ask about it.

>> The only other reload it could do is an input reload of p4 and p5,
>> which, again, doesn't matter, because p4 and p5 are dead anyway.

> Ok. That's the missing piece. The thing is wrong, but we don't care, 
> because even if gcc saves the old values for some silly reload, they're 
> dead and uninteresting.

Yup.

> Ok. I did the silly one-liner

That's good enough for me.  I tested that before trying this better
approach, and it worked.

> but if the "don't care" approach really improves code generation,
> feel free to send one that fixes both the P5 and PII cases..

It's not the code generation that is improved, it's just that we can
then refrain from pushing and popping something that nobody cares
about.  It would have worked to just assign a random value to p4 and
p5 after the asm loop; it would be dead anyway.  As long as we made
sure p4 and p5 weren't shared with anything else before, that is.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Happy GNU Year!                     oliva@{lsd.ic.unicamp.br, gnu.org}
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist                Professional serial bug killer
