Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030837AbWKOSyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030837AbWKOSyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030868AbWKOSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:54:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030837AbWKOSyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:54:17 -0500
Date: Wed, 15 Nov 2006 10:51:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Arjan van de Ven <arjan@infradead.org>, Takashi Iwai <tiwai@suse.de>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <455B5F01.7020601@garzik.org>
Message-ID: <Pine.LNX.4.64.0611151046410.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> 
 <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>
  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
 <1163607889.31358.132.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org> <455B5F01.7020601@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Jeff Garzik wrote:
> 
> > And btw, I say this as a person whose new main machine used to have HDA
> > routed over MSI, and the decision to default to it off meant that it went
> > back to the regular INTx thing.
> 
> Yeah, but you don't care if that happens, so this is an ineffective 'btw'
> It's not like you went to sleep crying over the loss, like I did [just
> kidding!]

Heh. I'm really hoping that nobody will cry themselves to sleep over MSI 
not being enabled..

> > (Btw, MSI interrupts also seem to not participate in CPU balancing:
> > 
> >  22:      41556      43005   IO-APIC-fasteoi   HDA Intel
> > 506:     110417          0   PCI-MSI-edge      eth0
> > 
> > which is another semantic change introduced by using MSI)
> 
> No, that's most likely because ethernet is always intentionally locked to a
> single CPU by irqbalance.

Nope, the same thing happened to "HDA Intel" when it was an MSI interrupt 
(ie before I applied the change that made it not use MSI by default).

So I think it's either: (a) irqbalance doesn't balance MSI interrupts at 
all or (b) the MSI interrupt code doesn't honor balancing requests even if 
it does.

I didn't look any closer. It's not like it's a huge problem for me (or 
likely for anybody else), but it was interesting to see another 
"unintended consequence" of the "use MSI or not" choice.

The suspend problem reported by Stephen is another such thing - where MSI 
itself wasn't a problem, but stupid (probably broken) firmware code at 
wakeup broke it by an unforseen interaction. Again, that is probably 
related to the fact that nobody has ever really tested it (ie firmware 
"engineers" obviously didn't actually ever test anything with MSI enabled 
and in use, and there really is no excuse for firmware messing with the 
MSI setting - other than the usual "firmware is inevitably buggy" thing).

			Linus
