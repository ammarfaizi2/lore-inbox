Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265756AbUF2NA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUF2NA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUF2NA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 09:00:29 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:34213 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S265756AbUF2NAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 09:00:25 -0400
Subject: pcnet32.c regression
From: Adrian Cox <adrian@humboldt.co.uk>
To: linux-kernel@vger.kernel.org
Cc: brazilnut@us.ibm.com
Content-Type: text/plain
Message-Id: <1088514023.923.126.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 14:00:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch v1.30e  11 Jun 2004 Don Fry recover after fifo error and rx hang.

Since this patch went in to pcnet32.c my diskless PowerPC boards with
AM79C793 ethernet controllers have stopped working.

The boards use the "ip=bootp root=/dev/nfs" option to mount the root
filesystem.The boot freezes after this message:
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
>From tcpdump on the server it seems that the board never transmits.

The cure for me is to revert the change at line 1089, back to:    
/* Set interrupt enable. */
    lp->a.write_csr (ioaddr, 0, 0x7940);
    lp->a.write_rap (ioaddr,rap);

- Adrian Cox
Humboldt Solutions Ltd.


