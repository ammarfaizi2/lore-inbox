Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVCMXSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVCMXSD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 18:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVCMXSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 18:18:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23466 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261572AbVCMXR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 18:17:57 -0500
Date: Mon, 14 Mar 2005 00:17:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stas Sergeev <stsp@aknet.ru>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
Message-ID: <20050313231734.GA22635@elf.ucw.cz>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 13-03-05 13:13:16, Linus Torvalds wrote:
> 
> 
> On Sun, 13 Mar 2005, Stas Sergeev wrote:
> >
> > Such an optimization will cost three more
> > instructions, one of which is a "taken"
> > jump.
> 
> I think Pavel missed the fact that you have to check the VM86 bit in
> eflags before you check SS, since otherwise SS doesn't mean anything
> special at all (ie checking for just the normal SS isn't correct: you
> could have a 16-bit SS that looks normal, but is actually a vm86 segment).
> 
> Pavel: for the same reason you have to check the low two bits of CS too, 
> since if they are zero, then SS hasn't been saved on the stack at all, so 
> comparing it against some normal value is meaningless.

Yes, I missed that one, thanks.

What about flag similar to _TIF_SYSCALL_TRACE (call it
_TIF_THIS_BEAST_USES_V86 or something), and only do the tests in the
slowpath if it is set? As normal applications do not use v86, we could
make this 0 instructions in syscall fast path...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
