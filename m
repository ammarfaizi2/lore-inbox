Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRH3VOh>; Thu, 30 Aug 2001 17:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272471AbRH3VO1>; Thu, 30 Aug 2001 17:14:27 -0400
Received: from ns.roland.net ([65.112.177.35]:28171 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S272472AbRH3VOO>;
	Thu, 30 Aug 2001 17:14:14 -0400
Message-ID: <3B8EAD25.20004@roland.net>
Date: Thu, 30 Aug 2001 16:16:21 -0500
From: Jim Roland <jroland@roland.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Moore <david@startbox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hang in yenta socket driver in 2.4.x w/ PCI->PCMCIA adapter
In-Reply-To: <Pine.LNX.4.30L2.0108301029270.26919-100000@luca.pas.lab>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it work (not lock-up) with your PC card removed?  Have you verified 
(beyond a shadow of a doubt) that nothing else is using IRQ5?

David Moore wrote:

>Hi, I'm using kernel 2.4.9, but have observed this problem with all 2.4.x
>kernels I've tried.  I have a PCI card with a single PCMCIA slot in it.
>It's has a TI Cardbus controller which is detected successfully and
>assigned IRQs without trouble.  I have also used it successfully with the
>pcmcia-cs modules and PCMCIA support not enabled in the main kernel
>sources.
>
>I get the following messages upon loading the pcmcia_core, yenta_socket,
>and ds modules:
>
>PCI: Enabling device 01:09.1 (0000 -> 0002)
>PCI: Enabling device 01:09.0 (0000 -> 0002)
>Yenta IRQ list 0000, PCI irq5
>Socket status: 30000010
>Yenta IRQ list 0000, PCI irq5
>Socket status: 30000006
>cs: socket c79bb800 timed out during reset.  Try increasing setup_delay.
>
>Then, immediately after I start the cardmgr daemon, the system hangs
>solidly (cannot switch consoles or scroll up).  Upon closer inspection,
>socket 0 is not attached to a physical PCMCIA slot, and is the one timing
>out above.  Socket 1 is the only real slot.  As a workaround, I modified
>cardmgr so that it only initializes socket 1, and avoids socket 0
>completely.  When I do this, everything works perfectly and I can use
>cards in the socket.  (It should be noted that the hang occurs even
>without any cards in the socket).  Also, I doubt this is an IRQ problem
>because irq 5 (assigned above) is not used by another device as reported
>by lspci.
>
>Since the pcmcia-cs modules work (even with kernel 2.4.x) I know that it's
>theoretically possible to have socket 0 fail gracefully rather than hang
>the system when it's initialized, even though it doesn't really exist.
>
>Any ideas how to fix this?
>
>I have attached the output when debugging is enabled in yenta_socket (this
>is with cardmgr loading the modules itself):
>
>cb_readl: c88c6740 0008 30001818
>exca_readb: c88c6740 0001 4c
>exca_readb: c88c6740 0003 50
>^-- these three lines repeat for a while....
>cb_readl: c88c6740 0008 30001818
>exca_readb: c88c6740 0001 4c
>exca_readb: c88c6740 0003 50
>cs: socket c79a3800 timed out during reset.  Try increasing setup_delay.
>cb_readl: c88c67c8 0008 30000086
>exca_readb: c88c67c8 0001 00
>exca_readb: c88c67c8 0003 50
>exca_writeb: c88c6740 0040 a0
>exca_writew: c88c6740 0010 0000
>exca_writew: c88c6740 0012 8000
>exca_writew: c88c6740 0014 4000
>exca_writeb: c88c6740 0006 01 <------------------- hangs here
>
>The last few lines look like they are from the mem_map function, but I'm
>not sure if the hang occurs immediately at this point, or is caused by
>code somewhere else.
>
>Thanks for the help.
>
>Best Regards,
>
>David Moore
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


