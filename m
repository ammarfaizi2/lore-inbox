Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUBZD0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbUBZDY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:24:56 -0500
Received: from palrel12.hp.com ([156.153.255.237]:49538 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262677AbUBZDUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:20:05 -0500
Date: Wed, 25 Feb 2004 19:20:03 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] hashbin_cleanup
Message-ID: <20040226032003.GN32263@bougret.hpl.hp.com>
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

irXXX_hashbin_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code
	o [FEATURE] add const where needed


diff -Nru a/include/net/irda/irqueue.h b/include/net/irda/irqueue.h
--- a/include/net/irda/irqueue.h	Mon Feb 16 11:20:31 2004
+++ b/include/net/irda/irqueue.h	Mon Feb 16 11:20:31 2004
@@ -81,13 +81,13 @@
 int      hashbin_delete(hashbin_t* hashbin, FREE_FUNC func);
 int      hashbin_clear(hashbin_t* hashbin, FREE_FUNC free_func);
 void     hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, 
-			char* name);
-void*    hashbin_remove(hashbin_t* hashbin, long hashv, char* name);
+			const char* name);
+void*    hashbin_remove(hashbin_t* hashbin, long hashv, const char* name);
 void*    hashbin_remove_first(hashbin_t *hashbin);
 void*	 hashbin_remove_this( hashbin_t* hashbin, irda_queue_t* entry);
-void*    hashbin_find(hashbin_t* hashbin, long hashv, char* name);
-void*    hashbin_lock_find(hashbin_t* hashbin, long hashv, char* name);
-void*    hashbin_find_next(hashbin_t* hashbin, long hashv, char* name,
+void*    hashbin_find(hashbin_t* hashbin, long hashv, const char* name);
+void*    hashbin_lock_find(hashbin_t* hashbin, long hashv, const char* name);
+void*    hashbin_find_next(hashbin_t* hashbin, long hashv, const char* name,
 			   void ** pnext);
 irda_queue_t *hashbin_get_first(hashbin_t *hashbin);
 irda_queue_t *hashbin_get_next(hashbin_t *hashbin);
diff -Nru a/net/irda/irqueue.c b/net/irda/irqueue.c
--- a/net/irda/irqueue.c	Mon Feb 16 11:20:31 2004
+++ b/net/irda/irqueue.c	Mon Feb 16 11:20:31 2004
@@ -208,7 +208,7 @@
  *    This function hash the input string 'name' using the ELF hash
  *    function for strings.
  */
-static __u32 hash( char* name)
+static __u32 hash( const char* name)
 {
 	__u32 h = 0;
 	__u32 g;
@@ -567,7 +567,8 @@
  *    Insert an entry into the hashbin
  *
  */
-void hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, char* name)
+void hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, 
+		    const char* name)
 {
 	unsigned long flags = 0;
 	int bin;
@@ -683,7 +684,7 @@
  *  In other case, you must think hard to guarantee unicity of the index.
  *  Jean II
  */
-void* hashbin_remove( hashbin_t* hashbin, long hashv, char* name)
+void* hashbin_remove( hashbin_t* hashbin, long hashv, const char* name)
 {
 	int bin, found = FALSE;
 	unsigned long flags = 0;
@@ -834,7 +835,7 @@
  *    Find item with the given hashv or name
  *
  */
-void* hashbin_find( hashbin_t* hashbin, long hashv, char* name )
+void* hashbin_find( hashbin_t* hashbin, long hashv, const char* name )
 {
 	int bin;
 	irda_queue_t* entry;
@@ -888,7 +889,7 @@
  * I call it safe, but it's only safe with respect to the hashbin, not its
  * content. - Jean II
  */
-void* hashbin_lock_find( hashbin_t* hashbin, long hashv, char* name )
+void* hashbin_lock_find( hashbin_t* hashbin, long hashv, const char* name )
 {
 	unsigned long flags = 0;
 	irda_queue_t* entry;
@@ -917,7 +918,7 @@
  * context of the search. On the other hand, it might fail and return
  * NULL if the entry is removed. - Jean II
  */
-void* hashbin_find_next( hashbin_t* hashbin, long hashv, char* name,
+void* hashbin_find_next( hashbin_t* hashbin, long hashv, const char* name,
 			 void ** pnext)
 {
 	unsigned long flags = 0;
diff -Nru a/include/net/irda/irqueue.h b/include/net/irda/irqueue.h
--- a/include/net/irda/irqueue.h	Mon Feb 16 11:21:24 2004
+++ b/include/net/irda/irqueue.h	Mon Feb 16 11:21:24 2004
@@ -41,7 +41,6 @@
  */
 #define HB_NOLOCK	0	/* No concurent access prevention */
 #define HB_LOCK		1	/* Prevent concurent write with global lock */
-#define HB_SORTED	4	/* Not yet supported */
 
 /*
  * Hash defines
diff -Nru a/net/irda/irqueue.c b/net/irda/irqueue.c
--- a/net/irda/irqueue.c	Mon Feb 16 11:21:24 2004
+++ b/net/irda/irqueue.c	Mon Feb 16 11:21:24 2004
@@ -599,14 +599,9 @@
 	
 	/*
 	 * Insert new entry first
-	 * TODO: Perhaps allow sorted lists?
-	 *       -> Merge sort if a sorted list should be created
 	 */
-	if ( hashbin->hb_type & HB_SORTED) {
-	} else {
-		enqueue_first( (irda_queue_t**) &hashbin->hb_queue[ bin ],
-			       entry);
-	}
+	enqueue_first( (irda_queue_t**) &hashbin->hb_queue[ bin ],
+		       entry);
 	hashbin->hb_size++;
 
 	/* Release lock */
diff -Nru a/net/irda/irqueue.c b/net/irda/irqueue.c
--- a/net/irda/irqueue.c	Mon Feb 16 11:22:40 2004
+++ b/net/irda/irqueue.c	Mon Feb 16 11:22:40 2004
@@ -254,105 +254,6 @@
 	}
 }
 
-#ifdef HASHBIN_UNUSED
-/*
- * Function enqueue_last (queue, proc)
- *
- *    Insert item into end of queue.
- *
- */
-static void __enqueue_last( irda_queue_t **queue, irda_queue_t* element)
-{
-	IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
-
-	/*
-	 * Check if queue is empty.
-	 */
-	if ( *queue == NULL ) {
-		/*
-		 * Queue is empty.  Insert one element into the queue.
-		 */
-		element->q_next = element->q_prev = *queue = element;
-		
-	} else {
-		/*
-		 * Queue is not empty.  Insert element into end of queue.
-		 */
-		element->q_prev         = (*queue)->q_prev;
-		element->q_prev->q_next = element;
-		(*queue)->q_prev        = element;
-		element->q_next         = *queue;
-	}	
-}
-
-static inline void enqueue_last( irda_queue_t **queue, irda_queue_t* element)
-{
-	unsigned long flags;
-	
-        save_flags(flags);
-        cli();
-
-        __enqueue_last( queue, element);
-
-        restore_flags(flags);
-}
-
-/*
- * Function enqueue_queue (queue, list)
- *
- *    Insert a queue (list) into the start of the first queue
- *
- */
-static void enqueue_queue( irda_queue_t** queue, irda_queue_t** list )
-{
-	irda_queue_t* tmp;
-	
-	/*
-	 * Check if queue is empty
-	 */ 
-	if ( *queue ) {
-		(*list)->q_prev->q_next  = (*queue);
-		(*queue)->q_prev->q_next = (*list); 
-		tmp                      = (*list)->q_prev;
-		(*list)->q_prev          = (*queue)->q_prev;
-		(*queue)->q_prev         = tmp;
-	} else {
-		*queue                   = (*list); 
-	}
-	
-	(*list) = NULL;
-}
-
-/*
- * Function enqueue_second (queue, proc)
- *
- *    Insert item behind head of queue.
- *
- */
-static void enqueue_second(irda_queue_t **queue, irda_queue_t* element)
-{
-	IRDA_DEBUG( 0, "enqueue_second()\n");
-
-	/*
-	 * Check if queue is empty.
-	 */
-	if ( *queue == NULL ) {
-		/*
-		 * Queue is empty.  Insert one element into the queue.
-		 */
-		element->q_next = element->q_prev = *queue = element;
-		
-	} else {
-		/*
-		 * Queue is not empty.  Insert element into ..
-		 */
-		element->q_prev = (*queue);
-		(*queue)->q_next->q_prev = element;
-		element->q_next = (*queue)->q_next;
-		(*queue)->q_next = element;
-	}
-}
-#endif /* HASHBIN_UNUSED */
 
 /*
  * Function dequeue (queue)
@@ -474,38 +375,6 @@
 	return hashbin;
 }
 
-#ifdef HASHBIN_UNUSED
-/*
- * Function hashbin_clear (hashbin, free_func)
- *
- *    Remove all entries from the hashbin, see also the comments in 
- *    hashbin_delete() below
- */
-int hashbin_clear( hashbin_t* hashbin, FREE_FUNC free_func)
-{
-	irda_queue_t* queue;
-	int i;
-	
-	ASSERT(hashbin != NULL, return -1;);
-	ASSERT(hashbin->magic == HB_MAGIC, return -1;);
-
-	/*
-	 * Free the entries in the hashbin
-	 */
-	for (i = 0; i < HASHBIN_SIZE; i ++ ) {
-		queue = dequeue_first( (irda_queue_t**) &hashbin->hb_queue[i]);
-		while (queue) {
-			if (free_func)
-				(*free_func)(queue);
-			queue = dequeue_first( 
-				(irda_queue_t**) &hashbin->hb_queue[i]);
-		}
-	}
-	hashbin->hb_size = 0;
-
-	return 0;
-}
-#endif /* HASHBIN_UNUSED */
 
 /*
  * Function hashbin_delete (hashbin, free_func)
