Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUIAUqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUIAUqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIAUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:44:10 -0400
Received: from smtp20.libero.it ([193.70.192.147]:59382 "EHLO smtp20.libero.it")
	by vger.kernel.org with ESMTP id S267599AbUIAUmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:42:50 -0400
From: Gaetano Sferra <gaesferr@libero.it>
To: linux-kernel@vger.kernel.org
Subject: EHCI errors in 2.6.8 (could be a patch mistake)
Date: Wed, 1 Sep 2004 22:43:08 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
X-PRIORITY: 2 (High)
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409012243.08245.gaesferr@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all,
please, read carefully:

I've patched my fully working 2.6.7 kernel to the 2.6.8 and I got these errors 
at boot time (no errors during patch and compilation using the same config of 
the 2.6.7 kernel):

ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95

In this condition the hotplugging of USB devices doesn't work at all!
The host controller is an Intel Corp. 82801DB (ICH4) USB2 EHCI and it fully 
work with the 2.6.7. Looking into the patched and original code of the 
ehci-hcd driver I've noticed that some changes has been maded but the only 
one that can influence the BIOS handoff is the following:

kernel 2.6.7 - line 296: cap &= 1 << 24;
kernel 2.6.8 - line 296: cap |= 1 << 24;

This may be a mistake, I don't know, but I've restored that line with the &=
operator and all works again! If this was a typo mistake in the 2.6.8 patch
check the 2.8.9-rc1 also, in the prepatch there is a work-around that force 
the module to exit with code 0!

-- 
Gaetano Sferra
On Jabber: G[a]e@jabber.org
