Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUKJXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUKJXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKJXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:20:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25298 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261178AbUKJXUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:20:47 -0500
Subject: Re: 2.6 vs 2.4: pxe booting system won't restart
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Jackson <notiggy@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <fb20c214041110123615f89230@mail.gmail.com>
References: <fb20c214041110103647fc6b51@mail.gmail.com>
	 <1100111849.20555.23.camel@localhost.localdomain>
	 <fb20c214041110123615f89230@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100124991.20794.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 22:16:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 20:36, Brian Jackson wrote:
> > Remove the kernel code that powers down the ethernet chip. If that works
> 
> Yay, looks like this bit near line 1950 of via-rhine.c:
> 	/* Hit power state D3 (sleep) */
> 	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
> 
> I removed that, and it works like a charm now. Thank you very much.

Excellent - its as I thought - the BIOS isn't bringing the chip out of
powersave for PXE but assumes it is live. Possibly one for a module
option but really it is a BIOS bug, although a very minor and easy to
understand how it got missed one

Alan

