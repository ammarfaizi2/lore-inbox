Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWEORgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWEORgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWEORgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:36:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38039 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751578AbWEORgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:36:31 -0400
Subject: Re: Linux v2.6.17-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 18:49:16 +0100
Message-Id: <1147715356.26686.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 16:44 -0700, Linus Torvalds wrote:
> Ok, I've let the release time between -rc's slide a bit too much again, 
> but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> 
> If you know of any regressions, please holler now, so that we don't miss 
> them. 

PCMCIA is the obvious one I'm hitting here. The pcmcia core code as well
as being somewhat unreadable will happily hand out shared IRQs to
drivers that ask for an exclusive one leading to setup_irq errors and
non-working devices.

The main problem seems to be that the kernel will hand back the shared
PCI IRQ for a pcmcia port even when ExclusiveIRQ is requested. I've got
a patch here to clean this up a bit, but it changes the API to pass back
the fact the available IRQ is shared rather than force it, so may not be
a good candidate close to 2.6.17

