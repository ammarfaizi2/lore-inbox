Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTH0KK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTH0KK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:10:56 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:60111 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263300AbTH0KKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:10:55 -0400
Date: Wed, 27 Aug 2003 12:10:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PM] double pci_set_power_state in 8139too
Message-ID: <20030827101033.GA1006@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This part of -test4 looks bogus:

@@ -2571,6 +2571,9 @@
        tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
        RTL_W32 (RxMissed, 0);

+       pci_save_state (pdev, tp->pci_state);
+       pci_set_power_state (pdev, 3);
+
        pci_set_power_state (pdev, 3);
        pci_save_state (pdev, tp->pci_state);


							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
