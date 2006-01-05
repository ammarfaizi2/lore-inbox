Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWAEKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWAEKGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWAEKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:06:06 -0500
Received: from odin2.bull.net ([192.90.70.84]:12175 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751941AbWAEKGE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:06:04 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt4 and CONFIG_SLAB=y : structure has no member named `nodeid'
Date: Thu, 5 Jan 2006 11:12:10 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>
References: <200512211045.58763.Serge.Noiraud@bull.net>
In-Reply-To: <200512211045.58763.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Message-Id: <200601051112.10762.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 05/01/2006 11:06:52,
	Serialize by Router on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 05/01/2006 11:06:53,
	Serialize complete at 05/01/2006 11:06:53
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mercredi 21 Décembre 2005 10:45, Serge Noiraud wrote/a écrit :
> Hi,
> 
> 	testing on i386, I get the following error :
> ...
>   CC      mm/slab.o
> mm/slab.c: In function `cache_alloc_refill':
> mm/slab.c:2093: error: structure has no member named `nodeid'
> mm/slab.c: In function `free_block':
> mm/slab.c:2239: error: structure has no member named `nodeid'
> mm/slab.c:2239: error: `node' undeclared (first use in this function)
> mm/slab.c:2239: error: (Each undeclared identifier is reported only once
> mm/slab.c:2239: error: for each function it appears in.)
> make[4]: *** [mm/slab.o] Erreur 1
> ...
> 
> You removed nodeid in the slab struct, but many functions use it.
> 
I get the same problem with 2.6.15-rt1
The following patch suppress the error : I'm not sure it's the good correction.
perhaps we should supress this DEBUG test ?

--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -2090,7 +2090,6 @@
            next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
            slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-           WARN_ON(numa_node_id() != slabp->nodeid);
 #endif
                slabp->free = next;
        }
        check_slabp(cachep, slabp);



