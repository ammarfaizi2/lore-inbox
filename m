Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQKRRMQ>; Sat, 18 Nov 2000 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129590AbQKRRL5>; Sat, 18 Nov 2000 12:11:57 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:30458 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129588AbQKRRLZ>; Sat, 18 Nov 2000 12:11:25 -0500
Message-ID: <3A16B0CA.E48EFFE7@didntduck.org>
Date: Sat, 18 Nov 2000 11:39:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 mm init cleanup
In-Reply-To: <Pine.LNX.4.21.0011181628220.1270-100000@saturn.homenet>
Content-Type: multipart/mixed;
 boundary="------------6BD51D271D7D7A9F9E44AC88"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BD51D271D7D7A9F9E44AC88
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tigran Aivazian wrote:
> 
> On Sat, 18 Nov 2000, Brian Gerst wrote:
> 
> > Patch against test11.  This patch moves the setting of %cr4 out of the
> > loops and makes the code a bit more readable.  Tested with standard
> > pagetables, PSE, and PAE.
> >
> >
> 
> Brian,
> 
> while you were there, so close to paging_init() why not also correct the
> wrong comment at the top of the function? It talks about 0-4M pagetables
> whereas we really setup (see head.S) 0-8M.
> 
> Regards,
> Tigran

Add this little patch then

-- 

						Brian Gerst
--------------6BD51D271D7D7A9F9E44AC88
Content-Type: text/plain; charset=us-ascii;
 name="mminit2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mminit2.diff"

diff -urN linux-2.4.0t11p7/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.4.0t11p7/arch/i386/mm/init.c	Mon Oct 23 17:42:33 2000
+++ linux/arch/i386/mm/init.c	Sat Nov 18 11:38:02 2000
@@ -437,7 +437,7 @@
 }
 
 /*
- * paging_init() sets up the page tables - note that the first 4MB are
+ * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
  *
  * This routines also unmaps the page at virtual kernel address 0, so

--------------6BD51D271D7D7A9F9E44AC88--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
