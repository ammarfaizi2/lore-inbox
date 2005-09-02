Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVIBXa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVIBXa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVIBXa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:30:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14820 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751037AbVIBXa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:30:56 -0400
Date: Sat, 3 Sep 2005 00:30:53 +0100
From: viro@ZenIV.linux.org.uk
To: "David S. Miller" <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more of sparc32 dependencies fallout
Message-ID: <20050902233053.GF5155@ZenIV.linux.org.uk>
References: <20050902191201.GB5155@ZenIV.linux.org.uk> <1125692648.30867.35.camel@localhost.localdomain> <20050902.130343.53230378.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902.130343.53230378.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 01:03:43PM -0700, David S. Miller wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: [PATCH] more of sparc32 dependencies fallout
> Date: Fri, 02 Sep 2005 21:24:08 +0100
> 
> > On Gwe, 2005-09-02 at 20:12 +0100, viro@ZenIV.linux.org.uk wrote:
> > >  config MOXA_SMARTIO
> > >  	tristate "Moxa SmartIO support"
> > > -	depends on SERIAL_NONSTANDARD
> > > +	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
> > >  	help
> > 
> > 
> > Why mark it "BROKEN" and !SPARC32. Why not mark it (ISA || PCI) ? Its
> > only available as a plugin card and its apparently working
> 
> He marked it BROKEN "OR" !SPARC32, not "AND".
> Also, SPARC32 supports PCI on Javastation machines.

Actually, proper fix of that breakage is embarrassingly simple - it's yet
another gratitious leftover include of asm/segment.h, so incremental to the
previos would be removal of that BROKEN and removal of bogus include from
mxser.c itself.

diff -urN RC13-git3-base/drivers/char/Kconfig current/drivers/char/Kconfig
--- RC13-git3-base/drivers/char/Kconfig	2005-09-02 14:16:04.000000000 -0400
+++ current/drivers/char/Kconfig	2005-09-02 19:20:11.000000000 -0400
@@ -175,7 +175,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
+	depends on SERIAL_NONSTANDARD
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
diff -urN RC13-git3-base/drivers/char/mxser.c current/drivers/char/mxser.c
--- RC13-git3-base/drivers/char/mxser.c	2005-06-17 15:48:29.000000000 -0400
+++ current/drivers/char/mxser.c	2005-09-02 19:20:05.000000000 -0400
@@ -63,7 +63,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
