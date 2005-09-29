Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVI2QxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVI2QxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVI2QxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:53:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53921 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932244AbVI2QxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:53:03 -0400
Date: Thu, 29 Sep 2005 17:52:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rio: switch to ANSI prototypes
Message-ID: <20050929165259.GV7992@ftp.linux.org.uk>
References: <20050929152208.GA18132@mipter.zuzino.mipt.ru> <20050929152556.GU7992@ftp.linux.org.uk> <20050929165236.GC18132@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929165236.GC18132@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 08:52:36PM +0400, Alexey Dobriyan wrote:
> On Thu, Sep 29, 2005 at 04:25:56PM +0100, Al Viro wrote:
> > Uh-oh...  Well, if you want to play with it...  FWIW, I'm disabling rio as
> > hopeless FPOS; if you feel masochistic, go ahead but keep in mind that its
> > handling of tty glue is severely b0rken.
> 
> Well, duh... It clutters _my_ logs.

diff -urN RC13-git12-nfs-endian/drivers/char/Kconfig RC13-git12-rio/drivers/char/Kconfig
--- RC13-git12-nfs-endian/drivers/char/Kconfig	2005-09-10 15:41:34.000000000 -0400
+++ RC13-git12-rio/drivers/char/Kconfig	2005-09-12 14:50:05.000000000 -0400
@@ -282,12 +282,13 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && BROKEN
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
 	  information is at <http://www.perle.com/support/documentation.html#multiport>.
 	  There are both ISA and PCI versions.
+	  Note that while card might be smart, driver most certainly isn't.
 
 config RIO_OLDPCI
 	bool "Support really old RIO/PCI cards"

had solved that one nicely for me (and that's the only driver that got
such treatment - this FPOS is really something special).

> > Use of caddr_t is *always* broken.
> 
> "unsigned long arg" or do you keep in mind something more fundamental? 

In this case - unsigned long, in other...  Some are <something> __user *,
some are <something> __iomem *, some are simply void *...
