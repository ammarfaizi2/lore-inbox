Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVDETz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVDETz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVDETwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:52:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:60359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261954AbVDETvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:51:40 -0400
Date: Tue, 5 Apr 2005 12:53:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <4252EA01.7000805@aknet.ru>
Message-ID: <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Apr 2005, Stas Sergeev wrote:
> 
> > So I'd actually prefer to get that mystery explained..
> IIRC if the interrupt doesn't do the CPL
> switch, the interrupt gate doesn't save
> the stack, and so there may not be the
> full "struct pt_regs" when the kernel
> thread is interrupted.

Yes. But how do you have _such_ an empty stack when the interrupt comes
in? See what I mean? IOW, that requires that the kernel stack would have
only two words on it when the interrupt happens. How?

It may be a 4kB stack issue or something. Does this happen only with
CONFIG_4KSTACKS, and just after a stack switch to an irq stack, for 
example?

So I definitely think the "bug" is in your optimization, I just think it 
should be a valid optimization and we should just make sure our kernel 
stack is never _so_ empty that "struct pt_regs" is not safe to 
dereference.

		Linus
