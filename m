Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUFEXuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUFEXuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUFEXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:50:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:49837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262450AbUFEXuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:50:05 -0400
Date: Sat, 5 Jun 2004 16:50:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
In-Reply-To: <200406060141.09394.ktech@wanadoo.es>
Message-ID: <Pine.LNX.4.58.0406051646030.7010@ppc970.osdl.org>
References: <200406060141.09394.ktech@wanadoo.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Luis Miguel García Mancebo wrote:
> 
> I have not been able to make my ethernet card to work in post-2.6.6 kernels. 
> This is a nforce2 motherboard, and as Jeff pointed, nothing has changed in 
> the driver (forcedeth), and the problem could be acpi or routing in the 
> kernel. In fact, I have a "Disabling IRQ #11" message. Here is the dmesg:
> 
> P.S.: I have tested noapic, acpi=off, pci=noapic. But this doesn't fix 
> nothing.

Can you do a "diff" between the dmesg output of a working kernel, and a 
nonworking one? Also, please do the same with /proc/interrupts...

It sounds like your ethernet card is on irq11 (sharing it with USB), but 
that something has incorrectly decided that it must be somewhere else and 
then when the ethernet irq happens, it continually screams on irq11 until 
the kernel decides that it has to shut it up. At which point both ethernet 
and USB is dead (the former because it is on the wrong interrupt, the 
latter because the kernel had to shut up the irq that it was sharing in 
order to avoid endless irqs).

		Linus
