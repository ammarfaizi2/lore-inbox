Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbQLYRRc>; Mon, 25 Dec 2000 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQLYRRX>; Mon, 25 Dec 2000 12:17:23 -0500
Received: from colorfullife.com ([216.156.138.34]:34830 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129799AbQLYRRF>;
	Mon, 25 Dec 2000 12:17:05 -0500
Message-ID: <3A477AF3.E76A8083@colorfullife.com>
Date: Mon, 25 Dec 2000 17:50:59 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: alex.buell@tahallah.clara.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Netgear FA311
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex wrote:
> In the logs I'm seeing this: 
> 
> Dec 25 15:25:18 tahallah last message repeated 2 times 
> Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0783. 
> Dec 25 15:25:19 tahallah kernel: eth0: Something Wicked happened! 0780. 

783 means:
	Tx Underrun
	Tx Idle
	Tx Packet Error
	Tx Descriptor
	Rx Packet Error
	Rx Descriptor
	Rx OK.

Hmm. I download the Documentation from National
(http://www.national.com/pf/DP/DP83815.html),
and the the tx burst size/fill threshold/drain threshold combination is
invalid:

<<<<<<<< from natsemi.c:
 /* Configure the PCI bus bursts and FIFO thresholds. */
 /* Configure for standard, in-spec Ethernet. */
 np->tx_config = (1<<28) +       /* Automatic transmit padding */
             (1<<23) +       /* Excessive collision retry */
             (0x0<<20) +     /* Max DMA burst = 512 byte */
             (8<<8) +        /* fill threshold = 256 byte */
             2;              /* drain threshold = 64 byte */
 writel(np->tx_config, ioaddr + TxConfig);
>>>>>>>>>>>>

But:
<<<<<<<< page 51
The MXDMA MUST NOT be greater than the Tx Fill Threshold 
>>>>>>>>>>

Could you try this setup?
<<<<<<<<
 /* Configure the PCI bus bursts and FIFO thresholds. */
 /* Configure for standard, in-spec Ethernet. */
 np->tx_config = (1<<28) +       /* Automatic transmit padding */
             (1<<23) +       /* Excessive collision retry */
             (6<<20) +     /* Max DMA burst = 128 byte */
             (8<<8) +        /* fill threshold = 256 byte */
             8;              /* drain threshold = 256 byte */
 writel(np->tx_config, ioaddr + TxConfig);
>>>>>>>>

--
  Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
