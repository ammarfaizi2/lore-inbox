Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282981AbRLROMg>; Tue, 18 Dec 2001 09:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283267AbRLROMZ>; Tue, 18 Dec 2001 09:12:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:42667 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282981AbRLROMU>; Tue, 18 Dec 2001 09:12:20 -0500
Message-ID: <3C1F4C0E.7030704@vnet.ibm.com>
Date: Tue, 18 Dec 2001 08:00:46 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE dma reset for sl82c105
In-Reply-To: <3C1EB87C.7090103@chartermi.net> <20011218101630.C12774@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:


> Could you also get an lspci -v dump of the ISA bridge and the IDE function
> please?

  

  Bus  0, device  11, function  0:
    ISA bridge: Symphony Labs W83C553 (rev 16).
  Bus  0, device  11, function  1:
    IDE interface: Symphony Labs SL82c105 (rev 5).
      IRQ 31.
      Master Capable.  Latency=72.  Min Gnt=2.Max Lat=40.
      I/O at 0xe000000001100800 [0xe000000001100807].
      I/O at 0xe000000001100000 [0xe000000001100003].
      I/O at 0xe000000001100c00 [0xe000000001100c07].
      I/O at 0xe000000001100400 [0xe000000001100403].
      I/O at 0xe000000001101000 [0xe00000000110100f].
      I/O at 0xe000000001101400 [0xe00000000110140f].



> Does the Engineering notice give PCI INTC as a pre-condition?


Yes.  When bit 11 (LEGIRQ) of the IDE control/status register is set IDE 
IRQs are sent to INTC and/or INTD.  This is a pre-condition.  The 
problem is that the controller gets confused on an unfinished DMA and 
erroneously waits for ack on IRQA/B.


>>The patch should apply to 2.5.13 - 2.5.16 (at least).
>>
> 
> I think you mean 2.4.13 - 2.4.16 8)


No kidding.  A Monday I guess :(.

-todd

