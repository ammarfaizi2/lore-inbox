Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269897AbRHMHRY>; Mon, 13 Aug 2001 03:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269900AbRHMHRP>; Mon, 13 Aug 2001 03:17:15 -0400
Received: from [195.211.46.202] ([195.211.46.202]:9596 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S269897AbRHMHQ6>;
	Mon, 13 Aug 2001 03:16:58 -0400
Date: Mon, 13 Aug 2001 08:27:22 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Gregory Ade <gkade@bigbrother.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: [PATCH] Re: 2.4.8 compile error on sparc
In-Reply-To: <Pine.LNX.4.31.0108121651250.8416-100000@tigger.unnerving.org>
Message-ID: <Pine.LNX.4.33.0108130822270.4372-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Gregory Ade wrote:

> Hello.  Just downloaded linux-2.4.8.tar.bz2 and tried to build it on my
> SPARCstation 5 running SuSE Linux 7.1 for sparc.
...
> extable.c:60: `modlist_lock' undeclared (first use in this function)
> make[2]: Leaving directory `/usr/src/linux-2.4.8/arch/sparc/mm'

Apply this patch which is from sparc64:

--- linux-2.4.8/arch/sparc/mm/extable.c~	Fri Aug 10 19:57:54 2001
+++ linux-2.4.8/arch/sparc/mm/extable.c	Mon Aug 13 08:22:54 2001
@@ -43,6 +43,8 @@
         return 0;
 }

+extern spinlock_t modlist_lock;
+
 unsigned long
 search_exception_table(unsigned long addr, unsigned long *g2)
 {


After that I still get undefined .udiv/.umul symbols from depmod? Somebody
said it was a bug in depmod, but I hadn't had the time to check if it
boots.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

