Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270728AbRHPENP>; Thu, 16 Aug 2001 00:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270730AbRHPENG>; Thu, 16 Aug 2001 00:13:06 -0400
Received: from trained-monkey.org ([209.217.122.11]:29944 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S270728AbRHPEMv>; Thu, 16 Aug 2001 00:12:51 -0400
Date: Thu, 16 Aug 2001 00:11:00 -0400
Message-Id: <200108160411.f7G4B0A19402@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: ipslinux@us.ibm.com
CC: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] ips.c spin lock 64 bit issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I noticed the ips.c driver used 32 bit data types for it's cpu_flags
variables passed to spin_lock_irqsave() etc. which isn't safe on 64
systems.

Here is a patch that solves the problem (think I got them all).

Cheers
Jes

--- drivers/scsi/ips.c~	Sat May 19 20:43:06 2001
+++ drivers/scsi/ips.c	Thu Aug 16 00:06:57 2001
@@ -1416,7 +1416,7 @@
 ips_eh_reset(Scsi_Cmnd *SC) {
    int                   ret;
    int                   i;
-   u32                   cpu_flags;
+   unsigned long         cpu_flags;
    ips_ha_t             *ha;
    ips_scb_t            *scb;
    ips_copp_wait_item_t *item;
@@ -1607,7 +1607,7 @@
 int
 ips_queue(Scsi_Cmnd *SC, void (*done) (Scsi_Cmnd *)) {
    ips_ha_t         *ha;
-   u32               cpu_flags;
+   unsigned long     cpu_flags;
    DECLARE_MUTEX_LOCKED(sem);
 
    METHOD_TRACE("ips_queue", 1);
@@ -1854,7 +1854,7 @@
 void
 do_ipsintr(int irq, void *dev_id, struct pt_regs *regs) {
    ips_ha_t         *ha;
-   u32               cpu_flags;
+   unsigned long     cpu_flags;
 
    METHOD_TRACE("do_ipsintr", 2);
 
@@ -1909,7 +1909,7 @@
    ips_scb_t        *scb;
    IPS_STATUS        cstatus;
    int               intrstatus;
-   u32               cpu_flags;
+   unsigned long     cpu_flags;
 
    METHOD_TRACE("ips_intr", 2);
 
@@ -1981,7 +1981,7 @@
    ips_scb_t        *scb;
    IPS_STATUS        cstatus;
    int               intrstatus;
-   u32               cpu_flags;
+   unsigned long     cpu_flags;
 
    METHOD_TRACE("ips_intr_morpheus", 2);
 
@@ -3548,8 +3548,8 @@
    ips_copp_wait_item_t *item;
    int                   ret;
    int                   intr_status;
-   u32                   cpu_flags;
-   u32                   cpu_flags2;
+   unsigned long         cpu_flags;
+   unsigned long         cpu_flags2;
 
    METHOD_TRACE("ips_next", 1);
 
@@ -4403,7 +4403,7 @@
 static void
 ips_done(ips_ha_t *ha, ips_scb_t *scb) {
    int ret;
-   u32 cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_done", 1);
 
@@ -5520,7 +5520,7 @@
 static ips_scb_t *
 ips_getscb(ips_ha_t *ha) {
    ips_scb_t     *scb;
-   u32            cpu_flags;
+   unsigned long  cpu_flags;
 
    METHOD_TRACE("ips_getscb", 1);
 
@@ -5554,7 +5554,7 @@
 /****************************************************************************/
 static void
 ips_freescb(ips_ha_t *ha, ips_scb_t *scb) {
-   u32          cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_freescb", 1);
 
@@ -5967,7 +5967,7 @@
 static int
 ips_reset_copperhead(ips_ha_t *ha) {
    int reset_counter;
-   u32 cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_reset_copperhead", 1);
 
@@ -6012,7 +6012,7 @@
 static int
 ips_reset_copperhead_memio(ips_ha_t *ha) {
    int reset_counter;
-   u32 cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_reset_copperhead_memio", 1);
 
@@ -6058,7 +6058,7 @@
 ips_reset_morpheus(ips_ha_t *ha) {
    int reset_counter;
    u8  junk;
-   u32 cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_reset_morpheus", 1);
 
@@ -6237,7 +6237,7 @@
 ips_issue_copperhead(ips_ha_t *ha, ips_scb_t *scb) {
    u32       TimeOut;
    u16       val;
-   u32       cpu_flags;
+   unsigned long       cpu_flags;
 
    METHOD_TRACE("ips_issue_copperhead", 1);
 
@@ -6300,7 +6300,7 @@
 ips_issue_copperhead_memio(ips_ha_t *ha, ips_scb_t *scb) {
    u32       TimeOut;
    u32       val;
-   u32       cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_issue_copperhead_memio", 1);
 
@@ -6361,7 +6361,7 @@
 /****************************************************************************/
 static int
 ips_issue_i2o(ips_ha_t *ha, ips_scb_t *scb) {
-   u32       cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_issue_i2o", 1);
 
@@ -6401,7 +6401,7 @@
 /****************************************************************************/
 static int
 ips_issue_i2o_memio(ips_ha_t *ha, ips_scb_t *scb) {
-   u32       cpu_flags;
+   unsigned long cpu_flags;
 
    METHOD_TRACE("ips_issue_i2o_memio", 1);
 
