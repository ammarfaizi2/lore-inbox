Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278620AbRJXPxd>; Wed, 24 Oct 2001 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278624AbRJXPxX>; Wed, 24 Oct 2001 11:53:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278609AbRJXPxK>; Wed, 24 Oct 2001 11:53:10 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 24 Oct 2001 16:59:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org, mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <Pine.LNX.4.33.0110240831200.8049-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 24, 2001 08:41:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wQRC-0001uV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> call might block for some device information, that does not mean that it
> can allocate memory with GFP_KERNEL, for example: when we shut off device
> X, the disk may have been prepared for shutdown already, and the VM layer
> cannot do any IO. So the suspend (and resume) function have to use
> GFP_NOIO for their allocations - _regardless_ of any other device issues.

So I have to write a whole extra set of code paths to duplicate normal
functionality during power off

> So sure, there are tons of issues here, but none of them have, in my
> opinion, anything to do with the device model itself. More just normal
> implementation details.

My concern is that we need to make the implementation details simple. eg
so that simple things like "save state" can be done before we get into
"no this, no that , no the other" situations. Also so that for the many 
drivers where freezing the system once we have irqs off is easier (a lot
of sound for example is easiest done by disable irq, disable dma engine,
copy registers, return) can be done late and with small amounts of code

