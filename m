Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVJKGGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVJKGGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 02:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVJKGGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 02:06:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59628 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751381AbVJKGGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 02:06:23 -0400
Date: Tue, 11 Oct 2005 08:06:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rogio Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.14-rc3] BUG: soft lockup detected on CPU#0
Message-ID: <20051011060652.GB19321@elte.hu>
References: <20051010204039.30dc1e0e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010204039.30dc1e0e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Hi there, all.
> 
> I have been running kernel 2.6.14-rc3 for some time now and I see some 
> bugs.
> 
> One of them is a soft lockup detected on CPU#0 (the only CPU that I 
> have) during the stage when the kernel is probing for IDE 
> controllers/devices.
> 
> Here is the relevant part of the dmesg log (the whole dmesg log is 
> attached):

does the patch below help?

	Ingo

----

should solve false-positive soft lockup messages during IDE init.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--

 drivers/ide/ide-iops.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux/drivers/ide/ide-iops.c
===================================================================
--- linux.orig/drivers/ide/ide-iops.c
+++ linux/drivers/ide/ide-iops.c
@@ -1247,6 +1247,7 @@ int ide_wait_not_busy(ide_hwif_t *hwif, 
 		 */
 		if (stat == 0xff)
 			return -ENODEV;
+		touch_softlockup_watchdog();
 	}
 	return -EBUSY;
 }
