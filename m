Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbTCVIMb>; Sat, 22 Mar 2003 03:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbTCVIMb>; Sat, 22 Mar 2003 03:12:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10967 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262054AbTCVIMa>; Sat, 22 Mar 2003 03:12:30 -0500
Date: Sat, 22 Mar 2003 09:23:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-ac3: 3c527.c doesn't compile
Message-ID: <20030322082329.GW6940@fs.tum.de>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com> <20030307210323.GD19615@fs.tum.de> <1047072894.3444.22.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047072894.3444.22.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:34:52PM -0600, James Bottomley wrote:
> On Fri, 2003-03-07 at 15:03, Adrian Bunk wrote:
> > On Fri, Mar 07, 2003 at 12:56:44PM -0500, Alan Cox wrote:
> > 
> > >...
> > > Linux 2.5.64-ac2
> > >...
> > > o	Update 3c527 to modern locking (untested)	(James Bottomley)
> > >...
> > 
> > It seems even the compilation is untested?
> 
> It builds for me fine in 2.5.64.  Perhaps you misapplied the patch, or
> got a mangled one.  The correct patch is below.

The patch in your mail was empty.

The problem is still present in 2.5.65-ac2, is the patch below correct?

> James

cu
Adrian

--- linux-2.5.65-ac2/drivers/net/3c527.c.old	2003-03-22 09:19:39.000000000 +0100
+++ linux-2.5.65-ac2/drivers/net/3c527.c	2003-03-22 09:20:44.000000000 +0100
@@ -624,7 +624,8 @@
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	int ioaddr = dev->base_addr;
 	int ret = 0;
-	
+	unsigned long flags;
+
 	/*
 	 *	Wait for a command
 	 */
@@ -729,6 +730,7 @@
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	int ioaddr = dev->base_addr;
+	unsigned long flags;
 
 	spin_lock_irqsave(&lp->lock, flags);
 
@@ -948,7 +950,7 @@
 	u8 one=1;
 	u8 regs;
 	u16 descnumbuffs[2] = {TX_RING_LEN, RX_RING_LEN};
-	unsigned_long flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&lp->lock, flags);
 
