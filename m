Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUHaMIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUHaMIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUHaMIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:08:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61871 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268055AbUHaMEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:04:34 -0400
Date: Tue, 31 Aug 2004 14:06:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andy Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy I/O bitmap copy for i386 (ver 2) ...
Message-ID: <20040831120611.GA14466@elte.hu>
References: <Pine.LNX.4.58.0408241113370.2026@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408241113370.2026@bigblue.dev.mdolabs.com>
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


* Davide Libenzi <davidel@xmailserver.org> wrote:

> The following patch implements the lazy I/O bitmap copy for the i386
> architecture. It uses an invalid bitmap offset inside the TSS to
> eventually handle the correct bitmap update in the GPF handler. The
> logic is the same of the first version, plus the usage of
> get/put_cpu() (thx Brian) and the nesting over the latest Ingo
> variable bitmap bits.

your patch looks good to me. I believe the killer argument is what you
mentioned previously, that a single GFP is cheaper than a single I/O op,
so even the worst-case (an I/O app doing precisely one I/O op during its
scheduling atom - very unlikely) shouldnt degrade all that much. The
patch is a speedup in every other case.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
