Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVAOCMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVAOCMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVAOCMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:12:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51436 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262115AbVAOCLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:11:48 -0500
Date: Fri, 14 Jan 2005 21:17:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Steffen Moser <lists@steffen-moser.de>
Cc: linux-kernel@vger.kernel.org, David Dyck <david.dyck@fluke.com>
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050114231712.GH3336@logos.cnet>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114225555.GA17714@steffen-moser.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David, this also fix your problem.

On Fri, Jan 14, 2005 at 11:55:55PM +0100, Steffen Moser wrote:
> Hi Marcelo,
> 
> * On Wed, Jan 12, 2005 at 01:13 PM (-0200), Marcelo Tosatti wrote:
> 
> > Here goes the second release candidate of v2.4.29.
> 
> I've just encountered a little problem with both "linux-2.4.29-rc1" 
> and "linux-2.4.29-rc2" on one of two machines. 
> 
> 
> [1.] One line summary of the problem: 
> 
> Kernel module "serial.o" cannot be loaded
> 
> 
> [2.] Full description of the problem/report:
> 
> I cannot load the module "serial.o" anymore, so I won't have serial 
> port support (which is needed to have the machine communicating with
> the UPS):
> 
>  | fsa01:~ # modprobe serial
>  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_ldisc_flush
>  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_wakeup
>  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o failed
>  | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod serial failed

Steffen, 

Please try this:

--- a/drivers/char/tty_io.c.orig	2005-01-14 21:11:58.002189784 -0200
+++ b/drivers/char/tty_io.c	2005-01-14 21:12:53.743715784 -0200
@@ -718,7 +718,7 @@
 	wake_up_interruptible(&tty->write_wait);
 }
 
-EXPORT_SYMBOL_GPL(tty_wakeup);
+EXPORT_SYMBOL(tty_wakeup);
 
 void tty_ldisc_flush(struct tty_struct *tty)
 {
@@ -730,7 +730,7 @@
 	}
 }
 
-EXPORT_SYMBOL_GPL(tty_ldisc_flush);
+EXPORT_SYMBOL(tty_ldisc_flush);
 
 void do_tty_hagup(void *data)
 {
