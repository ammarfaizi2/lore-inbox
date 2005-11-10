Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVKJNix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKJNix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVKJNix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:38:53 -0500
Received: from smtp.cce.hp.com ([161.114.21.24]:49804 "EHLO
	ccerelrim03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750868AbVKJNiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:38:52 -0500
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051110104419.GA20693@flint.arm.linux.org.uk>
References: <1131481677.8541.24.camel@tdi>
	 <20051108232316.GH13357@flint.arm.linux.org.uk>
	 <1131495392.9657.9.camel@tdi>
	 <20051110104419.GA20693@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: OSLO R&D
Date: Thu, 10 Nov 2005 06:38:36 -0700
Message-Id: <1131629916.4471.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.11.10.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 10:44 +0000, Russell King wrote:

> Ok, would you mind fixing the patch so it isn't screwing up the
> default use of up->timer please?  You may notice that this timer
> is already used, and overwriting up->timer.function is a one-way
> process in your patch (which kills off the point of serial8250_timeout).

   I return up->timer.function to serial8250_timeout in the polling mode
path of serial8250_startup().  The patch only makes use of up->timer
when it's not already being used for polling and will restore it on the
next startup if the UART is switched to polling.  Would you prefer that
I always set up->timer.function to serial8250_timeout on the shutdown
path?  Thanks,
	
	Alex

