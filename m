Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVHIV74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVHIV74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHIV74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:59:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:59067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964991AbVHIV74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:59:56 -0400
Date: Tue, 9 Aug 2005 14:56:39 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
Message-ID: <20050809215638.GC22683@kroah.com>
References: <42F73523.80205@gmail.com> <200508082355.j78NtGNS029681@wscnet.wsc.cz> <20050808233429.36e6ebd5.akpm@osdl.org> <42F87730.5030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F87730.5030804@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:28:16AM +0200, Jiri Slaby wrote:
> Andrew Morton napsal(a):
> 
> >Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >
> >>--- a/drivers/char/watchdog/i6300esb.c
> >>+++ b/drivers/char/watchdog/i6300esb.c
> >>@@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
> >>          *      Find the PCI device
> >>          */
> >> 
> >>-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != 
> >>NULL) {
> >>+        for_each_pci_dev(dev)
> >>                 if (pci_match_id(esb_pci_tbl, dev)) {
> >>                         esb_pci = dev;
> >>                         break;
> >>                 }
> >>-        }
> >> 
> >>         if (esb_pci) {
> >>         	if (pci_enable_device(esb_pci)) {
> >>@@ -430,6 +429,7 @@ err_release:
> >> 		pci_release_region(esb_pci, 0);
> >> err_disable:
> >> 		pci_disable_device(esb_pci);
> >>+		pci_dev_put(esb_pci);
> >>   
> >>
> >
> >That doesn't look right.  Each iteration of for_each_pci_dev() needs a
> >pci_dev_put(), not just the final one.

Not true, see the documentation for pci_get_device(), it's only required
if you break out of the loop.

thanks,

greg k-h
