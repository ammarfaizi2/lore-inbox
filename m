Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVDETsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVDETsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVDETpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:45:22 -0400
Received: from mail.aknet.ru ([217.67.122.194]:48133 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261882AbVDETlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:41:47 -0400
Message-ID: <4252EA01.7000805@aknet.ru>
Date: Tue, 05 Apr 2005 23:41:53 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> This one can pass through vm86 mode stuff without the high-16-bit fixup,
> as far as I can tell.
Yes, but according to Petr, vm86 is not
affected by the bug at all. I did some
rough tests in the past that seem to
confirm that. Also, in any case, the
dependance of vm86 code on the higher word
of %esp would be very, very obscure.

> So I'd actually prefer to get that mystery explained..
IIRC if the interrupt doesn't do the CPL
switch, the interrupt gate doesn't save
the stack, and so there may not be the
full "struct pt_regs" when the kernel
thread is interrupted.
Does this sound any realistic?

So while it would be excellent to hear
that my patch was not guilty at all, I
think it is not the case. 

