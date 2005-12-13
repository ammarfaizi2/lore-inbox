Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVLMIcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVLMIcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVLMIcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:32:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:36227 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932548AbVLMIYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:45 -0500
Date: Tue, 13 Dec 2005 00:23:03 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, green@linuxhacker.ru
Subject: [patch 13/26] 32bit integer overflow in invalidate_inode_pages2()
Message-ID: <20051213082303.GN5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="32bit-integer-overflow-in-invalidate_inode_pages2.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Oleg Drokin <green@linuxhacker.ru>

[PATCH] 32bit integer overflow in invalidate_inode_pages2()

Fix a 32 bit integer overflow in invalidate_inode_pages2_range.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 mm/truncate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14.3.orig/mm/truncate.c
+++ linux-2.6.14.3/mm/truncate.c
@@ -291,8 +291,8 @@ int invalidate_inode_pages2_range(struct
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_range(mapping,
-					    page_index << PAGE_CACHE_SHIFT,
-					    (end - page_index + 1)
+					   (loff_t)page_index<<PAGE_CACHE_SHIFT,
+					   (loff_t)(end - page_index + 1)
 							<< PAGE_CACHE_SHIFT,
 					    0);
 					did_range_unmap = 1;
@@ -301,7 +301,7 @@ int invalidate_inode_pages2_range(struct
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
-					  page_index << PAGE_CACHE_SHIFT,
+					  (loff_t)page_index<<PAGE_CACHE_SHIFT,
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}

--
