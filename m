Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWHAVzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWHAVzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHAVzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:55:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3757 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751151AbWHAVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:55:14 -0400
Subject: Re: single bit flip detector.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060801184451.GP22240@redhat.com>
References: <20060801184451.GP22240@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:14:27 +0100
Message-Id: <1154470467.15540.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 14:44 -0400, ysgrifennodd Dave Jones:
> +		case POISON_FREE ^ 0x01:
> +		case POISON_FREE ^ 0x02:
> +		case POISON_FREE ^ 0x04:
> +		case POISON_FREE ^ 0x08:
> +		case POISON_FREE ^ 0x10:
> +		case POISON_FREE ^ 0x20:
> +		case POISON_FREE ^ 0x40:
> +		case POISON_FREE ^ 0x80:
> +			printk (KERN_ERR "Single bit error detected. Possibly bad RAM.\n");
> +#ifdef CONFIG_X86
> +			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
> +#endif
> +			return;

Gack .. NAK

#1: Do we want memtest86 or memtest86+ ?
#2: The check is horrible and there is an elegant implementation for
single bit.

	errors = value ^ expected;
	if (errors && !(errors & (errors - 1)))
		printk(KERN_ERR "Single bit error detected....");


Alan
