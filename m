Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUFWPog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUFWPog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUFWPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:44:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23827 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264998AbUFWPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:44:34 -0400
Date: Wed, 23 Jun 2004 16:44:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matt Porter <mporter@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040623164419.E27549@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
	david-b@pacbell.net, joshua@joshuawise.com
References: <20040618122112.D3851@home.com> <20040618204322.C17516@flint.arm.linux.org.uk> <s5hoendm3td.wl@alsa2.suse.de> <20040622000838.B7802@flint.arm.linux.org.uk> <40D7941F.3020909@pobox.com> <Pine.LNX.4.58.0406212006270.6530@ppc970.osdl.org> <Pine.LNX.4.58.0406212024550.6530@ppc970.osdl.org> <s5hfz8nnadu.wl@alsa2.suse.de> <20040623133423.B27549@flint.arm.linux.org.uk> <s5hbrjajnfq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s5hbrjajnfq.wl@alsa2.suse.de>; from tiwai@suse.de on Wed, Jun 23, 2004 at 05:36:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 05:36:57PM +0200, Takashi Iwai wrote:
> > and a similar one for the ARM-specific "write combining" case (for
> > framebuffers utilising the DMA API)?
> 
> pgprot_noncached() is used on many other architectures in fbmem.c
> (well, not really, but the result is identical).
> Should it be provided as another one, or is it used as default in
> dma_mmap_coherent()?

The whole point is to kill the idea that drivers should have to know
about page protection crap.  That should be wholely contained within
the architecture implementation.

> Also, it would be nice to have a version for sg-buffer, too.

Well, we don't have a sg-buffer version of dma_alloc_coherent(),
so we don't have a sg-buffer version of dma_mmap_coherent().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
