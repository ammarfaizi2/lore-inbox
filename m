Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUJYGiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUJYGiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUJYGiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:38:16 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:45498 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261688AbUJYGhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:37:45 -0400
Date: Mon, 25 Oct 2004 08:37:37 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Subject: Small bug in e100?
Message-Id: <Pine.OSF.4.05.10410250836490.22917-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am getting a warning - with a stack trace - from the e100
ethernet device when I do ifup eth0 when I use it on  Igno's real-time
branch. I do think, however, it is a general bug but I am not sure.
The problem is the call to enable_irq() just after request_irq() (see
below). As far as I can read from request_irq()/setup_irq()
in manage.c the irq is already being enabled in setup_irq()? If so the
enable_irq() line below ought to go.

Esben

>From drivers/net/e100.c:
...
        if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
                nic->netdev->name, nic->netdev)))
                goto err_no_irq;
        e100_enable_irq(nic);
->      enable_irq(nic->pdev->irq);
        netif_wake_queue(nic->netdev);
...


