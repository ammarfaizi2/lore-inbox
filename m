Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289697AbSAOWOO>; Tue, 15 Jan 2002 17:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289698AbSAOWOE>; Tue, 15 Jan 2002 17:14:04 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:2176
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S289697AbSAOWNq>; Tue, 15 Jan 2002 17:13:46 -0500
Date: Tue, 15 Jan 2002 14:13:36 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
Message-ID: <Pine.LNX.4.33.0201151409270.1744-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf,

After applying your patch to 2.5.2, my named wouldn't start up (it
couldn't bind to port 921)

The below patch seems to have fixed that, and I think is probably the
right thing to do.

Index: net/ipv4/af_inet.c
===================================================================
RCS file: /mnt/white/cvsroot/linux/net/ipv4/af_inet.c,v
retrieving revision 1.2
diff -u -r1.2 af_inet.c
--- net/ipv4/af_inet.c	2002/01/15 21:20:02	1.2
+++ net/ipv4/af_inet.c	2002/01/15 22:04:00
@@ -511,7 +511,7 @@

 	snum = ntohs(addr->sin_port);
 #ifdef CONFIG_ACCESS_FS
-	if (snum && snum < PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC))
+	if (snum && snum < PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC) && !capable(CAP_NET_BIND_SERVICE))
 #else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
 #endif


