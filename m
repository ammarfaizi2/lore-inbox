Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTIBP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTIBPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:20:15 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:25330 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263868AbTIBPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:19:21 -0400
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
From: Martin Schlemmer <azarah@gentoo.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       LKML <linux-kernel@vger.kernel.org>, cgoos@syskonnect.de,
       mlindner@syskonnect.de, linux@syskonnect.de
In-Reply-To: <200309020920.08259.m.c.p@wolk-project.de>
References: <20030719013223.GA31330@dualathlon.random>
	 <3F1C763E.78D67BC3@eyal.emu.id.au>
	 <20030901234600.GA11503@dualathlon.random>
	 <200309020920.08259.m.c.p@wolk-project.de>
Content-Type: text/plain
Message-Id: <1062515375.14727.51.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Sep 2003 17:09:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 09:20, Marc-Christian Petersen wrote:
> On Tuesday 02 September 2003 01:46, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.22-pre7-aa1/kernel/drivers/net/sk98lin/sk98lin.o
> > > depmod:         __udivdi3
> > There are several functions triggering this problem, and it's a mainline
> > 2.4 problem (I don't see anything specific to my tree).
> > I'm CCing the authors of the driver, is there a new version or are we the
> > first triggering it? I can fix it myself but I'd prefer to avoid any
> > duplication since it's not a one liner.
> 
> the problem is _was_ the sk98lin driver, but this problem is gone for a very 
> long time now. 2.4.23-pre* will get an update in the next days with sk98lin 
> v6.17 (current 6.02 is in mainline) and the problem is gone with it.
> 
> Or at least, I don't get the unresolved symbols problem with it ;)
> 

Below is the patch that was used for 2.5 - might be the same
thing.  I don't know who posted it originally though, Andrew
might be able to help out with that as he posted it when I
tried to port the drivers back then ...

--------------------------
diff -puN drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix
drivers/net/sk98lin/h/skgepnm2.h
--- 25/drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix  Thu Mar  6
16:18:07 2003
+++ 25-akpm/drivers/net/sk98lin/h/skgepnm2.h    Thu Mar  6 16:18:07 2003
@@ -341,7 +341,7 @@ typedef struct s_PnmiStatAddr {
 #if SK_TICKS_PER_SEC == 100
 #define SK_PNMI_HUNDREDS_SEC(t)        (t)
 #else
-#define SK_PNMI_HUNDREDS_SEC(t)        (((t) * 100) /
(SK_TICKS_PER_SEC))
+#define SK_PNMI_HUNDREDS_SEC(t)        ((((long)t) * 100) /
(SK_TICKS_PER_SEC))
 #endif
 
 /*


-- 
Martin Schlemmer


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2003-09-02 at 09:20, Marc-Christian Petersen wrote:
> On Tuesday 02 September 2003 01:46, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.22-pre7-aa1/kernel/drivers/net/sk98lin/sk98lin.o
> > > depmod:         __udivdi3
> > There are several functions triggering this problem, and it's a mainline
> > 2.4 problem (I don't see anything specific to my tree).
> > I'm CCing the authors of the driver, is there a new version or are we the
> > first triggering it? I can fix it myself but I'd prefer to avoid any
> > duplication since it's not a one liner.
> 
> the problem is _was_ the sk98lin driver, but this problem is gone for a very 
> long time now. 2.4.23-pre* will get an update in the next days with sk98lin 
> v6.17 (current 6.02 is in mainline) and the problem is gone with it.
> 
> Or at least, I don't get the unresolved symbols problem with it ;)
> 

Below is the patch that was used for 2.5 - might be the same
thing.  I don't know who posted it originally though, Andrew
might be able to help out with that as he posted it when I
tried to port the drivers back then ...

--------------------------
diff -puN drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix
drivers/net/sk98lin/h/skgepnm2.h
--- 25/drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix  Thu Mar  6
16:18:07 2003
+++ 25-akpm/drivers/net/sk98lin/h/skgepnm2.h    Thu Mar  6 16:18:07 2003
@@ -341,7 +341,7 @@ typedef struct s_PnmiStatAddr {
 #if SK_TICKS_PER_SEC == 100
 #define SK_PNMI_HUNDREDS_SEC(t)        (t)
 #else
-#define SK_PNMI_HUNDREDS_SEC(t)        (((t) * 100) /
(SK_TICKS_PER_SEC))
+#define SK_PNMI_HUNDREDS_SEC(t)        ((((long)t) * 100) /
(SK_TICKS_PER_SEC))
 #endif
 
 /*


-- 
Martin Schlemmer


