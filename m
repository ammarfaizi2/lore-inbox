Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVATJ5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVATJ5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVATJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:57:14 -0500
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:58578 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262086AbVATJ5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:57:11 -0500
Date: Thu, 20 Jan 2005 10:57:09 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Andrew Morton <akpm@osdl.org>, robert.olsson@its.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-ID: <20050120095709.GA29811@gareth.mathematik.tu-chemnitz.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	robert.olsson@its.uu.se, linux-kernel@vger.kernel.org
References: <20050119213818.55b14bb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -2.8 (--)
X-Spam-Report: --- Start der SpamAssassin 3.0.1 Textanalyse (-2.8 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-2.8 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 5ce44a36c4f4b1c7ddfb73cb65031a54
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:38:18PM -0800 or thereabouts, Andrew Morton wrote:

> +kill-softirq_pending.patch
> 
>  Remove softirq_pending().  This breaks net/core/pktgen.c.

net/built-in.o: In function `pktgen_thread_worker':
/usr/src/linux-2.6.11-rc1-mm2/net/core/pktgen.c:2809: undefined reference to `softirq_pending'
make: *** [.tmp_vmlinux1] Error 1

The patch below is a compile fix.

Signed-off-by: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>

--- vanilla-2.6.11-rc1-mm2/net/core/pktgen.c	Thu Jan 20 10:30:12 2005
+++ linux-2.6.11-rc1-mm2/net/core/pktgen.c	Thu Jan 20 10:26:03 2005
@@ -2806,7 +2806,7 @@
 			tx_since_softirq += pkt_dev->last_ok;
 
 			if (tx_since_softirq > max_before_softirq) {
-				if(softirq_pending(smp_processor_id()))  
+				if(local_softirq_pending())  
 					do_softirq();
 				tx_since_softirq = 0;
 			}
