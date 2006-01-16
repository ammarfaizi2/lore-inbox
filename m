Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWAPRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWAPRXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWAPRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:23:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20130 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751140AbWAPRXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:23:33 -0500
Subject: PATCH: Remove unused code from rioctrl.c (Last for this batch of
	work)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:27:38 +0000
Message-Id: <1137432458.15553.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rioctrl.c linux-2.6.15-git12/drivers/char/rio/rioctrl.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rioctrl.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rioctrl.c	2006-01-16 16:23:09.573952536 +0000
@@ -308,12 +308,7 @@
 		}
 
 	case RIO_DEBUG_MEM:
-#ifdef DEBUG_MEM_SUPPORT
-		RIO_DEBUG_CTRL, if (su)
-			return rio_RIODebugMemory(RIO_DEBUG_CTRL, arg);
-		else
-#endif
-			return -EPERM;
+		return -EPERM;
 
 	case RIO_ALL_MODEM:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_ALL_MODEM\n");
@@ -591,12 +586,7 @@
 
 	case RIO_GET_LOG:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_GET_LOG\n");
-#ifdef LOGGING
-		RIOGetLog(arg);
-		return 0;
-#else
 		return -EINVAL;
-#endif
 
 	case RIO_GET_MODTYPE:
 		if (copyin((int) arg, (caddr_t) & port, sizeof(uint)) == COPYFAIL) {
@@ -684,52 +674,6 @@
 		rio_dprintk(RIO_DEBUG_CTRL, "entering loop (%d %d)!\n", PortSetup.From, PortSetup.To);
 		for (loop = PortSetup.From; loop <= PortSetup.To; loop++) {
 			rio_dprintk(RIO_DEBUG_CTRL, "in loop (%d)!\n", loop);
-#if 0
-			PortP = p->RIOPortp[loop];
-			if (!PortP->TtyP)
-				PortP->TtyP = &p->channel[loop];
-
-			rio_spin_lock_irqsave(&PortP->portSem, flags);
-			if (PortSetup.IxAny)
-				PortP->Config |= RIO_IXANY;
-			else
-				PortP->Config &= ~RIO_IXANY;
-			if (PortSetup.IxOn)
-				PortP->Config |= RIO_IXON;
-			else
-				PortP->Config &= ~RIO_IXON;
-
-			/*
-			 ** If the port needs to wait for all a processes output
-			 ** to drain before closing then this flag will be set.
-			 */
-			if (PortSetup.Drain) {
-				PortP->Config |= RIO_WAITDRAIN;
-			} else {
-				PortP->Config &= ~RIO_WAITDRAIN;
-			}
-			/*
-			 ** Store settings if locking or unlocking port or if the
-			 ** port is not locked, when setting the store option.
-			 */
-			if (PortP->Mapped && ((PortSetup.Lock && !PortP->Lock) || (!PortP->Lock && (PortSetup.Store && !PortP->Store)))) {
-				PortP->StoredTty.iflag = PortP->TtyP->tm.c_iflag;
-				PortP->StoredTty.oflag = PortP->TtyP->tm.c_oflag;
-				PortP->StoredTty.cflag = PortP->TtyP->tm.c_cflag;
-				PortP->StoredTty.lflag = PortP->TtyP->tm.c_lflag;
-				PortP->StoredTty.line = PortP->TtyP->tm.c_line;
-				bcopy(PortP->TtyP->tm.c_cc, PortP->StoredTty.cc, NCC + 5);
-			}
-			PortP->Lock = PortSetup.Lock;
-			PortP->Store = PortSetup.Store;
-			PortP->Xprint.XpCps = PortSetup.XpCps;
-			bcopy(PortSetup.XpOn, PortP->Xprint.XpOn, MAX_XP_CTRL_LEN);
-			bcopy(PortSetup.XpOff, PortP->Xprint.XpOff, MAX_XP_CTRL_LEN);
-			PortP->Xprint.XpOn[MAX_XP_CTRL_LEN - 1] = '\0';
-			PortP->Xprint.XpOff[MAX_XP_CTRL_LEN - 1] = '\0';
-			PortP->Xprint.XpLen = RIOStrlen(PortP->Xprint.XpOn) + RIOStrlen(PortP->Xprint.XpOff);
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-#endif
 		}
 		rio_dprintk(RIO_DEBUG_CTRL, "after loop (%d)!\n", loop);
 		rio_dprintk(RIO_DEBUG_CTRL, "Retval:%x\n", retval);
@@ -801,12 +745,6 @@
 
 		rio_dprintk(RIO_DEBUG_CTRL, "Port %d\n", PortTty.port);
 		PortP = (p->RIOPortp[PortTty.port]);
-#if 0
-		PortTty.Tty.tm.c_iflag = PortP->TtyP->tm.c_iflag;
-		PortTty.Tty.tm.c_oflag = PortP->TtyP->tm.c_oflag;
-		PortTty.Tty.tm.c_cflag = PortP->TtyP->tm.c_cflag;
-		PortTty.Tty.tm.c_lflag = PortP->TtyP->tm.c_lflag;
-#endif
 		if (copyout((caddr_t) & PortTty, (int) arg, sizeof(struct PortTty)) == COPYFAIL) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -824,15 +762,6 @@
 			return -ENXIO;
 		}
 		PortP = (p->RIOPortp[PortTty.port]);
-#if 0
-		rio_spin_lock_irqsave(&PortP->portSem, flags);
-		PortP->TtyP->tm.c_iflag = PortTty.Tty.tm.c_iflag;
-		PortP->TtyP->tm.c_oflag = PortTty.Tty.tm.c_oflag;
-		PortP->TtyP->tm.c_cflag = PortTty.Tty.tm.c_cflag;
-		PortP->TtyP->tm.c_lflag = PortTty.Tty.tm.c_lflag;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-#endif
-
 		RIOParam(PortP, CONFIG, PortP->State & RIO_MODEM, OK_TO_SLEEP);
 		return retval;
 
@@ -909,23 +838,6 @@
 		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 		return retval;
 
-#ifdef DEBUG_SUPPORTED
-	case RIO_READ_LEVELS:
-		{
-			int num;
-			rio_dprintk(RIO_DEBUG_CTRL, "RIO_READ_LEVELS\n");
-			for (num = 0; RIODbInf[num].Flag; num++);
-			rio_dprintk(RIO_DEBUG_CTRL, "%d levels to copy\n", num);
-			if (copyout((caddr_t) RIODbInf, (int) arg, sizeof(struct DbInf) * (num + 1)) == COPYFAIL) {
-				rio_dprintk(RIO_DEBUG_CTRL, "ReadLevels Copy failed\n");
-				p->RIOError.Error = COPYOUT_FAILED;
-				return -EFAULT;
-			}
-			rio_dprintk(RIO_DEBUG_CTRL, "%d levels to copied\n", num);
-			return retval;
-		}
-#endif
-
 	case RIO_READ_CONFIG:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_READ_CONFIG\n");
 		if (copyout((caddr_t) & p->RIOConf, (int) arg, sizeof(struct Conf)) == COPYFAIL) {
@@ -1084,30 +996,13 @@
 			(void) RIOBoardTest(p->RIOHosts[Host].PaddrP, p->RIOHosts[Host].Caddr, p->RIOHosts[Host].Type, p->RIOHosts[Host].Slot);
 			bzero((caddr_t) & p->RIOHosts[Host].Flags, ((int) &p->RIOHosts[Host].____end_marker____) - ((int) &p->RIOHosts[Host].Flags));
 			p->RIOHosts[Host].Flags = RC_WAITING;
-#if 0
-			RIOSetupDataStructs(p);
-#endif
 		}
 		RIOFoadWakeup(p);
 		p->RIONumBootPkts = 0;
 		p->RIOBooting = 0;
-
-#ifdef RINGBUFFER_SUPPORT
-		for (loop = 0; loop < RIO_PORTS; loop++)
-			if (p->RIOPortp[loop]->TxRingBuffer)
-				sysfree((void *) p->RIOPortp[loop]->TxRingBuffer, RIOBufferSize);
-#endif
-#if 0
-		bzero((caddr_t) & p->RIOPortp[0], RIO_PORTS * sizeof(struct Port));
-#else
 		printk("HEEEEELP!\n");
-#endif
 
 		for (loop = 0; loop < RIO_PORTS; loop++) {
-#if 0
-			p->RIOPortp[loop]->TtyP = &p->channel[loop];
-#endif
-
 			spin_lock_init(&p->RIOPortp[loop]->portSem);
 			p->RIOPortp[loop]->InUse = NOT_INUSE;
 		}
@@ -1653,10 +1548,6 @@
 	ushort rup;
 	int port;
 
-#ifdef CHECK
-	CheckPortP(PortP);
-#endif
-
 	if (PortP->State & RIO_DELETED) {
 		rio_dprintk(RIO_DEBUG_CTRL, "Preemptive command to deleted RTA ignored\n");
 		return RIO_FAIL;

