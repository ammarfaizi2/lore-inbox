Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271643AbRIDNWL>; Tue, 4 Sep 2001 09:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271967AbRIDNWC>; Tue, 4 Sep 2001 09:22:02 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:8461 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271643AbRIDNVr>; Tue, 4 Sep 2001 09:21:47 -0400
Message-ID: <3B94D58B.180860A2@netvision.net.il>
Date: Tue, 04 Sep 2001 16:22:19 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Waugh <twaugh@redhat.com>
Subject: Re: lpr to HP laserjet stalls
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il> <20010904122751.S20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Tue, Sep 04, 2001 at 02:21:31PM +0300, Michael Ben-Gershon wrote:
> 
> For interrupt-driven mode: irq=auto dma=nofifo
> For PIO mode: irq=auto dma=none
> For DMA mode: irq=auto dma=auto
> 
> You need to check the 'dmesg' output after parport_pc has loaded to
> see exactly what it will use though (i.e. whether it has detected
> usable hardware).
> 
> The line that goes 'parport0: PC-style at 0x378 (0x778)' is the
> important one.  Ignore the stuff in [brackets] at the end; if an
> interrupt is mentioned it is using it; if a DMA channel is mentioned,
> it is using it; and if it says 'using FIFO' then it's using the FIFO
> with programmed IO (rather than DMA).


OK. Firstly I rebuilt the kernel (2.4.9) with CONFIG_PARPORT_PC_FIFO
enabled. I also configured the parallel driver to be a module, to enable
easier testing.

I found that whatever I did, printing was not stalled (this must be a
result of CONFIG_PARPORT_PC_FIFO).

However, I found that dmesg gave some strange messages every so often under
PIO and DMA modes.

	FIFO is stuck
	BUSY timeout
	dma write timed out

I don't know what they mean (the printing itself was not affected) but
I guess it would be better to avoid modes which give such messages.

At the moment I am loading the module with:

	insmod parport
	insmod parport_pc io=0x378,0xa800 irq=auto,auto dma=nofifo,nofifo

If there is anything more I should be doing, please let me know.

Thanks for all the help,

Michael Ben-Gershon
mybg@netvision.net.il
