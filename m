Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTIOG5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTIOG5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:57:41 -0400
Received: from ns.suse.de ([195.135.220.2]:19149 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262451AbTIOG5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:57:37 -0400
Date: Mon, 15 Sep 2003 08:57:34 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: ISDN kcapi.c no longer compiles
Message-ID: <20030915065734.GA5134@pingi3.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	isdn4linux@listserv.isdn4linux.de,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <20030910165742.GG27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910165742.GG27368@fs.tum.de>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-58-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
