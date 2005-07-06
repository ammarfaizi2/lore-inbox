Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVGGAXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVGGAXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVGFUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:34510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262370AbVGFQnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:43:19 -0400
Date: Wed, 6 Jul 2005 09:43:15 -0700
From: Greg KH <greg@kroah.com>
To: Ben Castricum <benc@bencastricum.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc2 Compile error in bt87x.c
Message-ID: <20050706164315.GA14165@kroah.com>
References: <Pine.LNX.4.58.0507061342100.4612@gateway.bencastricum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507061342100.4612@gateway.bencastricum.nl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 01:44:05PM +0200, Ben Castricum wrote:
> 
>   CC [M]  sound/pci/bt87x.o
> sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
> sound/pci/bt87x.c:807: `driver' undeclared (first use in this function)
> sound/pci/bt87x.c:807: (Each undeclared identifier is reported only once
> sound/pci/bt87x.c:807: for each function it appears in.)
> sound/pci/bt87x.c: At top level:
> sound/pci/bt87x.c:910: `driver' used prior to declaration
> make[2]: *** [sound/pci/bt87x.o] Error 1
> make[1]: *** [sound/pci] Error 2
> make: *** [sound] Error 2
> 
> My .config can be found at http://www.bencastricum.nl/.config

Try this, already-posted patch.

thanks,

greg k-h


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
