Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWDXRQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWDXRQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWDXRQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:16:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750978AbWDXRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:16:44 -0400
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       Matthew Reppert <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org>
References: <1145851361.3375.20.camel@minerva>
	 <20060423222122.498a3dd2.akpm@osdl.org>
	 <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie>
	 <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 19:16:33 +0200
Message-Id: <1145898993.3116.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 10:07 -0700, Linus Torvalds wrote:
> 
> On Mon, 24 Apr 2006, Dave Airlie wrote:
> > 
> > however not doing pci_enable_device causes interrupts to not work on the cards
> > in a lot of circumstances..
> 
> Well, you could use "pci_enable_device_bars(0)" instead.
> 
> That will set up interrupt routing _without_ enabling any BAR's, however, 
> that's probably crazy too, since that means that if an interrupt happens, 
> you're really really screwed and can't do anything about it. So that's 
> probably even more broken than what you do now.
> 
> How about delaying the "pci_enable_device()" until when you actually need 
> it, ie do it in drm_irq_install() instead?
> 
> Of course, I wonder how you could POST the device without having the BAR's 
> enabled, 

you haven't spent enough time reading the X pci code then ;)
(or rather, you've done the same thing but hey who's counting)

X does all that *itself* based on what X thinks is best.

Yes that's silly and X should be taken out and shot for that.
What's worse, this is the kind of thing that is really hard to work
around in a away that isn't going to make having a fixed X work as
well... you can't not enable it for old X and enable it for not-insane X
at the same time ;)

