Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVKOAKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVKOAKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKOAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:10:50 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:9188 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932204AbVKOAKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:10:49 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH 2 of 2] tpm: updates for new hardware
Date: Mon, 14 Nov 2005 17:10:41 -0700
User-Agent: KMail/1.8.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jake Moilanen <moilanen@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>
References: <1131739595.5048.15.camel@localhost.localdomain>
In-Reply-To: <1131739595.5048.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141710.41230.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 1:06 pm, Kylene Jo Hall wrote:
> +#ifdef CONFIG_PPC64
> +#define atmel_getb(chip, offset) readb(chip->vendor->iobase + offset);
> +#define atmel_putb(val, chip, offset) writeb(val, chip->vendor->iobase + offset)
> ...
> +#else
> +#define atmel_getb(chip, offset) inb(chip->vendor->base + offset)
> +#define atmel_putb(val, chip, offset) outb(val, chip->vendor->base + offset)

Why don't you use ioread8() instead of defining atmel_getb()?

You'd still need something PPC64-specific to initialize the iomem cookie,
but the accessors would go away.

Unfortunately, ioread8() and associated interfaces aren't mentioned
under Documentation/, but there are some hints in lib/iomap.c.
