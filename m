Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWEJN5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWEJN5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWEJN5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:57:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34695 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964964AbWEJN47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:56:59 -0400
Subject: Re: Updated libata PATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 15:09:05 +0100
Message-Id: <1147270145.17886.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 21:48 -0400, Kevin Radloff wrote:
> ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
> setup_irq: irq handler mismatch

Ok so we got an interrupt this time and then when we asked for it got
told "no". That still shouldn't crash but there are some lurking
problems when ata_device_add fails.

More interesting is how it can occur.

We asked for an IRQ that was "exclusive". We got given IRQ 11 which was
shared. A look at the pcmcia code suggests the new drivers/pcmcia code
is broken here: It may fall back to using an interrupt line that is
shared even when told not to.

What occurs if you change

	ae.irq_flags = 0;

to 

	ae.irq_flags = SA_SHIRQ ?

Alan

