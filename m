Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269521AbRHAFRu>; Wed, 1 Aug 2001 01:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269648AbRHAFRl>; Wed, 1 Aug 2001 01:17:41 -0400
Received: from member.michigannet.com ([207.158.188.18]:57104 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S269521AbRHAFRY>; Wed, 1 Aug 2001 01:17:24 -0400
Date: Wed, 1 Aug 2001 01:16:52 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: invalid MAX_DMA_ADDRESS macro for i386?
Message-ID: <20010801011651.K225@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


	Dear All;

	2.4.6-ac5 kernel, i486.
	Well, I have tracked down my problem. We see a comparison
like this to  determine whether to use a bounce buffer:

if ( virt_to_bus(addr+buflen) >= MAX_DMA_ADDRESS) {
...(use a bounce buffer 'cause that addr is not dma-able)...

	This is not working, because MAX_DMA_ADDRESS is defined
so:

./include/asm-i386/dma.h:
#define MAX_DMA_ADDRESS (PAGE_OFFSET+0x1000000)

	This looks to come out to 0xc1000000. This does not seem
to be comparable to a bus address. eg. 0x100000 == 16M, the DMA
limit on ISA bus.
	This driver doesnt work on ISA machine with > 16M, as the
bounce buffer never gets used. (forcing its unconditional use
makes it work fine)
	So, what is wrong here? Macro, or conditional? Clue me in
so I can fix it correctly.

Paul
set@pobox.com
