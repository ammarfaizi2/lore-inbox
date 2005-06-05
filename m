Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVFEIVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVFEIVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFEIVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:21:53 -0400
Received: from [85.8.12.41] ([85.8.12.41]:53938 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261527AbVFEIVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:21:40 -0400
Message-ID: <42A2B610.1020408@drzeus.cx>
Date: Sun, 05 Jun 2005 10:21:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ISA DMA controller hangs
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain>
In-Reply-To: <1117288285.2685.10.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>
>The DMA controller has some bits of state which are potentially in need
>of restoration as well as a need to ensure you don't suspend while it is
>running I would imagine. Even for bus masters I believe you would need
>to restore the DMA enable bits.
>  
>

I avoid using DMA during suspend to make sure it doesn't get into some
wierd state, but that doesn't solve the problem.

I added some debug output to the driver, dumping the DMA controller's
registers before and after suspend and it seems it goes completely
apeshit. The registers are filled with, what it seems, random data. The
reason it stops working seems to be that channel 4 gets disabled killing
the cascaded channels. I'm going to try and confirm this today.

Now for the solution. Reseting the DMA controller from a device driver
isn't really a good solution. I had a look in dma.c but it didn't seem
to have any place to attach resume/suspend functions. Also, I couldn't
find where DMA channel 4 is enabled during startup. Or does the kernel
count on BIOS doing this?

Rgds
Pierre

