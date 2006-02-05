Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWBEOlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBEOlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWBEOlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:41:45 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:45451 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750851AbWBEOlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:41:44 -0500
Subject: Re: [PATCH, RFC] Driver for reading HP laptop LCD brightness
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060205143446.GA22494@srcf.ucam.org>
References: <20060205135517.GA21795@srcf.ucam.org>
	 <1139149647.3131.26.camel@laptopd505.fenrus.org>
	 <20060205143446.GA22494@srcf.ucam.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:41:42 +0100
Message-Id: <1139150502.3131.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 14:34 +0000, Matthew Garrett wrote:
> On Sun, Feb 05, 2006 at 03:27:26PM +0100, Arjan van de Ven wrote:
> 
> > disable_irq() and enable_irq() are really really evil. Are you sure you
> > need these? To me on first sight it looks like a bug (think of shared
> > interrupts for example), can you explain what you are trying to achieve
> > with these?
> 
> We're talking to the hardware directly. There's a potential race where 
> the BIOS will try to access the cmos at the same time, with potentially 
> interesting results (We set the address we want to read with the outb. 
> The BIOS runs, outbs its own address, and then reads. We then read from 
> the address the BIOS was looking at, rather than what we were looking 
> at).

.. and just disabling interrupts isn't going to work? Ok sure there is
an SMP issue, but a spinlock ought to be able to fix that properly,
instead of something this evil....


