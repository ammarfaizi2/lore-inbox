Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbREHJhb>; Tue, 8 May 2001 05:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbREHJhV>; Tue, 8 May 2001 05:37:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33803 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130768AbREHJhF>; Tue, 8 May 2001 05:37:05 -0400
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 7 May 2001 22:37:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bgerst@didntduck.org (Brian Gerst),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com> from "Linus Torvalds" at May 07, 2001 10:12:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wsgr-00046Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If anybody has such a beast, please try this kernel patch _and_ running
> the F0 0F bug-producing program (search for it on the 'net - it must be

One apparent problem with this implementation

> +	 *
> +	 * This verifies that the fault happens in kernel space
> +	 * (error_code & 4) == 0, and that the fault was not a
> +	 * protection error (error_code & 1) == 0.
>  	 */
> -	if (address >= TASK_SIZE)
> +	if (address >= TASK_SIZE && !(error_code & 5))
>  		goto vmalloc_fault;

address might be from the following vmalloc fault. The error code would
indicate user space, so we would do a bogus user space fix up for vmalloc
space, fault and die.

