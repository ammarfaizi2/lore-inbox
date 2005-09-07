Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVIGURx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVIGURx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIGURx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:17:53 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:44763 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S932211AbVIGURw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:17:52 -0400
Subject: Re: 8250_hp300: initialisation ordering bug
From: Kars de Jong <jongk@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050904111901.A30509@flint.arm.linux.org.uk>
References: <20050904111901.A30509@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 22:17:49 +0200
Message-Id: <1126124269.3968.5.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On zo, 2005-09-04 at 11:19 +0100, Russell King wrote:
> Hi,
> 
> I've noticed that 8250_hp300 is buggy wrt the ordering of hardware
> initialisation to the visibility of devices to user space.  Namely,
> 8250_hp300 does the following:
> 
> ...

> serial8250_register_port() makes the port visible to userspace, so
> from that point on it could be opened.  However, if it's opened
> prior to the remainder of the above completing, we will be missing
> interrupts (and what effect does "reset the DCA" have?)
> 
> Surely this hardware fiddling should be completed before we register
> the port?

Yes, you are right. I am working on rewriting the driver a bit to use a
platform device for the APCI driver, I'll take your bug report into
account as well.

On a related note: can I use the "serial8250" platform driver also for
non-ISA devices (like my APCI platform device)? The comments in
drivers/serial/8250.c suggest it's for ISA devices only, but I don't see
a particular reason for not using it for my APCI devices.


Kind regards,

Kars.


