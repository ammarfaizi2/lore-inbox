Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFDUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFDUYT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFDUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 16:24:19 -0400
Received: from [85.8.12.41] ([85.8.12.41]:43442 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261233AbVFDUYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 16:24:16 -0400
Message-ID: <42A20DEE.5040702@drzeus.cx>
Date: Sat, 04 Jun 2005 22:24:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for read-only MMC cards
References: <42A2070D.9060608@drzeus.cx> <20050604205810.A23449@flint.arm.linux.org.uk> <42A2096C.9010108@drzeus.cx> <20050604210733.B23449@flint.arm.linux.org.uk> <42A20B97.4080504@drzeus.cx> <20050604211604.C23449@flint.arm.linux.org.uk>
In-Reply-To: <20050604211604.C23449@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Can't we set mmc_card_readonly status if !CCC_BLOCK_WRITE ?  Would that
>not simplify the code in the open method as well?
>
>  
>

Well, that depends on what we want mmc_card_readonly to signify. My
thought was that it meant the entire card was read only (as should be
the case with the external ro-switch on SD cards). This might not be the
same thing as that the card lacks block writes. E.g. there are cards
with combined I/O and storage functionality.

For most cases the lack of CCC_BLOCK_WRITE will mean read-only for
everything that the card can do. But I'm not convinced that's the case
for all cards. The fact that there are command classes for streamed
writes should indicate possible corner cases.
