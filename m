Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275363AbTHGOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275353AbTHGOjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:39:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22800 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275359AbTHGOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:39:01 -0400
Date: Thu, 7 Aug 2003 15:38:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tim Small <tim@buttersideup.com>, Pavel Roskin <proski@gnu.org>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI yenta-alikes
Message-ID: <20030807153857.C27489@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tim Small <tim@buttersideup.com>, Pavel Roskin <proski@gnu.org>,
	linux-pcmcia@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com> <20030807100211.A17690@flint.arm.linux.org.uk> <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk> <3F324DDE.3040409@buttersideup.com> <20030807141650.C25908@flint.arm.linux.org.uk> <1060264823.3123.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060264823.3123.53.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 07, 2003 at 03:00:23PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 03:00:23PM +0100, Alan Cox wrote:
> On Iau, 2003-08-07 at 14:16, Russell King wrote:
> > You can do what you're suggesting as long as you take account of the
> > device itself.  However, once you've decided the device isn't setup,
> > how can the kernel determine exactly what the _correct_ setup of the
> > device is?  You can't say "well, its a PCI1031 device, therefore I'll
> > select ISA interrupt mode" because you don't know if it has been
> > wired up that way.
> 
> Subvendor id I guess - and some kind of heuristic for uninitialized plugin
> cards (my guess is "PCI" if it was hotplugged). 

Hopefully, but I'm not holding out that much hope for the subvendor
stuff to be correctly initialised.

At least now we have a way to find out - as of last night, Linus' 
kernel will now displaying the subvendor and subdevice information
while it probes the hardware, and it has the tweaks to IRQMUX and
the the other PCI only IRQ hack disabled.  This, along with the
PNP fix from Adam should solve all the IRQ problems people have
been recently seeing.

Those which remain should be the result of missing or incorrect setup
of the multi-function pins on the cardbus bridge, and I'm hoping to
receive reports from people with cardbus sockets needing some kind of
fixing up - and these should come with the subvendor/device information
readily available. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

