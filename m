Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWHBM1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHBM1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWHBM1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:27:46 -0400
Received: from iona.labri.fr ([147.210.8.143]:24741 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750803AbWHBM1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:27:45 -0400
Date: Wed, 2 Aug 2006 14:27:43 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix initialization of runqueues
Message-ID: <20060802122743.GF4460@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's an odd thing about the nr_active field in arrays of runqueue_t:
it is actually never initialized to 0!...  This doesn't yet trigger a
bug probably because the way runqueues are allocated make it so that
it is already initialized to 0, but that's not a safe way.  Here is a
patch:

Initialize to zero the nr_active field of arrays of runqueues.
(fixes future potential dynamic allocation of runqueues).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- linux-2.6.17-orig/kernel/sched.c	2006-06-18 19:22:40.000000000 +0200
+++ linux/kernel/sched.c	2006-08-02 14:23:02.000000000 +0200
@@ -6132,6 +6132,7 @@
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
+			array->nr_active = 0;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
