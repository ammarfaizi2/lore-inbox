Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUAMAXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUAMAXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:23:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47058 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263244AbUAMAXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:23:30 -0500
Date: Tue, 13 Jan 2004 01:23:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix a drivers/char/isicom.c compile warning
Message-ID: <20040113002318.GV9677@fs.tum.de>
References: <20040113000055.GU9677@fs.tum.de> <20040113001746.GN18853@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113001746.GN18853@conectiva.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 10:17:46PM -0200, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 13, 2004 at 01:00:56AM +0100, Adrian Bunk escreveu:
>...
> > The following patch fixes this issue:
> > 
> > 
> > --- linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c.old	2004-01-13 00:40:02.000000000 +0100
> > +++ linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c	2004-01-13 00:49:00.000000000 +0100
> > @@ -1675,7 +1675,7 @@
> >  static void unregister_drivers(void)
> >  {
> >  	int error;
> > -	if (tty_unregister_driver(isicom_normal))
> > +	if ((error=tty_unregister_driver(isicom_normal)))
> >  		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
> 
> OK, the patch is right, but couldn't we take the opportunity to make this
> more readable while at it? Ssomething like:
> 
> static void unregister_drivers(void)
> {
>         int error = tty_unregister_driver(isicom_normal);
> 
>         if (error)
> 		printk(KERN_DEBUG "ISICOM: couldn't unregister normal "
> 				  "driver error=%d.\n", error);
> 
> ? :-)

I thought about it, but I wasn't sure whether changing a driver to be 
more readable in _one_ place and making the code there different from 
the coding style used in the rest of the driver is really an 
improvement (and no, I don't want to clean the whole driver...)?

> - Arnaldo

cu
Adrian

--- linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c.old	2004-01-13 00:40:02.000000000 +0100
+++ linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c	2004-01-13 01:21:15.000000000 +0100
@@ -1674,9 +1674,11 @@
 
 static void unregister_drivers(void)
 {
-	int error;
-	if (tty_unregister_driver(isicom_normal))
+	int error = tty_unregister_driver(isicom_normal);
+
+	if (error)
 		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
+
 	put_tty_driver(isicom_normal);
 }
 
