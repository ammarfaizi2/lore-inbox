Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131538AbQLHMi4>; Fri, 8 Dec 2000 07:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132080AbQLHMiq>; Fri, 8 Dec 2000 07:38:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18970 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131501AbQLHMii>; Fri, 8 Dec 2000 07:38:38 -0500
Date: Fri, 8 Dec 2000 13:06:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>, wtenhave@sybase.com,
        hdeller@redhat.com, Eric Lowe <elowe@myrile.madriver.k12.oh.us>,
        Larry Woodman <woodman@missioncriticallinux.com>, linux-mm@kvack.org
Subject: Re: New patches for 2.2.18pre24 raw IO (fix for bounce buffer copy)
Message-ID: <20001208130633.A31920@inspiron.random>
In-Reply-To: <20001204205004.H8700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001204205004.H8700@redhat.com>; from sct@redhat.com on Mon, Dec 04, 2000 at 08:50:04PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 08:50:04PM +0000, Stephen C. Tweedie wrote:
> I have pushed another set of raw IO patches out, this time to fix a

This fix is missing:

--- rawio-sct/mm/memory.c.~1~	Fri Dec  8 03:05:01 2000
+++ rawio-sct/mm/memory.c	Fri Dec  8 03:57:48 2000
@@ -455,7 +455,7 @@
 	unsigned long		ptr, end;
 	int			err;
 	struct mm_struct *	mm;
-	struct vm_area_struct *	vma = 0;
+	struct vm_area_struct *	vma;
 	unsigned long		page;
 	struct page *		map;
 	int			doublepage = 0;
@@ -478,6 +478,7 @@
 		return err;
 
  repeat:
+	vma = NULL;
 	down(&mm->mmap_sem);
 
 	err = -EFAULT;
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
