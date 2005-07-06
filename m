Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVGFT6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVGFT6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVGFT4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262127AbVGFPmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:42:25 -0400
Date: Wed, 6 Jul 2005 08:42:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Matthias Andree <matthias.andree@gmx.de>, Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
In-Reply-To: <42CBA650.8080004@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.58.0507060837510.3570@g5.osdl.org>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
 <42CBA650.8080004@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Eyal Lebedinsky wrote:
>
>   CC [M]  sound/pci/bt87x.o
> sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
> sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
> sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
> sound/pci/bt87x.c:807: error: for each function it appears in.)
> sound/pci/bt87x.c: At top level:
> sound/pci/bt87x.c:910: error: `driver' used prior to declaration

This seems to be a thinko by Greg. That line got changed from

	supported = pci_match_device(snd_bt87x_ids, pci);

to

	supported = pci_match_device(driver, pci);

but as far as I can tell it _should_ be

	supported = pci_match_id(snd_bt87x_ids, pci);

does that fix it for you?

		Linus

