Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWAPRRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWAPRRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWAPRRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:17:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22208 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751139AbWAPRRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:17:12 -0500
Subject: PATCH: Remove unused CHECK code from riocmd.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:21:25 +0000
Message-Id: <1137432085.15553.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/riocmd.c linux-2.6.15-git12/drivers/char/rio/riocmd.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/riocmd.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/riocmd.c	2006-01-16 16:23:09.573952536 +0000
@@ -387,12 +387,6 @@
 
 	func_enter();
 
-#ifdef CHECK
-	CheckHost(Host);
-	CheckHostP(HostP);
-	CheckPacketP(PacketP);
-#endif
-
 	/*
 	 ** 16 port RTA note:
 	 ** Command rup packets coming from the RTA will have pkt->data[1] (which
@@ -406,10 +400,6 @@
 	SysPort = UnixRupP->BaseSysPort + (RBYTE(PktCmdP->PhbNum) % (ushort) PORTS_PER_RTA);
 	rio_dprintk(RIO_DEBUG_CMD, "Command on rup %d, port %d\n", rup, SysPort);
 
-#ifdef CHECK
-	CheckRup(rup);
-	CheckUnixRupP(UnixRupP);
-#endif
 	if (UnixRupP->BaseSysPort == NO_PORT) {
 		rio_dprintk(RIO_DEBUG_CMD, "OBSCURE ERROR!\n");
 		rio_dprintk(RIO_DEBUG_CMD, "Diagnostics follow. Please WRITE THESE DOWN and report them to Specialix Technical Support\n");
@@ -429,9 +419,6 @@
 		rio_dprintk(RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x, " "Command Code 0x%x\n", PktCmdP->PhbNum, PktCmdP->Command);
 		return TRUE;
 	}
-#ifdef CHECK
-	CheckSysPort(SysPort);
-#endif
 	PortP = p->RIOPortp[SysPort];
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 	switch (RBYTE(PktCmdP->Command)) {
@@ -604,11 +591,6 @@
 	struct UnixRup *UnixRupP;
 	unsigned long flags;
 
-#ifdef CHECK
-	CheckHostP(HostP);
-	CheckRup(Rup);
-	CheckCmdBlkP(CmdBlkP);
-#endif
 	if (Rup >= (ushort) (MAX_RUP + LINKS_PER_UNIT)) {
 		rio_dprintk(RIO_DEBUG_CMD, "Illegal rup number %d in RIOQueueCmdBlk\n", Rup);
 		RIOFreeCmdBlk(CmdBlkP);
@@ -806,9 +788,6 @@
 			 ** If it returns RIO_FAIL then don't
 			 ** send this command yet!
 			 */
-#ifdef CHECK
-			CheckCmdBlkP(CmdBlkP);
-#endif
 			if (!(CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP) : TRUE)) {
 				rio_dprintk(RIO_DEBUG_CMD, "Not ready to start command 0x%x\n", (int) CmdBlkP);
 			} else {
@@ -816,9 +795,6 @@
 				/*
 				 ** Whammy! blat that pack!
 				 */
-#ifdef CHECK
-				CheckPacketP((PKT *) RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt));
-#endif
 				HostP->Copy((caddr_t) & CmdBlkP->Packet, RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt), sizeof(PKT));
 
 				/*
@@ -852,9 +828,6 @@
 	unsigned long flags;
 
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
-#ifdef CHECK
-	CheckPortP(PortP);
-#endif
 	PortP->WflushFlag++;
 	PortP->MagicFlags |= MAGIC_FLUSH;
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
@@ -894,9 +867,6 @@
 
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 
-#ifdef CHECK
-	CheckPortP(PortP);
-#endif
 	rio_dprintk(RIO_DEBUG_CMD, "Decrement in use count for port\n");
 
 	if (PortP->InUse) {

