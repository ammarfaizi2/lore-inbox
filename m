Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752881AbWKBOEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbWKBOEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbWKBOEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:04:30 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:26067 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1752880AbWKBOE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:04:29 -0500
Date: Thu, 2 Nov 2006 14:04:51 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
       Thomas Koeller <thomas@koeller.dyndns.org>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sam Ravnborg <sam@ravnborg.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061102140450.GE16883@linux-mips.org>
References: <20061101184633.GA7056@infomag.infomag.iguana.be> <20061101221125.73505baa.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101221125.73505baa.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 10:11:25PM -0800, Randy Dunlap wrote:

> > 	wd_regs = ioremap_nocache(rr->start, rr->end + 1 - rr->start);
> > 	if (unlikely(!wd_regs))
> > 		return -ENOMEM;
> 
> There's no way to return the resources on failure?

MIPS drivers (and this one is specific to a particular MIPS SOC) are
generally a bit sloopy about checking of return values of ioremap because
ioremap is only doing some address arithmetic but no allocations that
actually could fail.  So for 64-bit kernels or addresses below 0x20000000
on a 32-bit system ioremap cannot fail.  In the same cases ioremap happens
to be a no-op because where nothing was allocated nothing needs to be
freed.

> > 			if (unlikely(__copy_from_user(&val, (const void __user *) arg,

Note to self, __copy_from_user and gang are generally assume to not
return an error so it might be a good idea to move that unlikely() into
the macro definitions.

  Ralf
