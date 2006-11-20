Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934067AbWKTLzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934067AbWKTLzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934068AbWKTLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:55:13 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31670 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S934067AbWKTLzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:55:12 -0500
Date: Mon, 20 Nov 2006 12:54:32 +0100 (MET)
From: Stefan Roese <ml@stefan-roese.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
References: <200611201200.36780.ml@stefan-roese.de> <20061120114248.60bb0869@localhost.localdomain>
In-Reply-To: <20061120114248.60bb0869@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201255.37754.ml@stefan-roese.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 12:42, Alan wrote:
> On Mon, 20 Nov 2006 12:00:36 +0100
>
> Stefan Roese <ml@stefan-roese.de> wrote:
> > This patch fixes a problem seen on multiple 4xx platforms, where
> > the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> > on those systems to not use an real interrupt but the timer based
> > implementation.
>
> NAK.

I knew it. ;-)

> Zero means "no interrupt" in the Linux space. If you have a physical IRQ
> 0 remap it to a convenient number (eg map IRQ's + 1, or stick it on the
> end). The logical and physical IRQ numbering in Linux don't have to match
> up - and given some platforms have IRQ numbering per bus and the like
> clearly doesn't in many cases.

Let's see, if I got this right. You mean that on such a platform, where 0 is a 
valid physical IRQ, we should assign another value as virtual IRQ number (not 
0 and not -1 of course). And then the platform "pic" implementation should 
take care of the remapping of these virtual IRQ numbers to the physical 
numbers.

Correct?

Best regards,
Stefan
