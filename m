Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbRGRSgo>; Wed, 18 Jul 2001 14:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267917AbRGRSgY>; Wed, 18 Jul 2001 14:36:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34311 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267914AbRGRSgS>;
	Wed, 18 Jul 2001 14:36:18 -0400
Date: Wed, 18 Jul 2001 15:36:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, Dave McCracken <dmc@austin.ibm.com>,
        Dirk Wetter <dirkw@rentec.com>
Subject: [PATCH] swap usage of high memory (fwd)
Message-ID: <Pine.LNX.4.33L.0107181529100.28730-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Linus,

Dave found a stupid bug in the swapin code, leading to
bad balancing problems in the VM.

I suspect marcelo's zone VM hack could even go away
with this patch applied ;)

Rik
---------- Forwarded message ----------
Date: Wed, 18 Jul 2001 13:15:07 -0500
From: Dave McCracken <dmc@austin.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org
Subject: Patch for swap usage of high memory


This patch fixes the problem where pages allocated for swap space reads
will not be allocated from high memory.

Rik, could you please forward this to the kernel mailing list?  I am
temporarily unable to reach it directly due to ECN problems.

Thanks,
Dave McCracken

--------

--- linux-2.4.6/mm/swap_state.c	Mon Jun 11 21:15:27 2001
+++ linux-2.4.6-mm/mm/swap_state.c	Wed Jul 18 12:56:01 2001
@@ -226,7 +226,7 @@
 	if (found_page)
 		goto out_free_swap;

-	new_page = alloc_page(GFP_USER);
+	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto out_free_swap;	/* Out of memory */

--------

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmc@austin.ibm.com                                      T/L   678-3059


