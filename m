Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264015AbTCXASU>; Sun, 23 Mar 2003 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264016AbTCXAST>; Sun, 23 Mar 2003 19:18:19 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:5516 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264015AbTCXASS>; Sun, 23 Mar 2003 19:18:18 -0500
Date: Sun, 23 Mar 2003 16:29:19 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] 1 potential double unlock error
In-Reply-To: <Pine.GSO.4.44.0303231506070.21702-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0303231627290.25487-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's in net/3c505.c. Please help us to confirm or clarify. Thanks.

Junfeng

[BUG] if timeouts, will double unlock

/home/junfeng/linux-2.5.63/drivers/net/3c505.c:467:send_pcb:
ERROR:LOCK:432:467:double unlock &(*adapter).lock[TRANS: &(*adapter).lock,
locked->unlocked, /home/junfeng/linux-2.5.63/drivers/net/3c505.c,
send_pcb, 446]

	set_hsf(dev, 0);

	if (send_pcb_slow(dev->base_addr, pcb->command))
		goto abort;

Start --->
	spin_lock_irqsave(&adapter->lock, flags);

	... DELETED 29 lines ...


	if (elp_debug >= 1)
		printk("%s: timeout waiting for PCB acknowledge (status
%02x)\n", dev->name, inb_status(dev->base_addr));

      sti_abort:
Error --->
	spin_unlock_irqrestore(&adapter->lock, flags);
      abort:
	adapter->send_pcb_semaphore = 0;
	return FALSE;


