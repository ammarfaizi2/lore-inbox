Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136168AbREGPFX>; Mon, 7 May 2001 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136176AbREGPFN>; Mon, 7 May 2001 11:05:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136168AbREGPEx>; Mon, 7 May 2001 11:04:53 -0400
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
To: bgerst@didntduck.org (Brian Gerst)
Date: Mon, 7 May 2001 16:07:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3AF6B7D0.B63FD27C@didntduck.org> from "Brian Gerst" at May 07, 2001 10:57:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wmbg-0003b3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > (The current -ac fix for the double vmalloc races is below. WP test makes it
> > more complex than is nice)
> 
> WP test is easy to handle.  Just filter out protection violations and
> only take the vmalloc path if the page was not found.
> 
> -       if (address >= TASK_SIZE && !(error_code & 4))
> +       if (address >= TASK_SIZE && !(error_code & 5))

That is nice. I hadn't thought about doing it that way. It still has the problem
if %cr2 is corrupted by a vmalloc fault but it cleans up my other code paths
nicely.

Thanks

