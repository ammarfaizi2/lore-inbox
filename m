Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTJXAoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJXAoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:44:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:40155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261901AbTJXAoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:44:16 -0400
Date: Thu, 23 Oct 2003 17:44:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: kdrader@us.ibm.com, linux-kernel@vger.kernel.org, pberger@brimson.com,
       borchers@steinerpoint.com
Subject: Re: [PATCH][2.6.0-test7] digi_acceleport.c has bogus "address of"
 operator
Message-Id: <20031023174433.77770988.akpm@osdl.org>
In-Reply-To: <20031024000750.GE21734@kroah.com>
References: <20031016054821.GA22005@us.ibm.com>
	<20031024000750.GE21734@kroah.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Wed, Oct 15, 2003 at 10:48:21PM -0700, Kurtis D. Rader wrote:
> > 
> > === diff -rup drivers/usb/serial/digi_acceleport.c.orig drivers/usb/serial/digi_acceleport.c
> > --- drivers/usb/serial/digi_acceleport.c.orig   2003-10-15 22:03:26.000000000 -0700
> > +++ drivers/usb/serial/digi_acceleport.c        2003-10-15 21:10:21.000000000 -0700
> 
> This patch does not apply.  It looks like the tabs are converted to
> spaces.  Can you send it to me again, so that I can apply it?

It was applied.  But it added a compile-time warning, which this
fixes:


diff -puN drivers/usb/serial/digi_acceleport.c~digi_acceleport-warning-fix drivers/usb/serial/digi_acceleport.c
--- 25/drivers/usb/serial/digi_acceleport.c~digi_acceleport-warning-fix	2003-10-23 03:21:03.000000000 -0700
+++ 25-akpm/drivers/usb/serial/digi_acceleport.c	2003-10-23 03:21:40.000000000 -0700
@@ -444,7 +444,7 @@ struct digi_port {
 /* Local Function Declarations */
 
 static void digi_wakeup_write( struct usb_serial_port *port );
-static void digi_wakeup_write_lock( struct usb_serial_port *port );
+static void digi_wakeup_write_lock(void *);
 static int digi_write_oob_command( struct usb_serial_port *port,
 	unsigned char *buf, int count, int interruptible );
 static int digi_write_inb_command( struct usb_serial_port *port,
@@ -608,9 +608,9 @@ static inline long cond_wait_interruptib
 *  on writes.
 */
 
-static void digi_wakeup_write_lock( struct usb_serial_port *port )
+static void digi_wakeup_write_lock(void *arg)
 {
-
+	struct usb_serial_port *port = arg;
 	unsigned long flags;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 

_

