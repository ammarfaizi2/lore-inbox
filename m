Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVFPVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVFPVfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFPVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:35:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26363 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261675AbVFPVfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:35:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
Date: Thu, 16 Jun 2005 23:32:01 +0200
User-Agent: KMail/1.7.2
Cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Andrew Morton <akpm@osdl.org>, David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0506161629220.3712@chaos.analogic.com> <Pine.LNX.4.62.0506162306300.2477@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506162306300.2477@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506162332.02655.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 16 Juni 2005 23:07, Jesper Juhl wrote:
> > 
> > Well long and int are the same size on ix86. What you really need
> > is 'size_t' for counters. That's the largest unsigned integer that
> > will fit in a register on the target platform. It is platform-
> > specific, therefore defined in stddef.h. No index or return-value
> > is supposed to be larger than what can be represented in size_t,
> > therefore it is a good type to use.
> > 
> > Note that on 64-bit platforms, size_t will be larger than an unsigned
> > int. This is good.
> > 
> Good info, thanks Richard.

Actually not that good. size_t is meant to represent the size of a structure
or array in units of characters. It also happens to be the same size as an
integer register on all architectures that Linux supports, just like unsigned
long.

The most common convention in the kernel is to use 'unsigned long' for
every integer that needs to be as large as possible without the overhead
of strict 64 bit types (like here), and also for integer values that need
to be the same size as a pointer.

OTOH size_t should be used only to count bytes, like in standard C usage.

	Arnd <><
