Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261922AbTCQTcG>; Mon, 17 Mar 2003 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbTCQTcG>; Mon, 17 Mar 2003 14:32:06 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:58001 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261922AbTCQTcE>; Mon, 17 Mar 2003 14:32:04 -0500
Date: Mon, 17 Mar 2003 20:42:31 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Vitezslav Samel <samel@mail.cz>
cc: Matthew Wilcox <willy@debian.org>, Eric Piel <Eric.Piel@Bull.Net>,
       <davidm@hpl.hp.com>, <linux-ia64@linuxia64.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [BUG & WORKAROUND] nanosleep() granularity bumps up in 2.5.64
In-Reply-To: <Pine.LNX.4.33.0303171445110.23224-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0303172033150.25119-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Tim Schmielau wrote:

> On Mon, 17 Mar 2003, Vitezslav Samel wrote:
>
> >   The nanosleep() bug narrowed down to 2.5.63-bk2. That's version, the "initial
> > jiffies" patch went in. And yes, it's on i686 machine.
>
> You can easily check whether it's connected with this change by setting
> INITIAL_JIFFIES to zero. This should exactly recover the previous
> situation.

OK. I've done the test myself and I plead guilty. As a temporary
workaround you can apply the following patch:


--- linux-2.5.64/include/linux/time.h.orig	Wed Mar  5 04:29:24 2003
+++ linux-2.5.64/include/linux/time.h	Mon Mar 17 20:31:06 2003
@@ -31,7 +31,7 @@
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
-#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
+#define INITIAL_JIFFIES 0

 /*
  * Change timeval to jiffies, trying to avoid the


Still, after half an hour of glancing at the code I can't see my mistake.
I've re-checked that the problem does not occur with the original "initial
jiffies" patch for 2.4. So I must have missed a (subtle?) difference
between 2.4 and 2.5 when I did the forward-port.

Sorry,
Tim

