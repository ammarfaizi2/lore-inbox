Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263873AbVBCUYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbVBCUYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbVBCUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:22:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31934 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263605AbVBCUUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:20:51 -0500
Date: Thu, 3 Feb 2005 21:20:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050203202032.GA24192@elte.hu>
References: <4201DBE7.30569.2F5D446@localhost> <4202BFDB.24670.67046BC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202BFDB.24670.67046BC@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> > > dl_make_stack_executable() will nicely return into user_input
> > > (at which time the stack has already become executable).
> > 
> > wrong, _dl_make_stack_executable() will not return into user_input() in
> > your scenario, and your exploit will be aborted. Check the glibc sources
> > and the implementation of _dl_make_stack_executable() in particular. 
> 
> oh, you mean the invincible __check_caller(). one possibility:
> 
> [...]
> [field1 and other locals replaced with shellcode]
> [value of __libc_stack_end]
> [some space for the local variables of dl_make_stack_executable and others]
> [saved EBP replaced with anything in this case]
> [saved EIP replaced with address of a 'pop eax'/'retn' sequence]
> [address of [value of __libc_stack_end], loads into eax]
> [address of dl_make_stack_executable()]
> [address of a suitable 'retn' insn in ld.so/libpthread.so]
> [user_input left in place, i.e., overflows end before this]
> [...]

still wrong. What you get this way is a nice, complicated NOP.

	Ingo
