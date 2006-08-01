Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHAWaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHAWaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWHAWaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:30:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16772 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750705AbWHAWaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:30:22 -0400
Date: Tue, 1 Aug 2006 18:30:11 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060801223011.GF22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154470467.15540.88.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:14:27PM +0100, Alan Cox wrote:
 > Ar Maw, 2006-08-01 am 14:44 -0400, ysgrifennodd Dave Jones:
 > > +		case POISON_FREE ^ 0x01:
 > > +		case POISON_FREE ^ 0x02:
 > > +		case POISON_FREE ^ 0x04:
 > > +		case POISON_FREE ^ 0x08:
 > > +		case POISON_FREE ^ 0x10:
 > > +		case POISON_FREE ^ 0x20:
 > > +		case POISON_FREE ^ 0x40:
 > > +		case POISON_FREE ^ 0x80:
 > > +			printk (KERN_ERR "Single bit error detected. Possibly bad RAM.\n");
 > > +#ifdef CONFIG_X86
 > > +			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
 > > +#endif
 > > +			return;
 > 
 > Gack .. NAK
 > 
 > #1: Do we want memtest86 or memtest86+ ?

I doubt it really matters.

 > #2: The check is horrible and there is an elegant implementation for
 > single bit.
 > 
 > 	errors = value ^ expected;
 > 	if (errors && !(errors & (errors - 1)))
 > 		printk(KERN_ERR "Single bit error detected....");
 
Good call, I'll hack that up.

		Dave

-- 
http://www.codemonkey.org.uk
