Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271330AbTGaEat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 00:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272373AbTGaEat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 00:30:49 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:26524 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S271330AbTGaEas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 00:30:48 -0400
Message-ID: <Pine.LNX.4.44.0307311003080.16619-100000@localhost.localdomain>
From: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-net@vger.kernel.org
Subject: Avoiding re-ordering in netif_rx()
Date: Thu, 31 Jul 2003 10:11:56 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am modifying linux kernel 2.4.18 to add support for our TCP offload 
card. The problem is:
The packets that I get from the card are fully TCP processed and
in-order. 
Now I feed these packets to netif_rx(). marking a flag in the skbuff
which 
says that the full TCP/IP processing is done on this packet and the
higher 
layers can just bypass the packet protocol  processing. On an SMP m/c 
different consequtive in-order packets received from the card can be 
queued to different per-cpu queues and it might so happen that the later

received packet is added to the socket receive queue first ( bcos the 
softirq on the later CPU got a chance to execute first). This
maliciously 
reorders the data.

My question is, what is an elegant way of avoiding this. I have a couple

of choices, but I want to know what people think. f.e one way is to
queue 
these packets to a single queue and not a per-cpu queue. In this case 
order will be honoured.

brilliant suggestions are very welcome !!

Thanx
tomar

-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

