Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293465AbSBZCEn>; Mon, 25 Feb 2002 21:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293467AbSBZCEe>; Mon, 25 Feb 2002 21:04:34 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:39554 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S293465AbSBZCEO>;
	Mon, 25 Feb 2002 21:04:14 -0500
Date: Mon, 25 Feb 2002 21:04:16 -0500
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Submissions for 2.4.19-pre [slab estimate optimization (Balbir Singh)]
Message-Id: <20020225210416.3ad105fd.me@ohdarn.net>
Organization: OhDarn.net
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth of several mails containing patches to be included in 2.4.19.  Some are worthy of dicussion prior to inclusion and have been marked as such.  The majority of these patches were found on lkml; the remaining ones have URLs listed.

This one originated on lkml some months ago.

------
Michael Cohen
OhDarn.net

--- linux-virgin/mm/slab.c	Sun Jan 13 18:02:18 2002
+++ linux-wli/mm/slab.c	Sun Jan 13 18:02:01 2002
@@ -397,10 +397,10 @@
 		base = sizeof(slab_t);
 		extra = sizeof(kmem_bufctl_t);
 	}
-	i = 0;
+       i = (wastage - base)/(size + extra);
 	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
 		i++;
-	if (i > 0)
+       while (i*size + L1_CACHE_ALIGN(base+i*extra) > wastage)
 		i--;
 
 	if (i > SLAB_LIMIT)
