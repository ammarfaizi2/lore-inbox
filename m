Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUEDRyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUEDRyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUEDRyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 13:54:10 -0400
Received: from adsl-83-231.38-151.net24.it ([151.38.231.83]:26121 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264538AbUEDRyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 13:54:03 -0400
Date: Tue, 4 May 2004 19:54:01 +0200
From: Daniele Venzano <webvenza@libero.it>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver shutdown functions)
Message-ID: <20040504175401.GA21789@gateway.milesteg.arr>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com> <20040504084326.GA11133@gateway.milesteg.arr> <20040504082849.56f16613.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20040504082849.56f16613.rddunlap@osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 04, 2004 at 08:28:49AM -0700, Randy.Dunlap wrote:
> On Tue, 4 May 2004 10:43:26 +0200 Daniele Venzano wrote:
> 
> | Thank you for the spotting, the sis900 dirver was really missing a call
> | to netif_device_detach in sis900_suspend.
> | 
> | Attached is a trivial patch that fixes the issue.
> 
> Just how trivial is the patch?
A one liner, against 2.6.5.

> -ENOATTACHMENT
Sorry, now is attached and is available at this url:
http://teg.homeunix.org/kernel_patches.html

The patch is tested, compiles and run. Could not test that very code
path because of other unrelated errors during suspend, that I was having
before this change.
But it's really a bug, there is a call to netif_device_attach inside
sis900_resume, but there is no corresponding netif_device_detach in
sis900_suspend.

Hope this clarifies.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-detach.diff"

--- linux-2.6.5/drivers/net/sis900.c	2004-04-05 17:33:30.000000000 +0200
+++ linux-2.6.5-exp/drivers/net/sis900.c	2004-05-04 10:15:06.000000000 +0200
@@ -2195,6 +2195,7 @@
 		return 0;
 
 	netif_stop_queue(net_dev);
+	netif_device_detach(net_dev);
 
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);

--qMm9M+Fa2AknHoGS--
