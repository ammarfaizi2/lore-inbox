Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVCMXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVCMXxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCMXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 18:53:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:24246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261590AbVCMXxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 18:53:13 -0500
Date: Sun, 13 Mar 2005 15:54:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Stas Sergeev <stsp@aknet.ru>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <20050313231734.GA22635@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0503131552010.2822@ppc970.osdl.org>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
 <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
 <20050313231734.GA22635@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2005, Pavel Machek wrote:
> 
> What about flag similar to _TIF_SYSCALL_TRACE (call it
> _TIF_THIS_BEAST_USES_V86 or something), and only do the tests in the
> slowpath if it is set? As normal applications do not use v86, we could
> make this 0 instructions in syscall fast path...

It wouldn't help you. You'd need to mix in two of the values anyway, so at 
most you'd save one instruction. And the cost would be that anything that 
has ever used vm86 mode (can you say "X server"?) would be slower. Not a 
good trade-off.

Oh, I guess you could clear the flag when you know there's no vm86 state
anywhere (easy enough, those things never nest), but then it still comes
back to "extra complexity that you can get wrong, just to save a single
"mov" instruction - that "mov" may have partial-register-stall issues, 
but still..).

		Linus
