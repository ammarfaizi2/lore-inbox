Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278239AbRKGJmX>; Wed, 7 Nov 2001 04:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKGJmO>; Wed, 7 Nov 2001 04:42:14 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:27546 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S279233AbRKGJmE>;
	Wed, 7 Nov 2001 04:42:04 -0500
Date: Wed, 7 Nov 2001 10:40:44 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
Message-ID: <20011107104044.C11351@hazard.jcu.cz>
In-Reply-To: <20011106123427.A11351@hazard.jcu.cz> <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz> <23001.1005086449@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23001.1005086449@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

On Tue, Nov 06, 2001 at 10:40:49PM +0000, David Woodhouse wrote:
> 
> linux@hazard.jcu.cz said:
> >  The last message I got from kernel is:  request_irq: desc->handler->
> > startup(irq)
> 
> > Then problem is in the spin_unlock_irqrestore()???
> 
> > Any ideas, recomendations, suggestions?
> 
> It's dying in an IRQ storm. Something is permanently asserting IRQ 11, and 
> unless you can work out what's doing it and make it stop, the machine will 
> die whenever you enable that IRQ.
> 
> Try this hack, just to make sure:

Your hack is working for me. I got message:
"IRQ storm detected on IRQ 11. Disabling"

and everythink works OK. Spinlock was unlocked, procedure
setup_irq() ended and PCMCIA package works fine...

It is possible to add your patch to the kernel?

But I don't know, what device asserted IRQ 11 to start the IRQ
storm... When I was in the function setup_irq(), I installed the
first routine to work with IRQ 11 in its IRQ queue...

Or maybe will be safe to disable concrete IRQ, when is installed
a new handler for it?

I'm sorry, I'm not kernel programmer at all, I still thinking
about it... Maybe will be my think usefull for you...

> 
> --
> dwmw2

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
