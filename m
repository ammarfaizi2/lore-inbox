Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVC0TJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVC0TJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVC0TJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:09:24 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:28856 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261447AbVC0TJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:09:00 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Subject: [PATCH] Kill stupid warning when compiling riocmd.c
Date: Sun, 27 Mar 2005 15:48:53 +0200
User-Agent: KMail/1.8
Cc: Patrick van de Lageweg <patrick@bitwizard.nl>,
       linux-kernel@vger.kernel.org,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271548.55352.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my gcc complains about RIOCommandRup(), this is because this one has no
forward declaration and uses old style parameter declaration. This patch
changes all function headers in riocmd.c to use their parameter types
in function header directly.

Please apply,

Eike

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/drivers/char/rio/riocmd.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.12-rc1/drivers/char/rio/riocmd.c	2005-03-26 22:04:47.000000000 +0100
@@ -84,9 +84,7 @@
 static struct KillNeighbour KillUnit;
 
 int
-RIOFoadRta(HostP, MapP)
-struct Host *	HostP;
-struct Map *	MapP;
+RIOFoadRta(struct Host *HostP, struct Map *MapP)
 {
 	struct CmdBlk *CmdBlkP;
 
@@ -117,9 +115,7 @@
 }
 
 int
-RIOZombieRta(HostP, MapP)
-struct Host *	HostP;
-struct Map *	MapP;
+RIOZombieRta(struct Host *HostP, struct Map *MapP)
 {
 	struct CmdBlk *CmdBlkP;
 
@@ -150,10 +146,8 @@
 }
 
 int
-RIOCommandRta(p, RtaUnique, func)
-struct rio_info *	p;
-uint RtaUnique;
-int (* func)( struct Host *HostP, struct Map *MapP );
+RIOCommandRta(struct rio_info *p, uint RtaUnique,
+	int (* func)(struct Host *HostP, struct Map *MapP))
 {
 	uint Host;
 
@@ -195,9 +189,7 @@
 
 
 int
-RIOIdentifyRta(p, arg)
-struct rio_info *	p;
-caddr_t arg;
+RIOIdentifyRta(struct rio_info *p, caddr_t arg)
 {
 	uint Host;
 
@@ -263,9 +255,7 @@
 
 
 int
-RIOKillNeighbour(p, arg)
-struct rio_info *	p;
-caddr_t arg;
+RIOKillNeighbour(struct rio_info *p, caddr_t arg)
 {
 	uint Host;
 	uint ID;
@@ -329,10 +319,7 @@
 }
 
 int
-RIOSuspendBootRta(HostP, ID, Link)
-struct Host *HostP;
-int ID;
-int Link; 
+RIOSuspendBootRta(struct Host *HostP, int ID, int Link)
 {
 	struct CmdBlk *CmdBlkP;
 
@@ -363,8 +350,7 @@
 }
 
 int
-RIOFoadWakeup(p)
-struct rio_info *	p;
+RIOFoadWakeup(struct rio_info *p)
 {
 	int port;
 	register struct Port *PortP;
@@ -398,11 +384,7 @@
 ** Incoming command on the COMMAND_RUP to be processed.
 */
 static int
-RIOCommandRup(p, Rup, HostP, PacketP)
-struct rio_info *	p;
-uint Rup;
-struct Host *HostP;
-PKT *PacketP; 
+RIOCommandRup(struct rio_info *p, uint Rup, struct Host *HostP, PKT *PacketP)
 {
 	struct PktCmd *PktCmdP = (struct PktCmd *)PacketP->data;
 	struct Port *PortP;
@@ -619,7 +601,7 @@
 ** Allocate an empty command block.
 */
 struct CmdBlk *
-RIOGetCmdBlk()
+RIOGetCmdBlk(void)
 {
 	struct CmdBlk *CmdBlkP;
 
@@ -634,8 +616,7 @@
 ** Return a block to the head of the free list.
 */
 void
-RIOFreeCmdBlk(CmdBlkP)
-struct CmdBlk *CmdBlkP;
+RIOFreeCmdBlk(struct CmdBlk *CmdBlkP)
 {
 	sysfree((void *)CmdBlkP, sizeof(struct CmdBlk));
 }
@@ -645,10 +626,7 @@
 ** a given rup.
 */
 int
-RIOQueueCmdBlk(HostP, Rup, CmdBlkP)
-struct Host *HostP;
-uint Rup;
-struct CmdBlk *CmdBlkP;
+RIOQueueCmdBlk(struct Host *HostP, uint Rup, struct CmdBlk *CmdBlkP)
 {
 	struct CmdBlk **Base;
 	struct UnixRup *UnixRupP;
@@ -679,7 +657,6 @@
 							:TRUE)) {
 		rio_dprintk (RIO_DEBUG_CMD, "RUP inactive-placing command straight on. Cmd byte is 0x%x\n",
 					     CmdBlkP->Packet.data[0]);
-                                            
 
 		/*
 		** Whammy! blat that pack!
@@ -737,9 +714,7 @@
 ** must be called at splrio() or higher.
 */
 void
-RIOPollHostCommands(p, HostP)
-struct rio_info *	p;
-struct Host *		HostP;
+RIOPollHostCommands(struct rio_info *p, struct Host *HostP)
 {
 	register struct CmdBlk *CmdBlkP;
 	register struct UnixRup *UnixRupP;
@@ -918,9 +893,7 @@
 }
 
 int
-RIOWFlushMark(iPortP, CmdBlkP)
-int iPortP;
-struct CmdBlk *CmdBlkP;
+RIOWFlushMark(int iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *	PortP = (struct Port *)iPortP;
 	unsigned long flags;
@@ -936,9 +909,7 @@
 }
 
 int
-RIORFlushEnable(iPortP, CmdBlkP)
-int iPortP;
-struct CmdBlk *CmdBlkP; 
+RIORFlushEnable(int iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *	PortP = (struct Port *)iPortP;
 	PKT *PacketP;
@@ -965,9 +936,7 @@
 }
 
 int
-RIOUnUse(iPortP, CmdBlkP)
-int iPortP;
-struct CmdBlk *CmdBlkP; 
+RIOUnUse(int iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *	PortP = (struct Port *)iPortP;
 	unsigned long flags;
@@ -1009,9 +978,7 @@
 }
 
 void
-ShowPacket(Flags, PacketP)
-uint Flags;
-struct PKT *PacketP; 
+ShowPacket(uint Flags, struct PKT *PacketP)
 {
 }
 
