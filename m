Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJRSbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJRSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:31:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39412 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261877AbTJRSbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:31:32 -0400
Date: Sat, 18 Oct 2003 20:31:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Karsten Keil <kkeil@suse.de>, isdn4linux@listserv.isdn4linux.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: ISDN kcapi.c no longer compiles (fwd)
Message-ID: <20031018183124.GK12423@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below by Karsten Keil is still needed in 
-test8.

Please apply
Adrian


----- Forwarded message from Karsten Keil <kkeil@suse.de> -----

Date:	Mon, 15 Sep 2003 08:57:34 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: isdn4linux@listserv.isdn4linux.de,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: ISDN kcapi.c no longer compiles

On Wed, Sep 10, 2003 at 06:57:42PM +0200, Adrian Bunk wrote:
> On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.6.0-test4 to v2.6.0-test5
> > ============================================
> >...
> > Karsten Keil:
> >...
> >   o next fixes
> >...
> 
> It seems this change broke the compilation of kcapi.c:
> 

Ah, with your .config now it's clear what was broken: none MODULE compile

diff -ur -x '.built-in*' -x '.*cmd' linux-2.6.0-test5/drivers/isdn/capi/kcapi.c linux-2.6.0-test5-bk3/drivers/isdn/capi/kcapi.c
--- linux-2.6.0-test5/drivers/isdn/capi/kcapi.c	2003-09-14 17:43:45.000000000 +0200
+++ linux-2.6.0-test5-bk3/drivers/isdn/capi/kcapi.c	2003-09-14 22:39:28.000000000 +0200
@@ -77,17 +77,21 @@
 static inline struct capi_ctr *
 capi_ctr_get(struct capi_ctr *card)
 {
+#ifdef MODULE
 	if (!try_module_get(card->owner))
 		return NULL;
 	DBG("Reserve module: %s", card->owner->name);
+#endif
 	return card;
 }
 
 static inline void
 capi_ctr_put(struct capi_ctr *card)
 {
+#ifdef MODULE
 	module_put(card->owner);
 	DBG("Release module: %s", card->owner->name);
+#endif
 }
 
 /* ------------------------------------------------------------- */


This should fix it.

-- 
Karsten Keil
SuSE Labs
ISDN development
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

