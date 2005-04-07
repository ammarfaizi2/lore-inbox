Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVDGOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVDGOwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVDGOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:52:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25307 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261500AbVDGOwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:52:04 -0400
Date: Thu, 7 Apr 2005 16:51:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, stsp@aknet.ru, linux-kernel@vger.kernel.org,
       VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050407145150.GA6215@elte.hu>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu> <20050407041006.4c9db8b2.akpm@osdl.org> <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > >   	pushfl

> After all, I very strongly suspect that we don't actually really 
> _care_ if eflags stays the same over a system call, and I could see 
> that some dynamic CPU's might prefer not having to push an eflags 
> value that just got changed by the "sti", so it _might_ save several 
> cycles to avoid that dependency, and also obviously avoid a subtle 
> dependency on a sw level that the previous patch clearly introduced.
> 
> Anybody willing to time it? ;)

i can tell you without any measurement that pushfl is slower by a couple 
of cycles than a simple pushl $0x00010046, on basically all x86 CPUs.  
And since we only support SYENTER from 32-bit mode and we dont guarantee 
flags to be saved, it isnt all that incorrect to do?

	Ingo
