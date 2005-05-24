Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVEXRMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVEXRMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEXQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:59:42 -0400
Received: from diadema.skane.tbv.se ([193.13.139.13]:14055 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261349AbVEXQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:53:42 -0400
From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Date: Tue, 24 May 2005 18:53:39 +0200
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: raw@dslr.net
Subject: clock drift with 2x Promise Ultra133 TX2 (PDC 20269) (again)
Message-ID: <20050524165339.GA16577@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "diadema.skane.tbv.se", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Problem: I have two Promise Ultra133 TX2 (PDC 20269)
	cards, each with two Maxtor UDMA133 hard drives connected. The system
	also has another hard drive connected to the motherboard. A total of
	five drives. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
I have two Promise Ultra133 TX2 (PDC 20269) cards, each with two
Maxtor UDMA133 hard drives connected. The system also has another
hard drive connected to the motherboard. A total of five drives.

When I concurrently read from two hard drives connected to
different Promise cards, there is heavy software clock drift.
The software clock runs too fast - approx. a few seconds per
minute during this i/o. To reproduce:

  hwclock --hctosys
  hwclock --show
  date
  dd if=/dev/hde of=/dev/null bs=1M count=7200 &
  dd if=/dev/hdi of=/dev/null bs=1M count=7200 &
  wait
  wait
  hwclock --show
  date

This doesn't happen if I read from two drives connected to the
same card, or one drive connected to the motherboard and one
connected to a Promise card.

I've removed all other PCI devices in the system - problem remains.
I tried different motherboards:

  Asus A7V266-C with AMD AthlonXP 2000+ (i686) - problem occurs
  Asus A7V600-X with AMD Sempron 2600+  (i686) - problem occurs
  Abit KV8 Pro  with AMD Athlon64 3000+ (i686) - problem does not occur!

So what makes the Abit motherboard different?

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
