Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVBGLo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVBGLo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVBGLo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:44:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11751 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261400AbVBGLoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:44:24 -0500
Date: Mon, 7 Feb 2005 12:44:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
Message-ID: <20050207114415.GA22948@elte.hu>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> I no longer use x86 as my main machine, so this patch is totally
> untested.  I've compiled it to see that things look somewhat sane, but
> that doesn't mean much. If I forgot some register or screwed something
> else up, this will result in a totally nonworking kernel, but I
> thought that maybe somebody else would be interested in looking at
> whether this (a) works, (b) migth even shrink the kernel and (c) might
> make us able to DTRT wrt the page table following crud (old i386 cores
> may be hard to find these days, so maybe people don't care).

boots fine and shrinks the image size quite noticeably:

  [Nr] Name     Type        Addr     Off    Size
  [ 1] .text    PROGBITS    c0100000 001000 2771a9   [vmlinux-orig]
  [ 1] .text    PROGBITS    c0100000 001000 2742dd   [vmlinux-patched]

that's 11980 bytes off a 2585001 bytes .text, a 0.5% size reduction.
This patch we want ...

	Ingo
