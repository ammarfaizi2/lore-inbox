Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVI1Up2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVI1Up2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVI1Up2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:45:28 -0400
Received: from pop.gmx.de ([213.165.64.20]:29314 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750849AbVI1Up1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:45:27 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Wed, 28 Sep 2005 22:45:29 +0200
User-Agent: KMail/1.7.2
Cc: rjw@sisk.pl, torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282205.49316.daniel.ritz@gmx.ch> <20050928202314.54672E3723@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050928202314.54672E3723@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509282245.30410.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 22.23, David Brownell wrote:
> > > > > BTW, please have a look at:
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > > > > and
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> 
> What's with the bogus dates in those reports ... claiming some of you
> were testing 2.6.13-rc2-mm2 more than two months ago, mid-July ?????

hu? your point is?

> 
> 
> > > > interesting. i'd say we get interrupt storms from usb which then hurt when
> > > > yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> > > > irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> > > > and suspend-to-disk here. yes, restore too :)
> > > > 
> > > > could you give that a tree w/o any free_irq-patches for yenta and co?
> > > 
> > > I've tried and it apparently works provided that _none_ of the IRQ-sharing
> > > devices drops the IRQ on suspend.
> >
> > ok. i didn't look too close, but i think ohci-hcd does not fully disable
> > interrupts in it's suspend callback...needs a closer look.
> > cc:ing linux-usb-devel...
> 
> It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
> when they suspend.  Including OHCI.  Your diagnosis is incorrect.

would you be kind enough to tell me where?

my point is: the test patch i sent to rafael which comments out the
free_irq-on-suspend thing in hcd-pci.c shows that something is wrong with
USB (i think only OHCI. UHCI looks ok and about EHCI i have no data). 

> 
> - Dave
> 

rgds
-daniel
