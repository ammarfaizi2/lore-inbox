Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVHOGWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVHOGWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVHOGWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:22:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13960 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932097AbVHOGWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:22:25 -0400
Date: Mon, 15 Aug 2005 08:23:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: kernel0 n0 build0 B-) RT-V0.7.53-06
Message-ID: <20050815062314.GA5583@elte.hu>
References: <Pine.LNX.4.63.0508121011040.22346@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508121011040.22346@ghostwheel.llnl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=disabled SpamAssassin version=3.0.4
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Harding <charding@llnl.gov> wrote:

>   CC      drivers/ide/ide-taskfile.o
> drivers/ide/ide-taskfile.c: In function `ide_pio_sector':
> drivers/ide/ide-taskfile.c:282: error: `flags' undeclared (first use in 
> this function)
> drivers/ide/ide-taskfile.c:282: error: (Each undeclared identifier is 
> reported only once
> drivers/ide/ide-taskfile.c:282: error: for each function it appears in.)
> make[2]: *** [drivers/ide/ide-taskfile.o] Error 1
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2
> 
> It needs this patch to fix:

thanks. I solved it a bit differently, by reverting this original change 
around the flags:

> -#ifdef CONFIG_HIGHMEM
> +#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_PREEMPT_RT)

	Ingo
