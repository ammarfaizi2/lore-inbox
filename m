Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268953AbRHBOSa>; Thu, 2 Aug 2001 10:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268952AbRHBOSU>; Thu, 2 Aug 2001 10:18:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268949AbRHBOSN>; Thu, 2 Aug 2001 10:18:13 -0400
Subject: Re: BUG: invalid MAX_DMA_ADDRESS macro for i386?
To: set@pobox.com (Paul)
Date: Thu, 2 Aug 2001 15:19:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010801011651.K225@squish.home.loc> from "Paul" at Aug 01, 2001 01:16:52 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJKO-0000eP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Well, I have tracked down my problem. We see a comparison
> like this to  determine whether to use a bounce buffer:
> 
> if ( virt_to_bus(addr+buflen) >= MAX_DMA_ADDRESS) {
> ...(use a bounce buffer 'cause that addr is not dma-able)...
> 
> 	This is not working, because MAX_DMA_ADDRESS is defined
> so:
> 
> ./include/asm-i386/dma.h:
> #define MAX_DMA_ADDRESS (PAGE_OFFSET+0x1000000)

MAX_DMA_ADDRESS is intended for checking virtual addresses not bus
addresses. 

Alan
