Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752457AbWAFQcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbWAFQcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbWAFQao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752457AbWAFQaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:05 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTbHk011386@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 13/17] FRV: Fix uninitialised variable in atm nicstar driver
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes an uninitialised variable warning in the atm nicstar
driver.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 atm-nicstar-2615.diff
 drivers/atm/nicstar.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/drivers/atm/nicstar.c linux-2.6.15-frv/drivers/atm/nicstar.c
--- /warthog/kernels/linux-2.6.15/drivers/atm/nicstar.c	2005-11-01 13:19:04.000000000 +0000
+++ linux-2.6.15-frv/drivers/atm/nicstar.c	2006-01-06 14:43:43.000000000 +0000
@@ -2126,8 +2126,7 @@ static void process_rsq(ns_dev *card)
 
    if (!ns_rsqe_valid(card->rsq.next))
       return;
-   while (ns_rsqe_valid(card->rsq.next))
-   {
+   do {
       dequeue_rx(card, card->rsq.next);
       ns_rsqe_init(card->rsq.next);
       previous = card->rsq.next;
@@ -2135,7 +2134,7 @@ static void process_rsq(ns_dev *card)
          card->rsq.next = card->rsq.base;
       else
          card->rsq.next++;
-   }
+   } while (ns_rsqe_valid(card->rsq.next));
    writel((((u32) previous) - ((u32) card->rsq.base)),
           card->membase + RSQH);
 }
