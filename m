Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270098AbTGUN4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270104AbTGUN4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:56:55 -0400
Received: from iere.net.avaya.com ([198.152.12.101]:48534 "EHLO
	iere.net.avaya.com") by vger.kernel.org with ESMTP id S270098AbTGUN4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:56:37 -0400
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>, "David Hinds" <dhinds@sonic.net>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <fischer@norbit.de>, <dahinds@users.sourceforge.net>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Subject: Marcelo, please apply [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel2.4.22-pre6
Date: Mon, 21 Jul 2003 08:11:37 -0600
Message-ID: <021a01c34f91$ffe6e4c0$6e260987@rnd.avaya.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_021B_01C34F5F.B54C74C0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: 
X-OriginalArrivalTime: 21 Jul 2003 14:11:37.0933 (UTC) FILETIME=[FFF0CFD0:01C34F91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_021B_01C34F5F.B54C74C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Marcelo,

David Hinds approves of this patch (Thanks, Dave!). Please apply to 2.4.22

Thanks!

- Bhavesh
--
Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
Avaya Inc.           Phone/Fax : (303) 538-4438
Room B3-B03, 1300 West 120th Avenue
Westminster, CO 80234

-------David Hind's reply------------
From: David Hinds [dhinds@sonic.net]
Sent: Saturday, July 19, 2003 3:32 PM
To: Bhavesh P. Davda
Subject: Re: [PATCH] AHA152x driver hangs on PCMCIA card eject,
kernel2.4.22-pre6

On Thu, Jul 17, 2003 at 02:29:05PM -0600, Bhavesh P. Davda wrote:
>
> Attached is a patch that takes into account comments I have received in
> response to the original patch I posted. Please peruse it, and if it looks
> okay, please recommend that Marcelo pick it up for 2.4.22.

It looks ok to me.  You can go ahead and send to Marcelo.

-- Dave
-------------------------------------

> -----Original Message-----
> From: Bhavesh P. Davda
> Sent: Thursday, July 17, 2003 2:29 PM
> To: David Hinds
> Cc: Alan Cox; Linux Kernel Mailing List; fischer@norbit.de;
> dahinds@users.sourceforge.net; Marcelo Tosatti
> Subject: RE: [PATCH] AHA152x driver hangs on PCMCIA card eject,
> kernel2.4.22-pre6
>
>
> > -----Original Message-----
> > From: David Hinds [mailto:dhinds@sonic.net]
> > Sent: Thursday, July 17, 2003 11:56 AM
> > To: Bhavesh P. Davda
> > Cc: Alan Cox; Linux Kernel Mailing List; fischer@norbit.de;
> > dahinds@users.sourceforge.net; Marcelo Tosatti
> > Subject: Re: [PATCH] AHA152x driver hangs on PCMCIA card eject,
> > kernel2.4.22-pre6
> >
> >
> > On Thu, Jul 17, 2003 at 08:15:39AM -0600, Bhavesh P. Davda wrote:
> >
> > > > Right - scsi_unregister should not be called on a timer
> event, instead
> > > > it needs to kick off a task queue
> >
> > The removal timers need to be taken out from most *_cs drivers; they
> > are a holdover from when card removal events were delivered in
> > interrupt context, and when that was changed to an event handler
> > thread, drivers were not changed accordingly.  The removal routine
> > should now just be called in-line instead of firing up a timer.
> >
> > > 2. What happens if there is no physical device hanging off an I/O port
> > > address? I am guessing, that on an i386 host, the inb returns
> > 0xFF, but am
> > > not sure what happens on other architectures. I have a question
> > outstanding
> > > to Intel for this.
> >
> > On most but not all x86 systems floating ports return 0xff.  Checking
> > for that or other "impossible" register values should be at least
> > harmless on other architectures.
> >
> > -- Dave
>
> Thank you, Dave!
>
> Attached is a patch that takes into account comments I have
> received in response to the original patch I posted. Please
> peruse it, and if it looks okay, please recommend that Marcelo
> pick it up for 2.4.22.
>
> FYI, I have tested this patch on a PIII/440BX with a TI1225 based
> PCMCIA card reader and Adaptec SlimSCSI 1460D SCSI adapter card
> connected to a Fujitsu SCSI MO drive.
>
> Thanks!
>
> - Bhavesh
> --
> Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
> Avaya Inc.           Phone/Fax : (303) 538-4438
> Room B3-B03, 1300 West 120th Avenue
> Westminster, CO 80234
>

------=_NextPart_000_021B_01C34F5F.B54C74C0
Content-Type: application/octet-stream;
	name="linux-2.4.22-aha152x.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.22-aha152x.patch"

diff -Naur linux-2.4.22-pre6/drivers/scsi/aha152x.c =
linux-2.4.22-bpd/drivers/scsi/aha152x.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/aha152x.c	2003-06-13 =
08:51:36.000000000 -0600=0A=
+++ linux-2.4.22-bpd/drivers/scsi/aha152x.c	2003-07-15 =
16:05:09.000000000 -0600=0A=
@@ -1930,12 +1930,30 @@=0A=
 static void intr(int irqno, void *dev_id, struct pt_regs *regs)=0A=
 {=0A=
 	struct Scsi_Host *shpnt =3D lookup_irq(irqno);=0A=
+	unsigned char rev, dmacntrl0;=0A=
 =0A=
 	if (!shpnt) {=0A=
 		printk(KERN_ERR "aha152x: catched interrupt %d for unknown =
controller.\n", irqno);=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * Read a couple of registers that are known to not be all 1's. If=0A=
+	 * we read all 1's (-1), that means that either:=0A=
+	 * a. The host adapter chip has gone bad, and we cannot control it,=0A=
+	 * OR=0A=
+	 * b. The host adapter is a PCMCIA card that has been ejected=0A=
+	 * In either case, we cannot do anything with the host adapter at=0A=
+	 * this point in time. So just ignore the interrupt and return.=0A=
+	 * In the latter case, the interrupt might actually be meant for=0A=
+	 * someone else sharing this IRQ, and that driver will handle it=0A=
+	 */=0A=
+	rev =3D GETPORT(REV);=0A=
+	dmacntrl0 =3D GETPORT(DMACNTRL0);=0A=
+	if ((rev =3D=3D 0xFF) && (dmacntrl0 =3D=3D 0xFF)) {=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	/* no more interrupts from the controller, while we're busy.=0A=
 	   INTEN is restored by the BH handler */=0A=
 	CLRBITS(DMACNTRL0, INTEN);=0A=
diff -Naur linux-2.4.22-pre6/drivers/scsi/pcmcia/aha152x_stub.c =
linux-2.4.22-bpd/drivers/scsi/pcmcia/aha152x_stub.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/pcmcia/aha152x_stub.c	2001-12-21 =
10:41:55.000000000 -0700=0A=
+++ linux-2.4.22-bpd/drivers/scsi/pcmcia/aha152x_stub.c	2003-07-17 =
14:03:03.000000000 -0600=0A=
@@ -40,7 +40,6 @@=0A=
 #include <linux/sched.h>=0A=
 #include <linux/slab.h>=0A=
 #include <linux/string.h>=0A=
-#include <linux/timer.h>=0A=
 #include <linux/ioport.h>=0A=
 #include <scsi/scsi.h>=0A=
 #include <linux/major.h>=0A=
@@ -139,8 +138,6 @@=0A=
     if (!info) return NULL;=0A=
     memset(info, 0, sizeof(*info));=0A=
     link =3D &info->link; link->priv =3D info;=0A=
-    link->release.function =3D &aha152x_release_cs;=0A=
-    link->release.data =3D (u_long)link;=0A=
 =0A=
     link->io.NumPorts1 =3D 0x20;=0A=
     link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;=0A=
@@ -193,7 +190,6 @@=0A=
     if (*linkp =3D=3D NULL)=0A=
 	return;=0A=
 =0A=
-    del_timer(&link->release);=0A=
     if (link->state & DEV_CONFIG) {=0A=
 	aha152x_release_cs((u_long)link);=0A=
 	if (link->state & DEV_STALE_CONFIG) {=0A=
@@ -383,7 +379,7 @@=0A=
     case CS_EVENT_CARD_REMOVAL:=0A=
 	link->state &=3D ~DEV_PRESENT;=0A=
 	if (link->state & DEV_CONFIG)=0A=
-	    mod_timer(&link->release, jiffies + HZ/20);=0A=
+	    aha152x_release_cs((u_long)link);=0A=
 	break;=0A=
     case CS_EVENT_CARD_INSERTION:=0A=
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;=0A=
diff -Naur linux-2.4.22-pre6/drivers/scsi/pcmcia/fdomain_stub.c =
linux-2.4.22-bpd/drivers/scsi/pcmcia/fdomain_stub.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/pcmcia/fdomain_stub.c	2001-12-21 =
10:41:55.000000000 -0700=0A=
+++ linux-2.4.22-bpd/drivers/scsi/pcmcia/fdomain_stub.c	2003-07-17 =
14:04:36.000000000 -0600=0A=
@@ -37,7 +37,6 @@=0A=
 #include <linux/sched.h>=0A=
 #include <linux/slab.h>=0A=
 #include <linux/string.h>=0A=
-#include <linux/timer.h>=0A=
 #include <linux/ioport.h>=0A=
 #include <scsi/scsi.h>=0A=
 #include <linux/major.h>=0A=
@@ -125,8 +124,6 @@=0A=
     if (!info) return NULL;=0A=
     memset(info, 0, sizeof(*info));=0A=
     link =3D &info->link; link->priv =3D info;=0A=
-    link->release.function =3D &fdomain_release;=0A=
-    link->release.data =3D (u_long)link;=0A=
 =0A=
     link->io.NumPorts1 =3D 0x10;=0A=
     link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;=0A=
@@ -179,7 +176,6 @@=0A=
     if (*linkp =3D=3D NULL)=0A=
 	return;=0A=
 =0A=
-    del_timer(&link->release);=0A=
     if (link->state & DEV_CONFIG) {=0A=
 	fdomain_release((u_long)link);=0A=
 	if (link->state & DEV_STALE_CONFIG) {=0A=
@@ -350,7 +346,7 @@=0A=
     case CS_EVENT_CARD_REMOVAL:=0A=
 	link->state &=3D ~DEV_PRESENT;=0A=
 	if (link->state & DEV_CONFIG)=0A=
-	    mod_timer(&link->release, jiffies + HZ/20);=0A=
+	    fdomain_release((u_long)link);=0A=
 	break;=0A=
     case CS_EVENT_CARD_INSERTION:=0A=
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;=0A=
diff -Naur linux-2.4.22-pre6/drivers/scsi/pcmcia/nsp_cs.c =
linux-2.4.22-bpd/drivers/scsi/pcmcia/nsp_cs.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/pcmcia/nsp_cs.c	2003-06-13 =
08:51:36.000000000 -0600=0A=
+++ linux-2.4.22-bpd/drivers/scsi/pcmcia/nsp_cs.c	2003-07-17 =
14:07:43.000000000 -0600=0A=
@@ -36,7 +36,6 @@=0A=
 #include <linux/sched.h>=0A=
 #include <linux/slab.h>=0A=
 #include <linux/string.h>=0A=
-#include <linux/timer.h>=0A=
 #include <linux/ioport.h>=0A=
 #include <linux/delay.h>=0A=
 #include <linux/tqueue.h>=0A=
@@ -1341,10 +1340,6 @@=0A=
 	link =3D &info->link;=0A=
 	link->priv =3D info;=0A=
 =0A=
-	/* Initialize the dev_link_t structure */=0A=
-	link->release.function	 =3D &nsp_cs_release;=0A=
-	link->release.data	 =3D (u_long)link;=0A=
-=0A=
 	/* The io structure describes IO port mapping */=0A=
 	link->io.NumPorts1	 =3D 0x10;=0A=
 	link->io.Attributes1	 =3D IO_DATA_PATH_WIDTH_AUTO;=0A=
@@ -1415,7 +1410,6 @@=0A=
 		return;=0A=
 	}=0A=
 =0A=
-	del_timer(&link->release);=0A=
 	if (link->state & DEV_CONFIG) {=0A=
 		nsp_cs_release((u_long)link);=0A=
 		if (link->state & DEV_STALE_CONFIG) {=0A=
@@ -1660,7 +1654,7 @@=0A=
 		link->state &=3D ~DEV_PRESENT;=0A=
 		if (link->state & DEV_CONFIG) {=0A=
 			((scsi_info_t *)link->priv)->stop =3D 1;=0A=
-			mod_timer(&link->release, jiffies + HZ/20);=0A=
+			nsp_cs_release((u_long)link);=0A=
 		}=0A=
 		break;=0A=
 =0A=
diff -Naur linux-2.4.22-pre6/drivers/scsi/pcmcia/qlogic_stub.c =
linux-2.4.22-bpd/drivers/scsi/pcmcia/qlogic_stub.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/pcmcia/qlogic_stub.c	2001-12-21 =
10:41:55.000000000 -0700=0A=
+++ linux-2.4.22-bpd/drivers/scsi/pcmcia/qlogic_stub.c	2003-07-17 =
14:05:36.000000000 -0600=0A=
@@ -37,7 +37,6 @@=0A=
 #include <linux/sched.h>=0A=
 #include <linux/slab.h>=0A=
 #include <linux/string.h>=0A=
-#include <linux/timer.h>=0A=
 #include <linux/ioport.h>=0A=
 #include <asm/io.h>=0A=
 #include <asm/byteorder.h>=0A=
@@ -132,8 +131,6 @@=0A=
     if (!info) return NULL;=0A=
     memset(info, 0, sizeof(*info));=0A=
     link =3D &info->link; link->priv =3D info;=0A=
-    link->release.function =3D &qlogic_release;=0A=
-    link->release.data =3D (u_long)link;=0A=
 =0A=
     link->io.NumPorts1 =3D 16;=0A=
     link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;=0A=
@@ -186,7 +183,6 @@=0A=
     if (*linkp =3D=3D NULL)=0A=
 	return;=0A=
 =0A=
-    del_timer(&link->release);=0A=
     if (link->state & DEV_CONFIG) {=0A=
 	qlogic_release((u_long)link);=0A=
 	if (link->state & DEV_STALE_CONFIG) {=0A=
@@ -371,7 +367,7 @@=0A=
     case CS_EVENT_CARD_REMOVAL:=0A=
 	link->state &=3D ~DEV_PRESENT;=0A=
 	if (link->state & DEV_CONFIG)=0A=
-	    mod_timer(&link->release, jiffies + HZ/20);=0A=
+	    qlogic_release((u_long)link);=0A=
 	break;=0A=
     case CS_EVENT_CARD_INSERTION:=0A=
 	link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;=0A=

------=_NextPart_000_021B_01C34F5F.B54C74C0--

