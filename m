Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUCITHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUCITHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:07:39 -0500
Received: from palrel12.hp.com ([156.153.255.237]:42694 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262107AbUCITFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:05:14 -0500
Date: Tue, 9 Mar 2004 11:05:12 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (3/14) hashbin export symbols
Message-ID: <20040309190512.GD14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir264_irsyms_03_hashbin.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(3/14) hashbin export symbols

Move hashbin_X exports out of irsyms and into irqueue.


diff -u -p -r linux/net/irda.s2/irqueue.c linux/net/irda/irqueue.c
--- linux/net/irda.s2/irqueue.c	Wed Mar  3 17:02:55 2004
+++ linux/net/irda/irqueue.c	Mon Mar  8 18:55:49 2004
@@ -191,6 +191,7 @@
  *
  * Jean II
  */
+#include <linux/module.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irqueue.h>
@@ -374,6 +375,7 @@ hashbin_t *hashbin_new(int type)
 
 	return hashbin;
 }
+EXPORT_SYMBOL(hashbin_new);
 
 
 /*
@@ -427,6 +429,7 @@ int hashbin_delete( hashbin_t* hashbin, 
 
 	return 0;
 }
+EXPORT_SYMBOL(hashbin_delete);
 
 /********************* HASHBIN LIST OPERATIONS *********************/
 
@@ -478,6 +481,7 @@ void hashbin_insert(hashbin_t* hashbin, 
 		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
 	} /* Default is no-lock  */
 }
+EXPORT_SYMBOL(hashbin_insert);
 
 /* 
  *  Function hashbin_remove_first (hashbin)
@@ -628,6 +632,7 @@ void* hashbin_remove( hashbin_t* hashbin
 		return NULL;
 	
 }
+EXPORT_SYMBOL(hashbin_remove);
 
 /* 
  *  Function hashbin_remove_this (hashbin, entry)
@@ -690,6 +695,7 @@ void* hashbin_remove_this( hashbin_t* ha
 
 	return entry;
 }
+EXPORT_SYMBOL(hashbin_remove_this);
 
 /*********************** HASHBIN ENUMERATION ***********************/
 
@@ -743,6 +749,7 @@ void* hashbin_find( hashbin_t* hashbin, 
 
 	return NULL;
 }
+EXPORT_SYMBOL(hashbin_find);
 
 /*
  * Function hashbin_lock_find (hashbin, hashv, name)
@@ -771,6 +778,7 @@ void* hashbin_lock_find( hashbin_t* hash
 
 	return entry;
 }
+EXPORT_SYMBOL(hashbin_lock_find);
 
 /*
  * Function hashbin_find (hashbin, hashv, name, pnext)
@@ -812,6 +820,7 @@ void* hashbin_find_next( hashbin_t* hash
 
 	return entry;
 }
+EXPORT_SYMBOL(hashbin_find_next);
 
 /*
  * Function hashbin_get_first (hashbin)
@@ -843,6 +852,7 @@ irda_queue_t *hashbin_get_first( hashbin
 	 */
 	return NULL;
 }
+EXPORT_SYMBOL(hashbin_get_first);
 
 /*
  * Function hashbin_get_next (hashbin)
@@ -900,3 +910,4 @@ irda_queue_t *hashbin_get_next( hashbin_
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(hashbin_get_next);
diff -u -p -r linux/net/irda.s2/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s2/irsyms.c	Mon Mar  8 18:53:59 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 18:55:49 2004
@@ -129,18 +129,6 @@ EXPORT_SYMBOL(irlmp_get_saddr);
 EXPORT_SYMBOL(irlmp_dup);
 EXPORT_SYMBOL(lmp_reasons);
 
-/* Queue */
-EXPORT_SYMBOL(hashbin_new);
-EXPORT_SYMBOL(hashbin_insert);
-EXPORT_SYMBOL(hashbin_delete);
-EXPORT_SYMBOL(hashbin_remove);
-EXPORT_SYMBOL(hashbin_remove_this);
-EXPORT_SYMBOL(hashbin_find);
-EXPORT_SYMBOL(hashbin_lock_find);
-EXPORT_SYMBOL(hashbin_find_next);
-EXPORT_SYMBOL(hashbin_get_next);
-EXPORT_SYMBOL(hashbin_get_first);
-
 /* IrLAP */
 EXPORT_SYMBOL(irlap_open);
 EXPORT_SYMBOL(irlap_close);
