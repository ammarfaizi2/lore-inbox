Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWBEOev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWBEOev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWBEOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:34:50 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:44972 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750820AbWBEOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:34:50 -0500
Date: Sun, 5 Feb 2006 14:34:46 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] Driver for reading HP laptop LCD brightness
Message-ID: <20060205143446.GA22494@srcf.ucam.org>
References: <20060205135517.GA21795@srcf.ucam.org> <1139149647.3131.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139149647.3131.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 03:27:26PM +0100, Arjan van de Ven wrote:

> disable_irq() and enable_irq() are really really evil. Are you sure you
> need these? To me on first sight it looks like a bug (think of shared
> interrupts for example), can you explain what you are trying to achieve
> with these?

We're talking to the hardware directly. There's a potential race where 
the BIOS will try to access the cmos at the same time, with potentially 
interesting results (We set the address we want to read with the outb. 
The BIOS runs, outbs its own address, and then reads. We then read from 
the address the BIOS was looking at, rather than what we were looking 
at).

On all the hardware this will run on, IRQ 8 is the RTC. I don't believe 
it can share interrupts.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
