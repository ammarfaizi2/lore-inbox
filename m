Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSHGOan>; Wed, 7 Aug 2002 10:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318160AbSHGOam>; Wed, 7 Aug 2002 10:30:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16856 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318132AbSHGOam>;
	Wed, 7 Aug 2002 10:30:42 -0400
Date: Wed, 07 Aug 2002 07:20:20 -0700 (PDT)
Message-Id: <20020807.072020.130694315.davem@redhat.com>
To: rkuhn@e18.physik.tu-muenchen.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208071613120.3705-100000@pc40.e18.physik.tu-muenchen.de>
References: <20020807.050329.92273054.davem@redhat.com>
	<Pine.LNX.4.44.0208071613120.3705-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
   Date: Wed, 7 Aug 2002 16:25:32 +0200 (CEST)
   
   The second change is straightforward, and I implemented the first by 
   setting
   
   *** around line 5569
           pci_read_config_dword(tp->pdev, TG3PCI_PCISTATE,
                                 &pci_state_reg);
   
   +       tp->tg3_flags |= TG3_FLAG_PCIX_TARGET_HWBUG; // rk
           if ((pci_state_reg & PCISTATE_CONV_PCI_MODE) == 0) {
                   tp->tg3_flags |= TG3_FLAG_PCIX_MODE;
   
   ***
   
   With these changes I'm unable to bring the interface up again, getting 
   timeouts from tg3_stop_block:

Try instead setting it right before the comment which reads:

        /* Quick sanity check.  Make sure we see an expected
         * value here.
         */

in tg3_get_invariants().
