Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbTIIDla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 23:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbTIIDla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 23:41:30 -0400
Received: from tank.questzones.com ([207.253.48.35]:4612 "EHLO
	tank2.questzones.com") by vger.kernel.org with ESMTP
	id S263916AbTIIDl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 23:41:28 -0400
Message-ID: <003a01c37684$121088e0$8000a8c0@elbasta>
From: "Frederic Trudeau" <ftrudeau@zesolution.com>
To: "Feldman, Scott" <scott.feldman@intel.com>, <linux-kernel@vger.kernel.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E01022294A8@orsmsx402.jf.intel.com>
Subject: Re: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel NULL pointer dereference at virtual address 00000000)
Date: Mon, 8 Sep 2003 23:40:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Scoot. Im no kernel hacker, so please tell me again what I must do.
Grab the latest e1000 drivers ? From where ?

Thanks

----- Original Message ----- 
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Frederic Trudeau" <ftrudeau@zesolution.com>;
<linux-kernel@vger.kernel.org>
Sent: Monday, September 08, 2003 8:51 PM
Subject: RE: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle
kernel NULL pointer dereference at virtual address 00000000)


> >>EIP; f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====
>
> >>ecx; 00031988 Before first symbol
> >>edx; f770b980 <_end+3728d080/3838e760>
> >>esp; f54a1e98 <_end+35023598/3838e760>
>
> Trace; f8b051dd <[e1000]e1000_free_rx_resources+1d/70>
> Trace; f8b04a26 <[e1000]e1000_open+46/60>

Fix in newer e1000 drivers.  Your failing request_irq().  Need to remove
some code in e1000_up so we don't try to free resources twice:

        if(request_irq(netdev->irq, &e1000_intr, SA_SHIRQ |
SA_SAMPLE_RANDOM,
                       netdev->name, netdev)) {
-               e1000_reset_hw(&adapter->hw);
-               e1000_free_tx_resources(adapter);
-               e1000_free_rx_resources(adapter);
                return -1;
        }

-scott


