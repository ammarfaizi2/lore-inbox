Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWALKsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWALKsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWALKsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:48:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63755 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030357AbWALKsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:48:04 -0500
Date: Thu, 12 Jan 2006 11:48:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/rcupdate.c: make two structs static
Message-ID: <20060112104803.GQ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/rcupdate.h |    2 --
 kernel/rcupdate.c        |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.15-mm3-full/include/linux/rcupdate.h.old	2006-01-12 02:23:35.000000000 +0100
+++ linux-2.6.15-mm3-full/include/linux/rcupdate.h	2006-01-12 01:06:47.000000000 +0100
@@ -109,8 +109,6 @@
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
 DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
-extern struct rcu_ctrlblk rcu_ctrlblk;
-extern struct rcu_ctrlblk rcu_bh_ctrlblk;
 
 /*
  * Increment the quiescent state counter.
--- linux-2.6.15-mm3-full/kernel/rcupdate.c.old	2006-01-12 01:06:54.000000000 +0100
+++ linux-2.6.15-mm3-full/kernel/rcupdate.c	2006-01-12 01:07:07.000000000 +0100
@@ -49,13 +49,13 @@
 #include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
-struct rcu_ctrlblk rcu_ctrlblk = {
+static struct rcu_ctrlblk rcu_ctrlblk = {
 	.cur = -300,
 	.completed = -300,
 	.lock = SPIN_LOCK_UNLOCKED,
 	.cpumask = CPU_MASK_NONE,
 };
-struct rcu_ctrlblk rcu_bh_ctrlblk = {
+static struct rcu_ctrlblk rcu_bh_ctrlblk = {
 	.cur = -300,
 	.completed = -300,
 	.lock = SPIN_LOCK_UNLOCKED,

