Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVHNKBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVHNKBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVHNKBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:01:13 -0400
Received: from nic.upatras.gr ([150.140.129.30]:45024 "HELO nic.upatras.gr")
	by vger.kernel.org with SMTP id S932471AbVHNKBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:01:13 -0400
From: Michael Iatrou <m.iatrou@freemail.gr>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] configurable debug info from radeonfb old driver
Date: Sun, 14 Aug 2005 13:01:48 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com
References: <200508140118.27921.m.iatrou@freemail.gr> <20050814012506.79987caf.akpm@osdl.org>
In-Reply-To: <20050814012506.79987caf.akpm@osdl.org>
X-Face: *8Gl!va:8&HzlgC%IRQaxD*[{;>3OMj];U1I;[rtNn@,hA7h/cTR1!!0J`koxA2)=?utf-8?q?xj=7ELd9=0A=09N4LpVN=24=5CaU=27r?=<dFtnPd*,?d&u_g_kAnTwdv>2l}1-ae/$k1heNY.:5"9IYPy>X$msqG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141301.49640.m.iatrou@freemail.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the date was Sunday 14 August 2005 11:25, Andrew Morton wrote:

> Michael Iatrou <m.iatrou@freemail.gr> wrote:
> >
> > Hi,
> > 
> > Currently, radeonfb old driver always prints debugging informations. This 
> > patch makes debug info reporting configurable.
> >  
> > 
> > diff -urN linux-2.6.13-rc6/drivers/video/Kconfig linux-2.6.13-rc6.new/drivers/video/Kconfig
> > --- linux-2.6.13-rc6/drivers/video/Kconfig      2005-08-14 00:48:34.000000000 +0300
> > +++ linux-2.6.13-rc6.new/drivers/video/Kconfig  2005-08-14 00:54:10.000000000 +0300
> > @@ -936,6 +936,15 @@
> >           There is a product page at
> >           <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
> > 
> > +config FB_RADEON_OLD_DEBUG
> > +    bool "Enable debug output from Old Radeon driver"
> > +    depends on FB_RADEON_OLD
> > +    default n
> > +    help
> > +      Say Y here if you want the Radeon driver to output all sorts
> > +      of debugging informations to provide to the maintainer when
> > +      something goes wrong.
> > +
> >  config FB_RADEON
> >         tristate "ATI Radeon display support"
> >         depends on FB && PCI
> > diff -urN linux-2.6.13-rc6/drivers/video/radeonfb.c linux-2.6.13-rc6.new/drivers/video/radeonfb.c
> > --- linux-2.6.13-rc6/drivers/video/radeonfb.c   2005-06-19 14:49:29.000000000 +0300
> > +++ linux-2.6.13-rc6.new/drivers/video/radeonfb.c       2005-08-14 00:55:16.000000000 +0300
> > @@ -80,7 +80,11 @@
> >  #include <video/radeon.h>
> >  #include <linux/radeonfb.h>
> > 
> > -#define DEBUG  1
> > +#ifdef CONFIG_FB_RADEON_OLD_DEBUG
> > +#define DEBUG       1
> > +#else
> > +#define DEBUG       0
> > +#endif
> > 
> >  #if DEBUG
> >  #define RTRACE         printk
> 
> That's probably a bit fancier than we really need.  How about we just set
> DEBUG to zero?
 
That's an option too.

diff -urN linux-2.6.13-rc6/drivers/video/radeonfb.c linux-2.6.13-rc6.new/drivers/video/radeonfb.c
--- linux-2.6.13-rc6/drivers/video/radeonfb.c   2005-06-19 14:49:29.000000000 +0300
+++ linux-2.6.13-rc6.new/drivers/video/radeonfb.c       2005-08-14 12:58:10.000000000 +0300
@@ -80,7 +80,7 @@
 #include <video/radeon.h>
 #include <linux/radeonfb.h>

-#define DEBUG  1
+#define DEBUG  0

 #if DEBUG
 #define RTRACE         printk

-- 
 Michael Iatrou
