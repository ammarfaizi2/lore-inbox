Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSCCVQo>; Sun, 3 Mar 2002 16:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSCCVQf>; Sun, 3 Mar 2002 16:16:35 -0500
Received: from smtp02.web.de ([217.72.192.151]:2332 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S288557AbSCCVQX>;
	Sun, 3 Mar 2002 16:16:23 -0500
Message-ID: <3C82929B.48E5E77A@web.de>
Date: Sun, 03 Mar 2002 22:16:11 +0100
From: Ulrich Hahn <ulrich.hahn@web.de>
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: en-US,de
MIME-Version: 1.0
To: Charles Briscoe-Smith <charles@briscoe-smith.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA-related IDE problems - "hda: lost interrupt"
In-Reply-To: <20020302122339.A31436@merry.bs.lan>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there -

I was lucky today finding another solution that helped me out:

It seems the 2.4 kernel series produce the problem of messing with PCI
interrupts.
I had no problem with one and the same pcmcia_cs package with a 2.2.9 kernel
which locked up ALL of the 2.4 kernels I tried meanwile (I am on 2.4.18 now
using the kernel-owned pcmcia modules, yenta_socket, which does not seem to know
any parameters at all).

Today I found a hint on giving the kernel an irqmask on bootup in the lilo.conf
file:
append="pci=irqmask=0xafff"

This prevents the vital IRQs of ide or mouse from being taken by the PCI bridge
when the yenta_socket or i82365 module is loaded. (Unloading the module again
would  not give back interrupt control - so a reboot was the final step)

Charles Briscoe-Smith wrote:

> > Personal question: did you find a solution?
>
> Yes, I did, and it has since been documented in the PCMCIA HOWTO,
> section 2.3, subsection "Card readers for desktop systems":
>
>   For Chase CardPORT and Altec ISA card readers using the Cirrus PD6722
>   ISA-to-PCMCIA bridge, the i82365 driver should be loaded with a
>   ``has_ring=0'' parameter to prevent irq 15 conflicts.
>
> I had been trying the option "has_ring=1", which I didn't know was
> the default.
>
> [ CC'ed linux-kernel so that this gets into its archives.  I am not on
> linux-kernel so, if replying, please CC me (and, I presume, Ulrich). ]

Thanks for your hint!


