Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292530AbSCDREq>; Mon, 4 Mar 2002 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSCDREi>; Mon, 4 Mar 2002 12:04:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292530AbSCDRES>;
	Mon, 4 Mar 2002 12:04:18 -0500
Message-ID: <3C83A925.F93BF448@mandrakesoft.com>
Date: Mon, 04 Mar 2002 12:04:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
> 
>   Jeff,
> 
>         I have a feeling you're talking about this section:
> 
> >  pci_write_config_byte (pdev, PCI_CACHE_LINE_SIZE, cls);
> >  pci_read_config_word (pdev, PCI_COMMAND, &pcr);
> >
> >  /* Turn off Fast B2B enable */
> >  pcr &= ~PCI_COMMAND_FAST_BACK;
> >  /* Turn on SERR# enable and others */
> >  pcr |= (PCI_COMMAND_SERR | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
> >          PCI_COMMAND_IO   | PCI_COMMAND_MEMORY);
> >
> >  pci_write_config_word (pdev, PCI_COMMAND, pcr);
> >  pci_read_config_word (pdev, PCI_COMMAND, &pcr);
> 
>   Basically, this section exists from a time when I had no idea why the
> card was behaving badly, so I was trying everything :-).
> 
>   So, after revisiting them, I see that setting cache line size to 0 and
> then using memory write and invalidate doesn't make any sense.  I'm thinking
> both can just be dropped, since I haven't seen any change in performance on
> the machines I've made netperf runs with (a constant 14.7 Mb/s) after
> changing these.

I agree to the first part :)

Set cache line size just like drivers/net/acenic.c does, and enable
memory-write-invalidate...

	Jeff


-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
