Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWGSGMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWGSGMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGSGMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 02:12:10 -0400
Received: from outmx016.isp.belgacom.be ([195.238.4.115]:14317 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932510AbWGSGMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 02:12:08 -0400
Date: Wed, 19 Jul 2006 08:11:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nils Faerber <nils@kernelconcepts.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] Watchdog: i8xx_tco remove pci_find_device
Message-ID: <20060719061154.GA2438@infomag.infomag.iguana.be>
References: <20060719002225.85BFC201A1@srebbe.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719002225.85BFC201A1@srebbe.iguana.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Just back from a small holiday, but:

> Watchdog: i8xx_tco remove pci_find_device.
> 
> Use refcounting for pci device obtaining. Use PCI_DEVICE macro.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Why the pci_dev_put's? We aren't registering the PCI devices. See
the comment above the MODULE_DEVICE_TABLE:
/*
 * Data for PCI driver interface
 *
 * This data only exists for exporting the supported
 * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
 * register a pci_driver, because someone else might one day
 * want to register another driver on the same PCI id.
 */

Since the I/O controller Hub has several functions we explicitely
do not register the PCI device...

PS: In the -mm tree there is allready a replacement for this driver...
Plan is to get this one into linus tree soon.

Greetings,
Wim.

