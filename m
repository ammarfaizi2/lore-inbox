Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286495AbRLUAQe>; Thu, 20 Dec 2001 19:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286496AbRLUAQZ>; Thu, 20 Dec 2001 19:16:25 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28679 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286495AbRLUAQV>; Thu, 20 Dec 2001 19:16:21 -0500
Message-ID: <3C227F0E.E6A9CF76@zip.com.au>
Date: Thu, 20 Dec 2001 16:15:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: gregor@suhr.home.cs.tu-berlin.de, linux-kernel@vger.kernel.org
Subject: Re: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe 
 devfs
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>,
		<3C210AB9.5000900@suhr.home.cs.tu-berlin.de> <200112202338.fBKNcCI05673@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Gregor Suhr writes:
> > ...
> > kernel BUG at slab.c:815!

Somebody tried to create the same cache twice.  This can
happen when loading a buggy module the second time, various
things.

Please, apply this patch and run it again.

--- linux-2.4.17-rc2/mm/slab.c	Tue Dec 18 19:37:31 2001
+++ linux-akpm/mm/slab.c	Thu Dec 20 16:14:19 2001
@@ -811,8 +811,10 @@ next:
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
 
 			/* The name field is constant - no lock needed. */
-			if (!strcmp(pc->name, name))
+			if (!strcmp(pc->name, name)) {
+				printk(__FUNCTION__ ": %s\n", name);
 				BUG();
+			}
 		}
 	}
