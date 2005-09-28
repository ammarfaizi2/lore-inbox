Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVI1VrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVI1VrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVI1VrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:47:08 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:40151 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750989AbVI1VrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:47:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Wed, 28 Sep 2005 23:47:29 +0200
User-Agent: KMail/1.8.2
Cc: daniel.ritz@gmx.ch, torvalds@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282245.30410.daniel.ritz@gmx.ch> <20050928210717.5CF71E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050928210717.5CF71E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509282347.30586.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 28 of September 2005 23:07, David Brownell wrote:
> > > > ok. i didn't look too close, but i think ohci-hcd does not fully disable
> > > > interrupts in it's suspend callback...needs a closer look.
> > > > cc:ing linux-usb-devel...
> > > 
> > > It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
> > > when they suspend.  Including OHCI.  Your diagnosis is incorrect.
> >
> > would you be kind enough to tell me where?
> 
> There's only one free_irq() line, and it gets called the first time
> through usb_hcd_pci_suspend().  QED.
> 
> 
> > my point is: the test patch i sent to rafael which comments out the
> > free_irq-on-suspend thing in hcd-pci.c shows that something is wrong with
> > USB (i think only OHCI. UHCI looks ok and about EHCI i have no data). 
> 
> Your logic escapes me, since your patch affected all three PCI HCDs.
> If that's wrong for one, its wrong for all three.
> 
> And as I just commented to Rafael, here are two better things to try
> instead of believing a diagnosis that's clearly wrong:
> 
>   - 2.6.14-rc2

This one works obviously, as it contains the patch that adds acpi_pci_link_resume()
(http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/2234.html).  The patch is
not present in -mm though, AFAIK, so I can test the latest one, if you want me to,
but I think it won't work.

Greetings,
Rafael
