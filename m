Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTIIXib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbTIIXib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:38:31 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:64497
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264978AbTIIXi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:38:29 -0400
Message-ID: <3F5E646F.23ECE187@eyal.emu.id.au>
Date: Wed, 10 Sep 2003 09:38:23 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_PCMCIA_WL3501 build fails
References: <Pine.LNX.4.44.0309091009210.17041-100000@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------65D004434BBDF2A45A65DED1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------65D004434BBDF2A45A65DED1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 9 Sep 2003, Russell King wrote:
> 
> > On Tue, Sep 09, 2003 at 10:12:11PM +1000, Eyal Lebedinsky wrote:
> > > allmodconfig, i386:
> > >
> > >   CC [M]  drivers/net/wireless/wl3501_cs.o
> > > drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_join':
> > > drivers/net/wireless/wl3501_cs.c:641: unknown field `id' specified in
> > > initializer
> >
> > I notice that this driver uses .foo.bar = baz type initialisers.  These
> > do not work on gcc 2.95 (and last time I checked, the kernels minimum
> > compiler version was still 2.95.x)
> 
> Yeah, the ".foo.bar = baz" thing should go. Something like the following,
> but it would be good to have somebody verify that this was all of it and
> that it actually works.

You should also then patch __FUNCTION__ to comply with 2.95 gcc.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------65D004434BBDF2A45A65DED1
Content-Type: text/plain; charset=us-ascii;
 name="2.6.0-test5.wl3501-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.0-test5.wl3501-2.patch"

--- linux/drivers/net/wireless/wl3501_cs.c.old	Wed Sep 10 09:32:49 2003
+++ linux/drivers/net/wireless/wl3501_cs.c	Wed Sep 10 09:30:49 2003
@@ -82,7 +82,7 @@
 MODULE_PARM(pc_debug, "i");
 #define dprintk(n, format, args...) \
 	{ if (pc_debug > (n)) \
-		printk(KERN_INFO "%s: " format "\n", __FUNCTION__, ##args); }
+		printk(KERN_INFO "%s: " format "\n", __FUNCTION__ , ##args); }
 #else
 #define dprintk(n, format, args...)
 #endif

--------------65D004434BBDF2A45A65DED1--

