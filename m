Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWALKsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWALKsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWALKsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:48:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64779 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030357AbWALKsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:48:13 -0500
Date: Thu, 12 Jan 2006 11:48:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: [RFC: -mm patch] swsusp: make some code static
Message-ID: <20060112104812.GR29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm2:
>...
> +swsusp-low-level-interface-rev-2.patch
>...
>  swsusp updates
>...

After this patch, we can make some code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/swap.h    |    1 -
 kernel/power/power.h    |    1 -
 kernel/power/snapshot.c |    4 ++--
 mm/swapfile.c           |    2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.15-mm3-full/kernel/power/power.h.old	2006-01-12 01:01:49.000000000 +0100
+++ linux-2.6.15-mm3-full/kernel/power/power.h	2006-01-12 01:01:55.000000000 +0100
@@ -48,7 +48,6 @@
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
-extern unsigned int nr_copy_pages;
 extern struct pbe *pagedir_nosave;
 
 /* Preferred image size in MB (default 500) */
--- linux-2.6.15-mm3-full/kernel/power/snapshot.c.old	2006-01-12 01:02:03.000000000 +0100
+++ linux-2.6.15-mm3-full/kernel/power/snapshot.c	2006-01-12 01:02:18.000000000 +0100
@@ -35,8 +35,8 @@
 #include "power.h"
 
 struct pbe *pagedir_nosave;
-unsigned int nr_copy_pages;
-unsigned int nr_meta_pages;
+static unsigned int nr_copy_pages;
+static unsigned int nr_meta_pages;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
--- linux-2.6.15-mm3-full/include/linux/swap.h.old	2006-01-12 01:04:21.000000000 +0100
+++ linux-2.6.15-mm3-full/include/linux/swap.h	2006-01-12 01:04:33.000000000 +0100
@@ -232,7 +232,6 @@
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
-extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(void);
 extern swp_entry_t get_swap_page_of_type(int);
--- linux-2.6.15-mm3-full/mm/swapfile.c.old	2006-01-12 01:04:42.000000000 +0100
+++ linux-2.6.15-mm3-full/mm/swapfile.c	2006-01-12 01:04:51.000000000 +0100
@@ -44,7 +44,7 @@
 
 struct swap_list_t swap_list = {-1, -1};
 
-struct swap_info_struct swap_info[MAX_SWAPFILES];
+static struct swap_info_struct swap_info[MAX_SWAPFILES];
 
 static DECLARE_MUTEX(swapon_sem);
 

