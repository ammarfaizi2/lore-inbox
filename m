Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269647AbUJMH3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbUJMH3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUJMH3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 03:29:31 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3468 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269647AbUJMH33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 03:29:29 -0400
Date: Wed, 13 Oct 2004 09:28:14 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Danny <dannydaemonic@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
Message-ID: <20041013072814.GA24066@electric-eye.fr.zoreil.com>
References: <9625752b041012230068619e68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9625752b041012230068619e68@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny <dannydaemonic@gmail.com> :
> This is with the network driver r8169 and linux-2.6.9-rc4-mm1.  Same
> thing happened with linux-2.6.9-rc3-mm3 (but also locked up). 
> linux-2.6.8.1-mm4 didn't seem to have this problem.  This is very
> repeatable, if this is an unknown issue let me know (CC please, not on
> the list) and I will jump through the hoops to get a useful oops.

Try the patch below (courtesy of Jon Mason, whitespaces may be wrong) and
see 1) if things perform better 2) if "timeout" messages appear in the
kernel log.

Oops as well as Cc: netdev@oss.sgi.com are welcome.

--- linux-2.6.9-rc4-mm1/drivers/net/r8169.c     2004-10-12 13:59:57.000000000 -0500
+++ linux-2.6.9-rc4-mm1/drivers/net/r8169.c     2004-10-12 10:51:21.000000000 -0500
@@ -1680,6 +1680,7 @@ static void rtl8169_unmap_tx_skb(struct

 	pci_unmap_single(pdev, le64_to_cpu(desc->addr), len, PCI_DMA_TODEVICE);
 	desc->opts2 = 0x00;
+	desc->opts1 = 0x00;
 	desc->addr = 0x00;
 	tx_skb->len = 0;
 }


