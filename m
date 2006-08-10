Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWHJUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWHJUbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWHJUbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:31:17 -0400
Received: from science.horizon.com ([192.35.100.1]:22836 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751206AbWHJUbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:31:08 -0400
Date: 10 Aug 2006 16:31:06 -0400
Message-ID: <20060810203106.1476.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> For the ntp ignorami amongst us...  what is a "nanokernel reference
>>> implementation" and why do we want one?
> 
> It's the behaviour the current ntp daemon expects, the ntp documentation 
> has more information and a link to the package (e.g. under Debian at 
> /usr/share/doc/ntp-doc/html/kern.html).
>
> So...  the current kernel is behaving in a manner other than that which the
> NTP daemon expects?  Does this cause any problems?

To explain more clearly...

The original NTP kernel interface was defined in units of microseconds.
That's what Linux implements.  As computers have gotten faster and can
now split microseconds easily, a new kernel interface using nanosecond
units was defined ("the nanokernel", confusing as that name is to OS
hackers), and there's an STA_NANO bit in the adjtimex() status field to
tell the application which units it's using.

The current ntpd supports both, but Linux loses some possible timing
resolution because of quantization effects, and the ntpd hackers would
really like to be able to drop the backwards compatibility code.

Ulrich Windl has been maintaining a patch set to do the conversion for
years, but it's hard to keep in sync.
