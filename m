Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSHWPsh>; Fri, 23 Aug 2002 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSHWPsh>; Fri, 23 Aug 2002 11:48:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19974 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318851AbSHWPsg>; Fri, 23 Aug 2002 11:48:36 -0400
Date: Fri, 23 Aug 2002 12:52:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: conman@kolivas.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Combined performance patches update for 2.4.19
In-Reply-To: <1030111826.3d6642520a757@kolivas.net>
Message-ID: <Pine.LNX.4.44L.0208231251330.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002 conman@kolivas.net wrote:
> Quoting Rik van Riel <riel@conectiva.com.br>:
> > On Fri, 23 Aug 2002 conman@kolivas.net wrote:
> >
> > > I've completed merging the following patches:
> > >
> > > O(1) scheduler
> > > Preemptible
> > > Low latency
> >
> > Could I interest you in the -rmap VM ? ;)
> >
> > http://surriel.com/patches/
>
> Sure I'll give it a go, but it might kill me trying :P

OK, here's a little patch to be able to combine rmap and preempt.

have fun,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


===== include/linux/mm.h 1.47 vs edited =====
--- 1.47/include/linux/mm.h	Tue Aug  6 15:59:20 2002
+++ edited/include/linux/mm.h	Fri Aug 23 12:48:44 2002
@@ -337,6 +337,7 @@
 	 * busywait with less bus contention for a good time to
 	 * attempt to acquire the lock bit.
 	 */
+	preempt_disable();
 #ifdef CONFIG_SMP
 	while (test_and_set_bit(PG_chainlock, &page->flags)) {
 		while (test_bit(PG_chainlock, &page->flags))
@@ -350,6 +351,7 @@
 #ifdef CONFIG_SMP
 	clear_bit(PG_chainlock, &page->flags);
 #endif
+	preempt_enable();
 }

 /*

