Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUFHQwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUFHQwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUFHQwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:52:36 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:16806 "EHLO
	relay.wittsend.org") by vger.kernel.org with ESMTP id S265257AbUFHQvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:51:46 -0400
Date: Tue, 8 Jun 2004 12:51:13 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Sharon <sharon@sysman.co.za>, linux-kernel@vger.kernel.org
Cc: mhw@wittsend.com
Subject: Re: Computone Intelliport II and Linux 9.0
Message-ID: <20040608165113.GD20947@alcove.wittsend.com>
Mail-Followup-To: Sharon <sharon@sysman.co.za>,
	linux-kernel@vger.kernel.org
References: <003801c44d4a$8451d290$d2fefedf@sharonm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <003801c44d4a$8451d290$d2fefedf@sharonm>
User-Agent: Mutt/1.4i
X-Alcove.WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-Alcove.WittsEnd-MailScanner: Found to be clean
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: multipart/mixed; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sharron,

	I hope you don't mind, but I've added the Linux Kernel developers
list to the Cc on this list in a effort to get this patch integrated into
the 2.4 kernel.  The patch has been languishing for months, now, in
spite of several requests to Marcello.

	I also just found out that I had been bounced (again) from the mail
lists at vger (probably an outage at my MX server, again) so I had to
resubscribe.  I see from the archives that I missed a couple of Computone
problem reports a while back, as well.  All this same problem.  :-(

On Tue, Jun 08, 2004 at 01:19:50PM +0200, Sharon wrote:
> Hi,
> I am trying to get a PCI Computone Intellport II card working on Linux 9.0
> (2.4.20-8).

	The lastest kernel for RedHat 9 is 2.4.20-31.9.  I would
strongly recommend upgrading.  There are probably security issues
that need to be addressed.

> I use modprobe ip2 irq=3D0 io=3D1 and the board flashes green.

	First recommendation.  Please do not set irq=3D0.  That places
that board (your first and, maybe, only board) in polling mode.  Polling
mode is not well tested, especially with PCI cards (io=3D1) and may
have some timing problems over and above the known problem.  I don't
personally use it.  It's really a hold over from old days when the
IRQ subsystem in that driver didn't work very well (before I took over
as maintainer and long before it was included in the kernel source tree).

> When I insert the entries into /etc/inittab and execute init q.
> I get Oops errors. ( if you need the exact error I will copy it for you)
> Do you know if there is a patch that I can load to correct this error? If=
 so
> where do I get it from and how do I load it?

	Yes, there is a patch.  I've sent it to Marcello several times
now at several of his E-Mail addresses.  I don't know if any of them
are still good or if he's just so swamped that he hasn't been able to
look at it.  This is a known problem on fast CPU boards.  I can go into
a lot of technical details but the bottom line is that the problem has
been known about for a long time.  I've sent a patch to everyone reporting
the problem and not a single person has reported any problem with the
patch and several people reported that the Oops error was solved.  The
problem only occurs on fast CPUs (>400 MHz and aggravated by SMP)
because of the speed of the CPU in relation to the speed of the processor
on the Computone board itself creating a timing condition and busy board
deadlock condition.  The original fix for that problem is what's causing
the Oopps on even faster CPU's.

	For some really strange reason, that I've never been able to
ascertain, the Opps problem seems to show up on RedHat kernels but
rarely (I've never seen it) on vanilla kernel.org kernels.  What is
the causal agent, there, that's aggravating the problem, I don't know.

	Since I haven't been able to catch Marcello's attention, in spite
of my being the official maintainer of this driver, I'm spamming the kernel
mailing list with the patch(s) in the faint hope of catching someone's
attention.

	Attached to this message are two flavors of the patch for this
problem.  The patch "linux-2.4.22.diff" actually patches the RedHat
2.4.20 kernel sources (all flavors) perfectly.  I've checked it against
2.4.20-30.9 and it patched cleanly with no fuzz or offsets.  Please try
that.  Just cd into the kernel source directory and apply it with a
"patch -p1 < .../linux-2.4.22.diff" and then rebuild your custom kernel.

	The other patch, patch-2.4.26ct.diff, is the diff against the
2.4.26 kernel source tree.  Will someone PLEASE integrate this into the
sources or at least tell me why they can't?  I've been requesting this
since the 2.4.22 sources, and it still hasn't been integrated and I
haven't heard a peep about why or why not.  I can only assume that
the direct E-Mail messages never got read.

> I would also like to know how I can change the device names to be preceded
> with 00. In other words I require that they get sorted as
> F000,F001,F002,F003,F004 .. F010,F011 and not F0,F1,F10,F11
> ...F2,F22,F23....etc because the device names are not sorted numerically
> correctly with the physical positions on the 16 port Clusters.

	If you are not using devfs, you can do this with a simple shell
script renaming the files in /dev/ttyF*.  If you are using devfs, I would
recommend strongly against it.  With devfs, you would be better off
creating symlinks from somewhere else.  That being said, I usually
advise against people "prettying things up" like this.  In this particular
case, it makes no difference, since the names are just strings (with
devfs, they are actually in the source code, though).  I've seen people
make the mistake of doing this with IP addresses and getting royally
burned when they discover that 010.000.000.001 !=3D 10.0.0.1 and is really
8.0.0.1 (010 is octal and equal to 8 decimal).  It certainly shouldn't
do any harm to rename the character device files in /dev to whatever
convention you desire.

> Thanks
> Sharon

	Sorry for the problem.  Let me know how the patch works out!

	Thanks!
	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.22.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.4.22.orig/Documentation/computone.txt linux-2.4.22/Docume=
ntation/computone.txt
--- linux-2.4.22.orig/Documentation/computone.txt	Fri Nov  2 20:26:17 2001
+++ linux-2.4.22/Documentation/computone.txt	Wed Nov  5 21:38:18 2003
@@ -6,8 +6,8 @@
 These notes are for the drivers which have already been integrated into the
 kernel and have been tested on Linux kernels 2.0, 2.2, 2.3, and 2.4.
=20
-Version: 1.2.14
-Date: 11/01/2001
+Version: 1.2.16
+Date: 11/05/2003
 Historical Author: Andrew Manison <amanison@america.net>
 Primary Author: Doug McNash
 Support: support@computone.com
@@ -26,7 +26,7 @@
 products previous to the Intelliport II.
=20
 This driver was developed on the v2.0.x Linux tree and has been tested up
-to v2.4.14; it will probably not work with earlier v1.X kernels,.
+to v2.4.22; it will probably not work with earlier v1.X kernels,.
=20
=20
 2. QUICK INSTALLATION
diff -urN linux-2.4.22.orig/drivers/char/ip2/i2ellis.h linux-2.4.22/drivers=
/char/ip2/i2ellis.h
--- linux-2.4.22.orig/drivers/char/ip2/i2ellis.h	Wed Oct 24 15:05:18 2001
+++ linux-2.4.22/drivers/char/ip2/i2ellis.h	Wed Nov  5 21:36:12 2003
@@ -403,7 +403,7 @@
 //	For queuing interupt bottom half handlers.	/\/\|=3Dmhw=3D|\/\/
 	struct tq_struct	tqueue_interrupt;
=20
-	struct timer_list  SendPendingTimer;   // Used by iiSendPending
+//	struct timer_list  SendPendingTimer;   // Used by iiSendPending
 	unsigned int	SendPendingRetry;
=20
 #ifdef	CONFIG_DEVFS_FS
diff -urN linux-2.4.22.orig/drivers/char/ip2/i2lib.c linux-2.4.22/drivers/c=
har/ip2/i2lib.c
--- linux-2.4.22.orig/drivers/char/ip2/i2lib.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.22/drivers/char/ip2/i2lib.c	Wed Nov  5 21:36:12 2003
@@ -164,6 +164,7 @@
 {
 	if (pB->i2eOutMailWaiting && (!pB->i2eWaitingForEmptyFifo) )
 	{
+//	    while( pB->SendPendingRetry < 32 ) {
 		if (iiTrySendMail(pB, pB->i2eOutMailWaiting))
 		{
 			/* If we were already waiting for fifo to empty,
@@ -174,8 +175,13 @@
 			pB->i2eWaitingForEmptyFifo |=3D
 				(pB->i2eOutMailWaiting & MB_OUT_STUFFED);
 			pB->i2eOutMailWaiting =3D 0;
+			if( pB->SendPendingRetry ) {
+				printk( KERN_DEBUG "IP2: iiSendPendingMail: busy board pickup on %d\n"=
, pB->SendPendingRetry );
+			}
 			pB->SendPendingRetry =3D 0;
+//			break;
 		} else {
+#ifdef	IP2_USE_TIMER_WAIT
 /*		The only time we hit this area is when "iiTrySendMail" has
 		failed.  That only occurs when the outbound mailbox is
 		still busy with the last message.  We take a short breather
@@ -193,7 +199,13 @@
 			} else {
 				printk( KERN_ERR "IP2: iiSendPendingMail unable to queue outbound mail=
\n" );
 			}
+#endif
+			pB->SendPendingRetry++;
+			if( 0 =3D=3D ( pB->SendPendingRetry % 8 ) ) {
+				printk( KERN_ERR "IP2: iiSendPendingMail: board busy, retry %d\n", pB-=
>SendPendingRetry );
+			}
 		}
+//	    }
 	}
 }
=20
@@ -1329,8 +1341,9 @@
 	remove_wait_queue(&(pCh->pBookmarkWait), &wait);
=20
 	// if expires =3D=3D 0 then timer poped, then do not need to del_timer
+	// jiffy wrap per Tim Schmielau (tim@physik3.uni-rostock.de)
 	if ((timeout > 0) && pCh->BookmarkTimer.expires &&=20
-	                     time_before(jiffies, pCh->BookmarkTimer.expires)) {
+			time_before(jiffies, pCh->BookmarkTimer.expires)) {
 		del_timer( &(pCh->BookmarkTimer) );
 		pCh->BookmarkTimer.expires =3D 0;
=20
diff -urN linux-2.4.22.orig/drivers/char/ip2main.c linux-2.4.22/drivers/cha=
r/ip2main.c
--- linux-2.4.22.orig/drivers/char/ip2main.c	Thu Nov 28 18:53:12 2002
+++ linux-2.4.22/drivers/char/ip2main.c	Wed Nov  5 21:36:12 2003
@@ -19,6 +19,15 @@
 //
 // Done:
 //
+// 1.2.16	/\/\|=3Dmhw=3D|\/\/
+// Yet another shot at the busy board timing window (use the poll timer).
+// 	Because of this, the poll timer is always enabled...
+// Cleaned up some comments on immediate interrupt mode (ppp code elsewhere
+// 	has been fixed and the new busy board logic won't throw a hairball).
+//
+// 1.2.15	dmc
+// Fixed jiffy wrap, PCI card may now be set to poll.
+//
 // 1.2.14	/\/\|=3Dmhw=3D|\/\/
 // Added bounds checking to ip2_ipl_ioctl to avoid potential terroristic a=
cts.
 // Changed the definition of ip2trace to be more consistant with kernel st=
yle
@@ -227,7 +236,7 @@
=20
 /* String constants to identify ourselves */
 static char *pcName    =3D "Computone IntelliPort Plus multiport driver";
-static char *pcVersion =3D "1.2.14";
+static char *pcVersion =3D "1.2.16";
=20
 /* String constants for port names */
 static char *pcDriver_name   =3D "ip2";
@@ -437,7 +446,7 @@
 	}
 	return 0;
 }
-#endif
+#endif /* MODULE */
=20
 static int __init
 have_requested_irq( char irq )
@@ -604,17 +613,12 @@
 		if (iop) {
 			ip2config.addr[i] =3D iop[i];
 			if (irqp) {
-				if( irqp[i] >=3D 0 ) {
-					ip2config.irq[i] =3D irqp[i];
-				} else {
-					ip2config.irq[i] =3D 0;
-				}
+				ip2config.irq[i] =3D irqp[i];
 	// This is a little bit of a hack.  If poll_only=3D1 on command
 	// line back in ip2.c OR all IRQs on all specified boards are
 	// explicitly set to 0, then drop to poll only mode and override
 	// PCI or EISA interrupts.  This superceeds the old hack of
 	// triggering if all interrupts were zero (like da default).
-	// Still a hack but less prone to random acts of terrorism.
 	//
 	// What we really should do, now that the IRQ default is set
 	// to -1, is to use 0 as a hard coded, do not probe.
@@ -700,17 +704,12 @@
 					} else {
 						printk( KERN_ERR "IP2: PCI I/O address error\n");
 					}
-					pcibios_read_config_byte(pci_bus, pci_devfn,
+					if (ip2config.irq[i] !=3D 0) {
+						pcibios_read_config_byte(pci_bus, pci_devfn,
 								  PCI_INTERRUPT_LINE, &pci_irq);
=20
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
-
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq =3D 0;
-//					}
-					ip2config.irq[i] =3D pci_irq;
+						ip2config.irq[i] =3D pci_irq;
+					}
 				} else {	// ann error
 					ip2config.addr[i] =3D 0;
 					if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
@@ -737,17 +736,12 @@
 					} else {
 						printk( KERN_ERR "IP2: PCI I/O address error\n");
 					}
-					status =3D
-					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+					if (ip2config.irq[i] !=3D 0) {
+						status =3D
+						pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
=20
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
-
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq =3D 0;
-//					}
-					ip2config.irq[i] =3D pci_irq;
+						ip2config.irq[i] =3D pci_irq;
+					}
 				} else {	// ann error
 					ip2config.addr[i] =3D 0;
 					if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
@@ -934,6 +928,11 @@
 			}
 #endif
=20
+//			Kick the timer on for stuck board safeties...
+			PollTimer.expires =3D POLL_TIMEOUT;
+			add_timer ( &PollTimer );
+			TimerOn =3D 1;
+
 			if (poll_only) {
 //		Poll only forces driver to only use polling and
 //		to ignore the probed PCI or EISA interrupts.
@@ -988,7 +987,7 @@
 static void __init
 ip2_init_board( int boardnum )
 {
-	int i,rc;
+	int i, rc=3D0;
 	int nports =3D 0, nboxes =3D 0;
 	i2ChanStrPtr pCh;
 	i2eBordStrPtr pB =3D i2BoardPtrTable[boardnum];
@@ -1375,8 +1374,10 @@
=20
 //		Only process those boards which match our IRQ.
 //			IRQ =3D 0 for polled boards, we won't poll "IRQ" boards
+//		Add an additional "check" if the irq is zero for boards
+//		which are "stuck"
=20
-		if ( pB && (pB->i2eUsingIrq =3D=3D irq) ) {
+		if ( pB && ( pB->i2eUsingIrq =3D=3D irq || ( 0 =3D=3D irq && 0 !=3D pB->=
SendPendingRetry ) ) ) {
 #ifdef USE_IQI
=20
 		    if (NO_MAIL_HERE !=3D ( pB->i2eStartMail =3D iiGetMail(pB))) {
@@ -1391,9 +1392,8 @@
 			mark_bh(IMMEDIATE_BH);
 		    }
 #else
-//		We are using immediate servicing here.  This sucks and can
-//		cause all sorts of havoc with ppp and others.  The failsafe
-//		check on iiSendPendingMail could also throw a hairball.
+//		We are using immediate servicing here.  Suboptimal
+//			to say the least...
 			i2ServiceBoard( pB );
 #endif /* USE_IQI */
 		}
@@ -1417,6 +1417,9 @@
 static void
 ip2_poll(unsigned long arg)
 {
+	int i;
+	i2eBordStrPtr  pB;
+
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 100, 0 );
=20
 	TimerOn =3D 0; // it's the truth but not checked in service
@@ -1424,7 +1427,15 @@
 	// Just polled boards, IRQ =3D 0 will hit all non-interrupt boards.
 	// It will NOT poll boards handled by hard interrupts.
 	// The issue of queued BH interrups is handled in ip2_interrupt().
-	ip2_interrupt(0, NULL, NULL);
+
+	for( i =3D 0; i < i2nBoards; ++i ) {
+		pB =3D i2BoardPtrTable[i];
+	// Service the board if the irq indicates a polled board
+	// OR if the SendPendingRetry indicates a retry state in the board
+		if ( pB && ( 0 =3D=3D pB->i2eUsingIrq || 0 !=3D pB->SendPendingRetry ) )=
 {
+			i2ServiceBoard( pB );
+		}
+	}
=20
 	PollTimer.expires =3D POLL_TIMEOUT;
 	add_timer( &PollTimer );

--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.26ct.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.4.26/Documentation/computone.txt linux-2.4.26ct/Documenta=
tion/computone.txt
--- linux-2.4.26/Documentation/computone.txt	2001-11-02 20:26:17.000000000 =
-0500
+++ linux-2.4.26ct/Documentation/computone.txt	2004-06-08 12:18:27.15278759=
1 -0400
@@ -6,8 +6,8 @@
 These notes are for the drivers which have already been integrated into the
 kernel and have been tested on Linux kernels 2.0, 2.2, 2.3, and 2.4.
=20
-Version: 1.2.14
-Date: 11/01/2001
+Version: 1.2.16
+Date: 11/05/2003
 Historical Author: Andrew Manison <amanison@america.net>
 Primary Author: Doug McNash
 Support: support@computone.com
@@ -26,7 +26,7 @@
 products previous to the Intelliport II.
=20
 This driver was developed on the v2.0.x Linux tree and has been tested up
-to v2.4.14; it will probably not work with earlier v1.X kernels,.
+to v2.4.22; it will probably not work with earlier v1.X kernels,.
=20
=20
 2. QUICK INSTALLATION
diff -urN linux-2.4.26/drivers/char/ip2/i2ellis.h linux-2.4.26ct/drivers/ch=
ar/ip2/i2ellis.h
--- linux-2.4.26/drivers/char/ip2/i2ellis.h	2001-10-24 15:05:18.000000000 -=
0400
+++ linux-2.4.26ct/drivers/char/ip2/i2ellis.h	2004-06-08 12:18:27.153787455=
 -0400
@@ -403,7 +403,7 @@
 //	For queuing interupt bottom half handlers.	/\/\|=3Dmhw=3D|\/\/
 	struct tq_struct	tqueue_interrupt;
=20
-	struct timer_list  SendPendingTimer;   // Used by iiSendPending
+//	struct timer_list  SendPendingTimer;   // Used by iiSendPending
 	unsigned int	SendPendingRetry;
=20
 #ifdef	CONFIG_DEVFS_FS
diff -urN linux-2.4.26/drivers/char/ip2/i2lib.c linux-2.4.26ct/drivers/char=
/ip2/i2lib.c
--- linux-2.4.26/drivers/char/ip2/i2lib.c	2002-08-02 20:39:43.000000000 -04=
00
+++ linux-2.4.26ct/drivers/char/ip2/i2lib.c	2004-06-08 12:18:27.154787319 -=
0400
@@ -164,6 +164,7 @@
 {
 	if (pB->i2eOutMailWaiting && (!pB->i2eWaitingForEmptyFifo) )
 	{
+//	    while( pB->SendPendingRetry < 32 ) {
 		if (iiTrySendMail(pB, pB->i2eOutMailWaiting))
 		{
 			/* If we were already waiting for fifo to empty,
@@ -174,8 +175,13 @@
 			pB->i2eWaitingForEmptyFifo |=3D
 				(pB->i2eOutMailWaiting & MB_OUT_STUFFED);
 			pB->i2eOutMailWaiting =3D 0;
+			if( pB->SendPendingRetry ) {
+				printk( KERN_DEBUG "IP2: iiSendPendingMail: busy board pickup on %d\n"=
, pB->SendPendingRetry );
+			}
 			pB->SendPendingRetry =3D 0;
+//			break;
 		} else {
+#ifdef	IP2_USE_TIMER_WAIT
 /*		The only time we hit this area is when "iiTrySendMail" has
 		failed.  That only occurs when the outbound mailbox is
 		still busy with the last message.  We take a short breather
@@ -193,7 +199,13 @@
 			} else {
 				printk( KERN_ERR "IP2: iiSendPendingMail unable to queue outbound mail=
\n" );
 			}
+#endif
+			pB->SendPendingRetry++;
+			if( 0 =3D=3D ( pB->SendPendingRetry % 8 ) ) {
+				printk( KERN_ERR "IP2: iiSendPendingMail: board busy, retry %d\n", pB-=
>SendPendingRetry );
+			}
 		}
+//	    }
 	}
 }
=20
@@ -1329,8 +1341,9 @@
 	remove_wait_queue(&(pCh->pBookmarkWait), &wait);
=20
 	// if expires =3D=3D 0 then timer poped, then do not need to del_timer
+	// jiffy wrap per Tim Schmielau (tim@physik3.uni-rostock.de)
 	if ((timeout > 0) && pCh->BookmarkTimer.expires &&=20
-	                     time_before(jiffies, pCh->BookmarkTimer.expires)) {
+			time_before(jiffies, pCh->BookmarkTimer.expires)) {
 		del_timer( &(pCh->BookmarkTimer) );
 		pCh->BookmarkTimer.expires =3D 0;
=20
diff -urN linux-2.4.26/drivers/char/ip2main.c linux-2.4.26ct/drivers/char/i=
p2main.c
--- linux-2.4.26/drivers/char/ip2main.c	2003-11-28 13:26:20.000000000 -0500
+++ linux-2.4.26ct/drivers/char/ip2main.c	2004-06-08 12:18:27.157786912 -04=
00
@@ -19,6 +19,15 @@
 //
 // Done:
 //
+// 1.2.16	/\/\|=3Dmhw=3D|\/\/
+// Yet another shot at the busy board timing window (use the poll timer).
+// 	Because of this, the poll timer is always enabled...
+// Cleaned up some comments on immediate interrupt mode (ppp code elsewhere
+// 	has been fixed and the new busy board logic won't throw a hairball).
+//
+// 1.2.15	dmc
+// Fixed jiffy wrap, PCI card may now be set to poll.
+//
 // 1.2.14	/\/\|=3Dmhw=3D|\/\/
 // Added bounds checking to ip2_ipl_ioctl to avoid potential terroristic a=
cts.
 // Changed the definition of ip2trace to be more consistant with kernel st=
yle
@@ -227,7 +236,7 @@
=20
 /* String constants to identify ourselves */
 static char *pcName    =3D "Computone IntelliPort Plus multiport driver";
-static char *pcVersion =3D "1.2.14";
+static char *pcVersion =3D "1.2.16";
=20
 /* String constants for port names */
 static char *pcDriver_name   =3D "ip2";
@@ -437,7 +446,7 @@
 	}
 	return 0;
 }
-#endif
+#endif /* MODULE */
=20
 static int __init
 have_requested_irq( char irq )
@@ -604,17 +613,12 @@
 		if (iop) {
 			ip2config.addr[i] =3D iop[i];
 			if (irqp) {
-				if( irqp[i] >=3D 0 ) {
-					ip2config.irq[i] =3D irqp[i];
-				} else {
-					ip2config.irq[i] =3D 0;
-				}
+				ip2config.irq[i] =3D irqp[i];
 	// This is a little bit of a hack.  If poll_only=3D1 on command
 	// line back in ip2.c OR all IRQs on all specified boards are
 	// explicitly set to 0, then drop to poll only mode and override
 	// PCI or EISA interrupts.  This superceeds the old hack of
 	// triggering if all interrupts were zero (like da default).
-	// Still a hack but less prone to random acts of terrorism.
 	//
 	// What we really should do, now that the IRQ default is set
 	// to -1, is to use 0 as a hard coded, do not probe.
@@ -700,17 +704,12 @@
 					} else {
 						printk( KERN_ERR "IP2: PCI I/O address error\n");
 					}
-					pcibios_read_config_byte(pci_bus, pci_devfn,
+					if (ip2config.irq[i] !=3D 0) {
+						pcibios_read_config_byte(pci_bus, pci_devfn,
 								  PCI_INTERRUPT_LINE, &pci_irq);
=20
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
-
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq =3D 0;
-//					}
-					ip2config.irq[i] =3D pci_irq;
+						ip2config.irq[i] =3D pci_irq;
+					}
 				} else {	// ann error
 					ip2config.addr[i] =3D 0;
 					if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
@@ -737,17 +736,12 @@
 					} else {
 						printk( KERN_ERR "IP2: PCI I/O address error\n");
 					}
-					status =3D
-					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+					if (ip2config.irq[i] !=3D 0) {
+						status =3D
+						pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
=20
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
-
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq =3D 0;
-//					}
-					ip2config.irq[i] =3D pci_irq;
+						ip2config.irq[i] =3D pci_irq;
+					}
 				} else {	// ann error
 					ip2config.addr[i] =3D 0;
 					if (status =3D=3D PCIBIOS_DEVICE_NOT_FOUND) {
@@ -934,6 +928,11 @@
 			}
 #endif
=20
+//			Kick the timer on for stuck board safeties...
+			PollTimer.expires =3D POLL_TIMEOUT;
+			add_timer ( &PollTimer );
+			TimerOn =3D 1;
+
 			if (poll_only) {
 //		Poll only forces driver to only use polling and
 //		to ignore the probed PCI or EISA interrupts.
@@ -1375,8 +1374,10 @@
=20
 //		Only process those boards which match our IRQ.
 //			IRQ =3D 0 for polled boards, we won't poll "IRQ" boards
+//		Add an additional "check" if the irq is zero for boards
+//		which are "stuck"
=20
-		if ( pB && (pB->i2eUsingIrq =3D=3D irq) ) {
+		if ( pB && ( pB->i2eUsingIrq =3D=3D irq || ( 0 =3D=3D irq && 0 !=3D pB->=
SendPendingRetry ) ) ) {
 #ifdef USE_IQI
=20
 		    if (NO_MAIL_HERE !=3D ( pB->i2eStartMail =3D iiGetMail(pB))) {
@@ -1391,9 +1392,8 @@
 			mark_bh(IMMEDIATE_BH);
 		    }
 #else
-//		We are using immediate servicing here.  This sucks and can
-//		cause all sorts of havoc with ppp and others.  The failsafe
-//		check on iiSendPendingMail could also throw a hairball.
+//		We are using immediate servicing here.  Suboptimal
+//			to say the least...
 			i2ServiceBoard( pB );
 #endif /* USE_IQI */
 		}
@@ -1417,6 +1417,9 @@
 static void
 ip2_poll(unsigned long arg)
 {
+	int i;
+	i2eBordStrPtr  pB;
+
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, 100, 0 );
=20
 	TimerOn =3D 0; // it's the truth but not checked in service
@@ -1424,7 +1427,15 @@
 	// Just polled boards, IRQ =3D 0 will hit all non-interrupt boards.
 	// It will NOT poll boards handled by hard interrupts.
 	// The issue of queued BH interrups is handled in ip2_interrupt().
-	ip2_interrupt(0, NULL, NULL);
+
+	for( i =3D 0; i < i2nBoards; ++i ) {
+		pB =3D i2BoardPtrTable[i];
+	// Service the board if the irq indicates a polled board
+	// OR if the SendPendingRetry indicates a retry state in the board
+		if ( pB && ( 0 =3D=3D pB->i2eUsingIrq || 0 !=3D pB->SendPendingRetry ) )=
 {
+			i2ServiceBoard( pB );
+		}
+	}
=20
 	PollTimer.expires =3D POLL_TIMEOUT;
 	add_timer( &PollTimer );

--0/kgSOzhNoDC5T3a--

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iQCVAwUBQMXugeHJS0bfHdRxAQEQ9wP8Dlf7XmLG+EnSaUn7YsBfkB8jeCG8EAqq
ul0w14fuJ74dag7eACGIhycF0I0stz9nNcx0Kz5s9ZUUfDsHXkVB1J1ViW2p1oNO
qlLu3q+gqj1t3ZCSIuDXJN83JfRei0rnWqlPttUWw5dcUanXCR76XAsthA6NSRE/
PfAueJCrrB4=
=kHVX
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
