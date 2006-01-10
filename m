Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWAJN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWAJN3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWAJN3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:29:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44223 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932138AbWAJN3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:29:46 -0500
Date: Tue, 10 Jan 2006 14:29:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110132957.GA28666@elte.hu>
References: <20060110125852.GA3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110125852.GA3389@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> Hi,
> 
> It does annoy me that any 1G i386 machine will end up with 1/8th of 
> the memory as highmem. A patch like this one has been used in various 
> places since the early 2.4 days at least, is there a reason why it 
> isn't merged yet? Note I just hacked this one up, but similar patches 
> abound I'm sure. Bugs are mine.

yes, i made it totally configurable in 2.4 days: 1:3, 2/2 and 3:1 splits 
were possible. It was a larger patch to enable all this across x86, but 
the Kconfig portion was removed a bit later because people _frequently_ 
misconfigured their kernels and then complained about the results.

so for now the trivial solution is to change the "C" to "8" in the 
following line in include/asm-i386/page.h:

>  #define __PAGE_OFFSET		(0xC0000000)

instead of editing your .config :-)

Maybe we could try the Kconfig solution again, but it'll need alot 
better documentation, dependency on KERNEL_DEBUG and some heavy warnings 
all around.

	Ingo
