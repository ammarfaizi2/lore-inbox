Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWHLQHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWHLQHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWHLQHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:07:16 -0400
Received: from mail04.hansenet.de ([213.191.73.12]:26814 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S964872AbWHLQHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:07:14 -0400
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Date: Sat, 12 Aug 2006 18:06:02 +0200
User-Agent: KMail/1.9.3
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <1155326835.24077.116.camel@localhost.localdomain>
In-Reply-To: <1155326835.24077.116.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121806.02844.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 22:07, Alan Cox wrote:
> > +	printk(KERN_WARNING "%s: watchdog expired - resetting system\n",
> > +	       wdt_gpi_name);
> > +
> > +	*(volatile char *) flagaddr |= 0x01;
> > +	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;
> > +	iob();
> > +	while (1) continue;
>
> cpu_relax();

I tried to find out about the purpose of cpu_relax(). On MIPS, at least,
it maps to barrier(). I do not quite understand why I would need a
barrier() in this place. Would you, or someone else, care to
enlighten me?

I am sending a revised patch in a separate mail.

Thomas
-- 
Thomas Koeller
thomas@koeller.dyndns.org
