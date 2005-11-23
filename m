Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVKWClT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVKWClT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKWClS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:41:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:472 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932464AbVKWClR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:41:17 -0500
Date: Wed, 23 Nov 2005 02:45:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051123014542.GA32485@elf.ucw.cz>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121211544.GA4924@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > and then people can just say
> > 
> > 	if (!dev->irq.valid)
> > 		return;
> > 
> > instead, which is also readable, and where you simply cannot do the old 
> > "if (!dev->irq)" at all.
> > 
> > The fact is, 0 _is_ special. Not just for hardware, but because 0 has 
> > a magical meaning as "false" in the C language.
> 
> yeah, i wanted to suggest this originally, but got distracted by the x86 
> quirk that 'IRQ#0' is often the i8253 timer interrupt.
> 
> is there any architecture where irq 0 is a legitimate setting that could 
> occur in drivers, and which would make NO_IRQ define of 0 non-practical?  
> If not (which i think is the case) then we should indeed standardize on 
> 0. (in one way or another) It's not like any real driver will ever have 
> IRQ#0 even on a PC: the timer IRQ is 'known' to be routed to 0, and we 

Well, I still may want for example disk driver (with broken interrupt)
to hook onto irq#0 (timer). Better than no interrupts at all....

								Pavel
-- 
Thanks, Sharp!
