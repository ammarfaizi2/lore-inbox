Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVG2UJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVG2UJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVG2UJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:09:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262801AbVG2UI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:08:59 -0400
Date: Fri, 29 Jul 2005 13:08:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 io_apic.c: Memorize at bootup where the i8259 is
 connected
In-Reply-To: <m11x5h2yv8.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0507291302360.3307@g5.osdl.org>
References: <m11x5h2yv8.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, Eric W. Biederman wrote:
> 
> Since the acpi MADT table does not provide the location where the i8259
> is connected we have to look at the hardware to figure it out.

I'm not really happy with this.

First off, it kind of assumes that extINT is always the 8259. Maybe that's
true, maybe it's not. Maybe there is hardware out there that has a
specialty interrupt controller that also uses extInt? Secondly, why always
just on IO-APIC 0? This would make a lot more sense to do inside the
loop-over-apics in enable_IO_APIC, no?

Especially since that one already calculates the number of entries, and
does it a lot more nicely than you do.. (ie no shifting and masking with
magic constants).

Finally, the third issue I have is that _if_ the MP table is correct,
we'll never know. Wouldn't it be better to query the MP table regardless,
and see if it agrees with what we found, and if it doesn't, at least print
a message so that it is easier to debug things if sh*t happens?

		Linus
