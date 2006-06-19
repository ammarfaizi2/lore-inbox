Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWFSSry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWFSSry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWFSSru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3816 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964838AbWFSSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:15 -0400
Date: Mon, 19 Jun 2006 11:47:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060619184702.23130.11949.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/4] Remove empty destructor from drivers/usb/mon/mon_text.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty destructor from drivers/usb/mon/mon_text.c

Remove destructor and call kmem_cache_create with NULL for the destructor.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm2/drivers/usb/mon/mon_text.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/usb/mon/mon_text.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm2/drivers/usb/mon/mon_text.c	2006-06-14 15:37:01.574356902 -0700
@@ -61,7 +61,6 @@ struct mon_reader_text {
 };
 
 static void mon_text_ctor(void *, kmem_cache_t *, unsigned long);
-static void mon_text_dtor(void *, kmem_cache_t *, unsigned long);
 
 /*
  * mon_text_submit
@@ -238,7 +237,7 @@ static int mon_text_open(struct inode *i
 	    (long)rp);
 	rp->e_slab = kmem_cache_create(rp->slab_name,
 	    sizeof(struct mon_event_text), sizeof(long), 0,
-	    mon_text_ctor, mon_text_dtor);
+	    mon_text_ctor, NULL);
 	if (rp->e_slab == NULL) {
 		rc = -ENOMEM;
 		goto err_slab;
@@ -429,7 +428,3 @@ static void mon_text_ctor(void *mem, kme
 	memset(mem, 0xe5, sizeof(struct mon_event_text));
 }
 
-static void mon_text_dtor(void *mem, kmem_cache_t *slab, unsigned long sflags)
-{
-	;
-}
