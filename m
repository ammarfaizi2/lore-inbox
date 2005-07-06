Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVGFT6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVGFT6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGFT4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:15791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262102AbVGFPvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:51:32 -0400
Date: Wed, 6 Jul 2005 08:51:03 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
Message-ID: <20050706155103.GA13115@kroah.com>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <42CBA650.8080004@eyal.emu.id.au> <Pine.LNX.4.58.0507060837510.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507060837510.3570@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 08:42:16AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 6 Jul 2005, Eyal Lebedinsky wrote:
> >
> >   CC [M]  sound/pci/bt87x.o
> > sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
> > sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
> > sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
> > sound/pci/bt87x.c:807: error: for each function it appears in.)
> > sound/pci/bt87x.c: At top level:
> > sound/pci/bt87x.c:910: error: `driver' used prior to declaration
> 
> This seems to be a thinko by Greg. That line got changed from
> 
> 	supported = pci_match_device(snd_bt87x_ids, pci);
> 
> to
> 
> 	supported = pci_match_device(driver, pci);
> 
> but as far as I can tell it _should_ be
> 
> 	supported = pci_match_id(snd_bt87x_ids, pci);

No, I wanted it to be "driver", but forgot to build the code, sorry.
Try the following patch instead:

thanks,

greg k-h

-------------------

Fixes bt87x.c build problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/bt87x.c |    2 ++
 1 files changed, 2 insertions(+)

--- gregkh-2.6.orig/sound/pci/bt87x.c	2005-07-06 08:48:29.000000000 -0700
+++ gregkh-2.6/sound/pci/bt87x.c	2005-07-06 08:48:54.000000000 -0700
@@ -798,6 +798,8 @@
 	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
 };
 
+static struct pci_driver driver;
+
 /* return the rate of the card, or a negative value if it's blacklisted */
 static int __devinit snd_bt87x_detect_card(struct pci_dev *pci)
 {




