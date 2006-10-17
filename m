Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWJQNRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWJQNRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWJQNRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:17:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5095 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750899AbWJQNRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:17:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm1
Date: Tue, 17 Oct 2006 15:17:22 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171517.23271.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 17 October 2006 08:06, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> 
[--snip--]
> 
> +swsusp-improve-handling-of-highmem.patch

This patch needs the following small fix so that image_size is used
properly on systems with lots of highmem:

---
Fix swsusp to use image_size as documented on systems with lots of highmem.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc2-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/power/swsusp.c
+++ linux-2.6.19-rc2-mm1/kernel/power/swsusp.c
@@ -195,6 +195,7 @@ int swsusp_shrink_memory(void)
 		highmem_size = count_highmem_pages();
 		size = count_data_pages() + PAGES_FOR_IO;
 		tmp = size;
+		size += highmem_size;
 		for_each_zone (zone)
 			if (populated_zone(zone)) {
 				if (is_highmem(zone)) {
@@ -209,7 +210,6 @@ int swsusp_shrink_memory(void)
 		if (highmem_size < 0)
 			highmem_size = 0;
 
-		size += highmem_size;
 		tmp += highmem_size;
 		if (tmp > 0) {
 			tmp = __shrink_memory(tmp);
