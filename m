Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVBQJ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVBQJ3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVBQJ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:29:49 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:32177 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262279AbVBQJ3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:29:38 -0500
X-Qmail-Scanner-Toxic-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Toxic-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner-Toxic: 1.24st (Clear:RC:1(213.238.99.204):. Processed in 0.043074 secs Process 29941)
Date: Thu, 17 Feb 2005 10:29:38 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1433055775.20050217102938@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re: possible leak in kernel 2.6.10-ac12
In-Reply-To: <4213D70F.20104@arrakis.dhis.org>
References: <4213D70F.20104@arrakis.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pedro,

Thursday, February 17, 2005, 12:28:15 AM, you wrote:

> boot. It came to a point that it started swapping and the swap usage too
> started to grow linearly.
I had the same with swap being eaten especially by perl apps like qmail-scanner

I think this helps:
--- a/mm/vmscan.c       2004-12-24 13:36:18 -08:00
+++ b/mm/vmscan.c       2004-12-24 13:36:18 -08:00
@@ -675,6 +674,7 @@
                 }
                 pgscanned++;
         }
+        zone->pages_scanned += pgscanned;
         zone->nr_active -= pgmoved;
         spin_unlock_irq(&zone->lru_lock);

This patchlet is at:
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fpatch-2.6.10.bz2;z=4918
This changeset contains other patches, you need only one.

2.6.11 will have it fixed.

Regards,
Maciej Soltysiak


