Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSHGOqe>; Wed, 7 Aug 2002 10:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSHGOqd>; Wed, 7 Aug 2002 10:46:33 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:24837 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318691AbSHGOqd>; Wed, 7 Aug 2002 10:46:33 -0400
Date: Wed, 7 Aug 2002 16:49:24 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020807.072020.130694315.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208071646570.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David S. Miller wrote:

>    From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
>    Date: Wed, 7 Aug 2002 16:25:32 +0200 (CEST)
>    
>    The second change is straightforward, and I implemented the first by 
>    setting
>    
>    *** around line 5569
>            pci_read_config_dword(tp->pdev, TG3PCI_PCISTATE,
>                                  &pci_state_reg);
>    
>    +       tp->tg3_flags |= TG3_FLAG_PCIX_TARGET_HWBUG; // rk
>            if ((pci_state_reg & PCISTATE_CONV_PCI_MODE) == 0) {
>                    tp->tg3_flags |= TG3_FLAG_PCIX_MODE;
>    
>    ***
>    
>    With these changes I'm unable to bring the interface up again, getting 
>    timeouts from tg3_stop_block:
> 
> Try instead setting it right before the comment which reads:
> 
>         /* Quick sanity check.  Make sure we see an expected
>          * value here.
>          */
> 
> in tg3_get_invariants().
> 
Sorry, same problem as before. It looks like the spinlocked write method 
does not work on the BCM5701 chip :-(

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

