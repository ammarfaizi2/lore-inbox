Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292515AbSCDQxO>; Mon, 4 Mar 2002 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292516AbSCDQxF>; Mon, 4 Mar 2002 11:53:05 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:58565 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292508AbSCDQwy>; Mon, 4 Mar 2002 11:52:54 -0500
Date: Mon, 4 Mar 2002 10:51:22 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <3C6E3E8C.13E2755A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Jeff,

	I have a feeling you're talking about this section:

>  pci_write_config_byte (pdev, PCI_CACHE_LINE_SIZE, cls);
>  pci_read_config_word (pdev, PCI_COMMAND, &pcr);
>
>  /* Turn off Fast B2B enable */
>  pcr &= ~PCI_COMMAND_FAST_BACK;
>  /* Turn on SERR# enable and others */
>  pcr |= (PCI_COMMAND_SERR | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
>          PCI_COMMAND_IO   | PCI_COMMAND_MEMORY);
>
>  pci_write_config_word (pdev, PCI_COMMAND, pcr);
>  pci_read_config_word (pdev, PCI_COMMAND, &pcr);

  Basically, this section exists from a time when I had no idea why the
card was behaving badly, so I was trying everything :-).

  So, after revisiting them, I see that setting cache line size to 0 and
then using memory write and invalidate doesn't make any sense.  I'm thinking 
both can just be dropped, since I haven't seen any change in performance on 
the machines I've made netperf runs with (a constant 14.7 Mb/s) after 
changing these.

  Any thoughts?

Kent

Thus Spake Jeff Garzik:

>Sorry I've been slow to respond... I'm going to apply your driver
>locally, so you and I have a good baseline to work with, but there are
>some small issues related to PCI initialization that I want to review
>and discuss with you, before submitting officially to Marcelo...
>
>(another message should follow during the upcoming work week)
>
>Regards,
>
>	Jeff
>
>
>

