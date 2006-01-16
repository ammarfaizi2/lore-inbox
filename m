Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWAPRHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWAPRHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWAPRHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:07:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20119 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751127AbWAPRHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:07:39 -0500
Subject: PATCH: Remove #if 0 and other long dead code from rio_tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:11:50 +0000
Message-Id: <1137431510.15553.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/riotty.c linux-2.6.15-git12/drivers/char/rio/riotty.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/riotty.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/riotty.c	2006-01-16 16:23:09.574952384 +0000
@@ -89,16 +89,9 @@
 #include "list.h"
 #include "sam.h"
 
-#if 0
-static void ttyseth_pv(struct Port *, struct ttystatics *, struct termios *sg, int);
-#endif
-
 static void RIOClearUp(struct Port *PortP);
 int RIOShortCommand(struct rio_info *p, struct Port *PortP, int command, int len, int arg);
 
-#if 0
-static int RIOCookMode(struct ttystatics *);
-#endif
 
 extern int conv_vb[];		/* now defined in ttymgr.c */
 extern int conv_bv[];		/* now defined in ttymgr.c */
@@ -226,33 +219,6 @@
 	 ** until the RTA is present then we must spin here waiting for
 	 ** the RTA to boot.
 	 */
-#if 0
-	if (!(PortP->HostP->Mapping[PortP->RupNum].Flags & RTA_BOOTED)) {
-		if (PortP->WaitUntilBooted) {
-			rio_dprintk(RIO_DEBUG_TTY, "Waiting for RTA to boot\n");
-			do {
-				if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL) {
-					rio_dprintk(RIO_DEBUG_TTY, "RTA EINTR in delay \n");
-					func_exit();
-					return -EINTR;
-				}
-				if (repeat_this-- <= 0) {
-					rio_dprintk(RIO_DEBUG_TTY, "Waiting for RTA to boot timeout\n");
-					RIOPreemptiveCmd(p, PortP, FCLOSE);
-					pseterr(EINTR);
-					func_exit();
-					return -EIO;
-				}
-			} while (!(PortP->HostP->Mapping[PortP->RupNum].Flags & RTA_BOOTED));
-			rio_dprintk(RIO_DEBUG_TTY, "RTA has been booted\n");
-		} else {
-			rio_dprintk(RIO_DEBUG_TTY, "RTA never booted\n");
-			pseterr(ENXIO);
-			func_exit();
-			return 0;
-		}
-	}
-#else
 	/* I find the above code a bit hairy. I find the below code
 	   easier to read and shorter. Now, if it works too that would
 	   be great... -- REW 
@@ -281,21 +247,10 @@
 		}
 	}
 	rio_dprintk(RIO_DEBUG_TTY, "RTA has been booted\n");
-#endif
-#if 0
-	tp = PortP->TtyP;	/* get tty struct */
-#endif
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 	if (p->RIOHalted) {
 		goto bombout;
 	}
-#if 0
-	retval = gs_init_port(&PortP->gs);
-	if (retval) {
-		func_exit();
-		return retval;
-	}
-#endif
 
 	/*
 	 ** If the port is in the final throws of being closed,
@@ -363,11 +318,6 @@
 		   command piggybacks the parameters immediately.
 		   -- REW */
 		RIOParam(PortP, OPEN, Modem, OK_TO_SLEEP);	/* Open the port */
-#if 0
-		/* This delay of 1 second was annoying. I removed it. -- REW */
-		RIODelay(PortP, HUNDRED_MS * 10);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);	/* Config the port */
-#endif
 		rio_spin_lock_irqsave(&PortP->portSem, flags);
 
 		/*
@@ -439,9 +389,6 @@
 				PortP->State |= RIO_WOPEN;
 				rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 				if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL)
-#if 0
-					if (sleep((caddr_t) & tp->tm.c_canqo, TTIPRI | PCATCH))
-#endif
 					{
 						/*
 						 ** ACTION: verify that this is a good thing
@@ -505,10 +452,6 @@
 */
 int riotclose(void *ptr)
 {
-#if 0
-	register uint SysPort = dev;
-	struct ttystatics *tp;	/* pointer to our ttystruct */
-#endif
 	struct Port *PortP = ptr;	/* pointer to the port structure */
 	int deleted = 0;
 	int try = -1;		/* Disable the timeouts by setting them to -1 */
@@ -534,13 +477,6 @@
 		end_time = jiffies + MAX_SCHEDULE_TIMEOUT;
 
 	Modem = rio_ismodem(tty);
-#if 0
-	/* What F.CKING cache? Even then, a higly idle multiprocessor,
-	   system with large caches this won't work . Better find out when 
-	   this doesn't work asap, and fix the cause.  -- REW */
-
-	RIODelay(PortP, HUNDRED_MS * 10);	/* To flush the cache */
-#endif
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 
 	/*
@@ -703,45 +639,6 @@
 }
 
 
-/*
-** decide if we need to use the line discipline.
-** This routine can return one of three values:
-** COOK_RAW if no processing has to be done by the line discipline or the card
-** COOK_WELL if the line discipline must be used to do the processing
-** COOK_MEDIUM if the card can do all the processing necessary.
-*/
-#if 0
-static int RIOCookMode(struct ttystatics *tp)
-{
-	/*
-	 ** We can't handle tm.c_mstate != 0 on SCO
-	 ** We can't handle mapping
-	 ** We can't handle non-ttwrite line disc.
-	 ** We can't handle lflag XCASE
-	 ** We can handle oflag OPOST & (OCRNL, ONLCR, TAB3)
-	 */
-
-#ifdef CHECK
-	CheckTtyP(tp);
-#endif
-	if (!(tp->tm.c_oflag & OPOST))	/* No post processing */
-		return COOK_RAW;	/* Raw mode o/p */
-
-	if (tp->tm.c_lflag & XCASE)
-		return COOK_WELL;	/* Use line disc */
-
-	if (tp->tm.c_oflag & ~(OPOST | ONLCR | OCRNL | TAB3))
-		return COOK_WELL;	/* Use line disc for strange modes */
-
-	if (tp->tm.c_oflag == OPOST)	/* If only OPOST is set, do RAW */
-		return COOK_RAW;
-
-	/*
-	 ** So, we need to output process!
-	 */
-	return COOK_MEDIUM;
-}
-#endif
 
 static void RIOClearUp(PortP)
 struct Port *PortP;
@@ -776,11 +673,6 @@
 	unsigned long flags;
 
 	rio_dprintk(RIO_DEBUG_TTY, "entering shortcommand.\n");
-#ifdef CHECK
-	CheckPortP(PortP);
-	if (len < 1 || len > 2)
-		cprintf(("STUPID LENGTH %d\n", len));
-#endif
 
 	if (PortP->State & RIO_DELETED) {
 		rio_dprintk(RIO_DEBUG_TTY, "Short command to deleted RTA ignored\n");
@@ -852,478 +744,3 @@
 }
 
 
-#if 0
-/*
-** This is an ioctl interface. This is the twentieth century. You know what
-** its all about.
-*/
-int riotioctl(struct rio_info *p, struct tty_struct *tty, int cmd, caddr_t arg)
-{
-	register struct Port *PortP;
-	register struct ttystatics *tp;
-	int current;
-	int ParamSemIncremented = 0;
-	int old_oflag, old_cflag, old_iflag, changed, oldcook;
-	int i;
-	unsigned char sio_regs[5];	/* Here be magic */
-	short vpix_cflag;
-	short divisor;
-	int baud;
-	uint SysPort = rio_minor(tty);
-	int Modem = rio_ismodem(tty);
-	int ioctl_processed;
-
-	rio_dprintk(RIO_DEBUG_TTY, "port ioctl SysPort %d command 0x%x argument 0x%x %s\n", SysPort, cmd, arg, Modem ? "Modem" : "tty");
-
-	if (SysPort >= RIO_PORTS) {
-		rio_dprintk(RIO_DEBUG_TTY, "Bad port number %d\n", SysPort);
-		return -ENXIO;
-	}
-
-	PortP = p->RIOPortp[SysPort];
-	tp = PortP->TtyP;
-
-	rio_spin_lock_irqsave(&PortP->portSem, flags);
-
-#ifdef STATS
-	PortP->Stat.IoctlCnt++;
-#endif
-
-	if (PortP->State & RIO_DELETED) {
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return -EIO;
-	}
-
-
-	if (p->RIOHalted) {
-		RIOClearUp(PortP);
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return -EIO;
-	}
-
-	/*
-	 ** Count ioctls for port statistics reporting
-	 */
-	if (PortP->statsGather)
-		PortP->ioctls++;
-
-	/*
-	 ** Specialix RIO Ioctl calls
-	 */
-	switch (cmd) {
-
-	case TCRIOTRIAD:
-		if (arg)
-			PortP->State |= RIO_TRIAD_MODE;
-		else
-			PortP->State &= ~RIO_TRIAD_MODE;
-		/*
-		 ** Normally, when istrip is set on a port, a config is
-		 ** sent to the RTA instructing the CD1400 to do the
-		 ** stripping. In TRIAD mode, the interrupt receive routine
-		 ** must do the stripping instead, since it has to detect
-		 ** an 8 bit function key sequence. If istrip is set with
-		 ** TRIAD mode on(off), and 8 bit data is being read by
-		 ** the port, the user then turns TRIAD mode off(on), the RTA
-		 ** must be reconfigured (not) to do the stripping.
-		 ** Hence we call RIOParam here.
-		 */
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-	case TCRIOTSTATE:
-		rio_dprintk(RIO_DEBUG_TTY, "tbusy/tstop monitoring %sabled\n", arg ? "en" : "dis");
-		/* MonitorTstate = 0 ; */
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-	case TCRIOSTATE:	/* current state of Modem input pins */
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOSTATE\n");
-		if (RIOPreemptiveCmd(p, PortP, MGET) == RIO_FAIL)
-			rio_dprintk(RIO_DEBUG_TTY, "TCRIOSTATE command failed\n");
-		PortP->State |= RIO_BUSY;
-		current = PortP->ModemState;
-		if (copyout((caddr_t) & current, (int) arg, sizeof(current)) == COPYFAIL) {
-			rio_dprintk(RIO_DEBUG_TTY, "Copyout failed\n");
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EFAULT);
-		}
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOMBIS:	/* Set modem lines */
-	case TCRIOMBIC:	/* Clear modem lines */
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOMBIS/TCRIOMBIC\n");
-		if (cmd == TCRIOMBIS) {
-			uint state;
-			state = (uint) arg;
-			PortP->ModemState |= (ushort) state;
-			PortP->ModemLines = (ulong) arg;
-			if (RIOPreemptiveCmd(p, PortP, MBIS) == RIO_FAIL)
-				rio_dprintk(RIO_DEBUG_TTY, "TCRIOMBIS command failed\n");
-		} else {
-			uint state;
-
-			state = (uint) arg;
-			PortP->ModemState &= ~(ushort) state;
-			PortP->ModemLines = (ulong) arg;
-			if (RIOPreemptiveCmd(p, PortP, MBIC) == RIO_FAIL)
-				rio_dprintk(RIO_DEBUG_TTY, "TCRIOMBIC command failed\n");
-		}
-		PortP->State |= RIO_BUSY;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOXPON:	/* set Xprint ON string */
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOXPON\n");
-		if (copyin((int) arg, (caddr_t) PortP->Xprint.XpOn, MAX_XP_CTRL_LEN) == COPYFAIL) {
-			rio_dprintk(RIO_DEBUG_TTY, "Copyin failed\n");
-			PortP->Xprint.XpOn[0] = '\0';
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EFAULT);
-		}
-		PortP->Xprint.XpOn[MAX_XP_CTRL_LEN - 1] = '\0';
-		PortP->Xprint.XpLen = strlen(PortP->Xprint.XpOn) + strlen(PortP->Xprint.XpOff);
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOXPOFF:	/* set Xprint OFF string */
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOXPOFF\n");
-		if (copyin((int) arg, (caddr_t) PortP->Xprint.XpOff, MAX_XP_CTRL_LEN) == COPYFAIL) {
-			rio_dprintk(RIO_DEBUG_TTY, "Copyin failed\n");
-			PortP->Xprint.XpOff[0] = '\0';
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EFAULT);
-		}
-		PortP->Xprint.XpOff[MAX_XP_CTRL_LEN - 1] = '\0';
-		PortP->Xprint.XpLen = strlen(PortP->Xprint.XpOn) + strlen(PortP->Xprint.XpOff);
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOXPCPS:	/* set Xprint CPS string */
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOXPCPS\n");
-		if ((uint) arg > p->RIOConf.MaxXpCps || (uint) arg < p->RIOConf.MinXpCps) {
-			rio_dprintk(RIO_DEBUG_TTY, "%d CPS out of range\n", arg);
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EINVAL);
-			return 0;
-		}
-		PortP->Xprint.XpCps = (uint) arg;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOXPRINT:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOXPRINT\n");
-		if (copyout((caddr_t) & PortP->Xprint, (int) arg, sizeof(struct Xprint)) == COPYFAIL) {
-			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EFAULT);
-		}
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOIXANYON:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOIXANYON\n");
-		PortP->Config |= RIO_IXANY;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOIXANYOFF:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOIXANYOFF\n");
-		PortP->Config &= ~RIO_IXANY;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOIXONON:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOIXONON\n");
-		PortP->Config |= RIO_IXON;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-	case TCRIOIXONOFF:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOIXONOFF\n");
-		PortP->Config &= ~RIO_IXON;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		return 0;
-
-/*
-** 15.10.1998 ARG - ESIL 0761 part fix
-** Added support for CTS and RTS flow control ioctls :
-*/
-	case TCRIOCTSFLOWEN:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOCTSFLOWEN\n");
-		PortP->Config |= RIO_CTSFLOW;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-	case TCRIOCTSFLOWDIS:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIOCTSFLOWDIS\n");
-		PortP->Config &= ~RIO_CTSFLOW;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-	case TCRIORTSFLOWEN:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIORTSFLOWEN\n");
-		PortP->Config |= RIO_RTSFLOW;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-	case TCRIORTSFLOWDIS:
-		rio_dprintk(RIO_DEBUG_TTY, "TCRIORTSFLOWDIS\n");
-		PortP->Config &= ~RIO_RTSFLOW;
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		return 0;
-
-/* end ESIL 0761 part fix */
-
-	}
-
-
-	/* Lynx IOCTLS */
-	switch (cmd) {
-	case TIOCSETP:
-	case TIOCSETN:
-	case OTIOCSETP:
-	case OTIOCSETN:
-		ioctl_processed++;
-		ttyseth(PortP, tp, (struct old_sgttyb *) arg);
-		break;
-	case TCSETA:
-	case TCSETAW:
-	case TCSETAF:
-		ioctl_processed++;
-		rio_dprintk(RIO_DEBUG_TTY, "NON POSIX ioctl\n");
-		ttyseth_pv(PortP, tp, (struct termios *) arg, 0);
-		break;
-	case TCSETAP:		/* posix tcsetattr() */
-	case TCSETAWP:		/* posix tcsetattr() */
-	case TCSETAFP:		/* posix tcsetattr() */
-		rio_dprintk(RIO_DEBUG_TTY, "NON POSIX SYSV ioctl\n");
-		ttyseth_pv(PortP, tp, (struct termios *) arg, 1);
-		ioctl_processed++;
-		break;
-	}
-
-	/*
-	 ** If its any of the commands that require the port to be in the
-	 ** non-busy state wait until all output has drained
-	 */
-	if (!ioctl_processed)
-		switch (cmd) {
-		case TCSETAW:
-		case TCSETAF:
-		case TCSETA:
-		case TCSBRK:
-#define OLD_POSIX ('x' << 8)
-#define OLD_POSIX_SETA (OLD_POSIX | 2)
-#define OLD_POSIX_SETAW (OLD_POSIX | 3)
-#define OLD_POSIX_SETAF (OLD_POSIX | 4)
-#define NEW_POSIX (('i' << 24) | ('X' << 16))
-#define NEW_POSIX_SETA (NEW_POSIX | 2)
-#define NEW_POSIX_SETAW (NEW_POSIX | 3)
-#define NEW_POSIX_SETAF (NEW_POSIX | 4)
-		case OLD_POSIX_SETA:
-		case OLD_POSIX_SETAW:
-		case OLD_POSIX_SETAF:
-		case NEW_POSIX_SETA:
-		case NEW_POSIX_SETAW:
-		case NEW_POSIX_SETAF:
-#ifdef TIOCSETP
-		case TIOCSETP:
-#endif
-		case TIOCSETD:
-		case TIOCSETN:
-			rio_dprintk(RIO_DEBUG_TTY, "wait for non-BUSY, semaphore set\n");
-			/*
-			 ** Wait for drain here, at least as far as the double buffer
-			 ** being empty.
-			 */
-			/* XXX Does the above comment mean that this has
-			   still to be implemented? -- REW */
-			/* XXX Is the locking OK together with locking
-			   in txenable? (Deadlock?) -- REW */
-
-			RIOTxEnable((char *) PortP);
-			break;
-		default:
-			break;
-		}
-
-	old_cflag = tp->tm.c_cflag;
-	old_iflag = tp->tm.c_iflag;
-	old_oflag = tp->tm.c_oflag;
-	oldcook = PortP->CookMode;
-
-	if (p->RIOHalted) {
-		RIOClearUp(PortP);
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		pseterr(EIO);
-		return 0;
-	}
-
-	PortP->FlushCmdBodge = 0;
-
-	/*
-	 ** If the port is locked, and it is reconfigured, we want
-	 ** to restore the state of the tty structure so the change is NOT
-	 ** made.
-	 */
-	if (PortP->Lock) {
-		tp->tm.c_iflag = PortP->StoredTty.iflag;
-		tp->tm.c_oflag = PortP->StoredTty.oflag;
-		tp->tm.c_cflag = PortP->StoredTty.cflag;
-		tp->tm.c_lflag = PortP->StoredTty.lflag;
-		tp->tm.c_line = PortP->StoredTty.line;
-		for (i = 0; i < NCC + 1; i++)
-			tp->tm.c_cc[i] = PortP->StoredTty.cc[i];
-	} else {
-		/*
-		 ** If the port is set to store the parameters, and it is
-		 ** reconfigured, we want to save the current tty struct so it
-		 ** may be restored on the next open.
-		 */
-		if (PortP->Store) {
-			PortP->StoredTty.iflag = tp->tm.c_iflag;
-			PortP->StoredTty.oflag = tp->tm.c_oflag;
-			PortP->StoredTty.cflag = tp->tm.c_cflag;
-			PortP->StoredTty.lflag = tp->tm.c_lflag;
-			PortP->StoredTty.line = tp->tm.c_line;
-			for (i = 0; i < NCC + 1; i++)
-				PortP->StoredTty.cc[i] = tp->tm.c_cc[i];
-		}
-	}
-
-	changed = (tp->tm.c_cflag != old_cflag) || (tp->tm.c_iflag != old_iflag) || (tp->tm.c_oflag != old_oflag);
-
-	PortP->CookMode = RIOCookMode(tp);	/* Set new cooking mode */
-
-	rio_dprintk(RIO_DEBUG_TTY, "RIOIoctl changed %d newcook %d oldcook %d\n", changed, PortP->CookMode, oldcook);
-
-#ifdef MODEM_SUPPORT
-	/*
-	 ** kludge to force CARR_ON if CLOCAL set
-	 */
-	if ((tp->tm.c_cflag & CLOCAL) || (PortP->ModemState & MSVR1_CD)) {
-		tp->tm.c_state |= CARR_ON;
-		wakeup((caddr_t) & tp->tm.c_canq);
-	}
-#endif
-
-	if (p->RIOHalted) {
-		RIOClearUp(PortP);
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		pseterr(EIO);
-		return 0;
-	}
-	/*
-	 ** Re-configure if modes or cooking have changed
-	 */
-	if (changed || oldcook != PortP->CookMode || (ioctl_processed)) {
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		rio_dprintk(RIO_DEBUG_TTY, "Ioctl changing the PORT settings\n");
-		RIOParam(PortP, CONFIG, Modem, OK_TO_SLEEP);
-		rio_spin_lock_irqsave(&PortP->portSem, flags);
-	}
-
-	if (p->RIOHalted) {
-		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		RIOClearUp(PortP);
-		pseterr(EIO);
-		return 0;
-	}
-	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-	return 0;
-}
-
-/*
-	ttyseth -- set hardware dependent tty settings
-*/
-void ttyseth(PortP, s, sg)
-struct Port *PortP;
-struct ttystatics *s;
-struct old_sgttyb *sg;
-{
-	struct old_sgttyb *tsg;
-	struct termios *tp = &s->tm;
-
-	tsg = &s->sg;
-
-	if (sg->sg_flags & (EVENP | ODDP)) {
-		tp->c_cflag &= PARENB;
-		if (sg->sg_flags & EVENP) {
-			if (sg->sg_flags & ODDP) {
-				tp->c_cflag &= V_CS7;
-				tp->c_cflag &= ~PARENB;
-			} else {
-				tp->c_cflag &= V_CS7;
-				tp->c_cflag &= PARENB;
-				tp->c_cflag &= PARODD;
-			}
-		} else if (sg->sg_flags & ODDP) {
-			tp->c_cflag &= V_CS7;
-			tp->c_cflag &= PARENB;
-			tp->c_cflag &= PARODD;
-		} else {
-			tp->c_cflag &= V_CS7;
-			tp->c_cflag &= PARENB;
-		}
-	}
-/*
- * Use ispeed as the desired speed.  Most implementations don't handle 
- * separate input and output speeds very well. If the RIO handles this, 
- * I will have to use separate sets of flags to store them in the 
- * Port structure.
- */
-	if (!sg->sg_ospeed)
-		sg->sg_ospeed = sg->sg_ispeed;
-	else
-		sg->sg_ispeed = sg->sg_ospeed;
-	if (sg->sg_ispeed > V_EXTB)
-		sg->sg_ispeed = V_EXTB;
-	if (sg->sg_ispeed < V_B0)
-		sg->sg_ispeed = V_B0;
-	*tsg = *sg;
-	tp->c_cflag = (tp->c_cflag & ~V_CBAUD) | conv_bv[(int) sg->sg_ispeed];
-}
-
-/*
-	ttyseth_pv -- set hardware dependent tty settings using either the
-			POSIX termios structure or the System V termio structure.
-				sysv = 0 => (POSIX):	 struct termios *sg
-				sysv != 0 => (System V): struct termio *sg
-*/
-static void ttyseth_pv(PortP, s, sg, sysv)
-struct Port *PortP;
-struct ttystatics *s;
-struct termios *sg;
-int sysv;
-{
-	int speed;
-	unsigned char csize;
-	unsigned char cread;
-	unsigned int lcr_flags;
-	int ps;
-
-	if (sysv) {
-		/* sg points to a System V termio structure */
-		csize = ((struct termio *) sg)->c_cflag & CSIZE;
-		cread = ((struct termio *) sg)->c_cflag & CREAD;
-		speed = conv_vb[((struct termio *) sg)->c_cflag & V_CBAUD];
-	} else {
-		/* sg points to a POSIX termios structure */
-		csize = sg->c_cflag & CSIZE;
-		cread = sg->c_cflag & CREAD;
-		speed = conv_vb[sg->c_cflag & V_CBAUD];
-	}
-	if (s->sg.sg_ispeed != speed || s->sg.sg_ospeed != speed) {
-		s->sg.sg_ispeed = speed;
-		s->sg.sg_ospeed = speed;
-		s->tm.c_cflag = (s->tm.c_cflag & ~V_CBAUD) | conv_bv[(int) s->sg.sg_ispeed];
-	}
-}
-#endif

