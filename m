Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSFTCSJ>; Wed, 19 Jun 2002 22:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318098AbSFTCSI>; Wed, 19 Jun 2002 22:18:08 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27337 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318097AbSFTCSH>;
	Wed, 19 Jun 2002 22:18:07 -0400
Date: Thu, 20 Jun 2002 12:18:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Missing tqueue.h in drivers/char/genrtc.c
Message-ID: <20020620021840.GB9326@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This fixes a compile problem on PPC in
drivers/char/genrtc.c.  It needs struct tq_struct, defined in
tqueue.h, which must formerly have been indirectly included.  With the
recent removal of a bunch of includes, it isn't.  This patch includes
it directly.

diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/char/genrtc.c linux-bluefish/drivers/char/genrtc.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/char/genrtc.c	Fri Jun 14 10:15:07 2002
+++ linux-bluefish/drivers/char/genrtc.c	Thu Jun 20 12:01:52 2002
@@ -47,6 +47,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
+#include <linux/tqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
