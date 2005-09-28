Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVI1XGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVI1XGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVI1XGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:06:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12246 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751163AbVI1XGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:06:02 -0400
Date: Thu, 29 Sep 2005 00:05:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] n_r3964: drop bogus fmt casts
Message-ID: <20050928230558.GC7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

* print pointers with %p
* casting pointer structure field to int and printing it with %d...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-ppc-arch/drivers/char/n_r3964.c RC14-rc2-git6-n_r3964/drivers/char/n_r3964.c
--- RC14-rc2-git6-ppc-arch/drivers/char/n_r3964.c	2005-08-28 23:09:41.000000000 -0400
+++ RC14-rc2-git6-n_r3964/drivers/char/n_r3964.c	2005-09-28 13:02:21.000000000 -0400
@@ -229,8 +229,8 @@
        TRACE_L("line discipline %d registered", N_R3964);
        TRACE_L("flags=%x num=%x", tty_ldisc_N_R3964.flags, 
                tty_ldisc_N_R3964.num);
-       TRACE_L("open=%x", (int)tty_ldisc_N_R3964.open);
-       TRACE_L("tty_ldisc_N_R3964 = %x", (int)&tty_ldisc_N_R3964);
+       TRACE_L("open=%p", tty_ldisc_N_R3964.open);
+       TRACE_L("tty_ldisc_N_R3964 = %p", &tty_ldisc_N_R3964);
      }
    else
      {
@@ -267,8 +267,8 @@
    
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
-   TRACE_Q("add_tx_queue %x, length %d, tx_first = %x", 
-          (int)pHeader, pHeader->length, (int)pInfo->tx_first );
+   TRACE_Q("add_tx_queue %p, length %d, tx_first = %p", 
+          pHeader, pHeader->length, pInfo->tx_first );
 }
 
 static void remove_from_tx_queue(struct r3964_info *pInfo, int error_code)
@@ -285,10 +285,10 @@
       return;
 
 #ifdef DEBUG_QUEUE
-   printk("r3964: remove_from_tx_queue: %x, length %d - ",
-          (int)pHeader, (int)pHeader->length );
+   printk("r3964: remove_from_tx_queue: %p, length %u - ",
+          pHeader, pHeader->length );
    for(pDump=pHeader;pDump;pDump=pDump->next)
-	 printk("%x ", (int)pDump);
+	 printk("%p ", pDump);
    printk("\n");
 #endif
 
@@ -319,10 +319,10 @@
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
    kfree(pHeader);
-   TRACE_M("remove_from_tx_queue - kfree %x",(int)pHeader);
+   TRACE_M("remove_from_tx_queue - kfree %p",pHeader);
 
-   TRACE_Q("remove_from_tx_queue: tx_first = %x, tx_last = %x",
-          (int)pInfo->tx_first, (int)pInfo->tx_last );
+   TRACE_Q("remove_from_tx_queue: tx_first = %p, tx_last = %p",
+          pInfo->tx_first, pInfo->tx_last );
 }
 
 static void add_rx_queue(struct r3964_info *pInfo, struct r3964_block_header *pHeader)
@@ -346,9 +346,9 @@
    
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
-   TRACE_Q("add_rx_queue: %x, length = %d, rx_first = %x, count = %d",
-          (int)pHeader, pHeader->length,
-          (int)pInfo->rx_first, pInfo->blocks_in_rx_queue);
+   TRACE_Q("add_rx_queue: %p, length = %d, rx_first = %p, count = %d",
+          pHeader, pHeader->length,
+          pInfo->rx_first, pInfo->blocks_in_rx_queue);
 }
 
 static void remove_from_rx_queue(struct r3964_info *pInfo,
@@ -360,10 +360,10 @@
    if(pHeader==NULL)
       return;
 
-   TRACE_Q("remove_from_rx_queue: rx_first = %x, rx_last = %x, count = %d",
-          (int)pInfo->rx_first, (int)pInfo->rx_last, pInfo->blocks_in_rx_queue );
-   TRACE_Q("remove_from_rx_queue: %x, length %d",
-          (int)pHeader, (int)pHeader->length );
+   TRACE_Q("remove_from_rx_queue: rx_first = %p, rx_last = %p, count = %d",
+          pInfo->rx_first, pInfo->rx_last, pInfo->blocks_in_rx_queue );
+   TRACE_Q("remove_from_rx_queue: %p, length %u",
+          pHeader, pHeader->length );
 
    spin_lock_irqsave(&pInfo->lock, flags);
 
@@ -401,10 +401,10 @@
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
    kfree(pHeader);
-   TRACE_M("remove_from_rx_queue - kfree %x",(int)pHeader);
+   TRACE_M("remove_from_rx_queue - kfree %p",pHeader);
 
-   TRACE_Q("remove_from_rx_queue: rx_first = %x, rx_last = %x, count = %d",
-          (int)pInfo->rx_first, (int)pInfo->rx_last, pInfo->blocks_in_rx_queue );
+   TRACE_Q("remove_from_rx_queue: rx_first = %p, rx_last = %p, count = %d",
+          pInfo->rx_first, pInfo->rx_last, pInfo->blocks_in_rx_queue );
 }
 
 static void put_char(struct r3964_info *pInfo, unsigned char ch)
@@ -506,8 +506,8 @@
    if(tty->driver->write_room)
       room=tty->driver->write_room(tty);
 
-   TRACE_PS("transmit_block %x, room %d, length %d", 
-          (int)pBlock, room, pBlock->length);
+   TRACE_PS("transmit_block %p, room %d, length %d", 
+          pBlock, room, pBlock->length);
    
    while(pInfo->tx_position < pBlock->length)
    {
@@ -588,7 +588,7 @@
 
    /* prepare struct r3964_block_header: */
    pBlock = kmalloc(length+sizeof(struct r3964_block_header), GFP_KERNEL);
-   TRACE_M("on_receive_block - kmalloc %x",(int)pBlock);
+   TRACE_M("on_receive_block - kmalloc %p",pBlock);
 
    if(pBlock==NULL)
       return;
@@ -868,11 +868,11 @@
                if(pMsg)
                {
                   kfree(pMsg);
-                  TRACE_M("enable_signals - msg kfree %x",(int)pMsg);
+                  TRACE_M("enable_signals - msg kfree %p",pMsg);
                }
             }
             kfree(pClient);
-            TRACE_M("enable_signals - kfree %x",(int)pClient);
+            TRACE_M("enable_signals - kfree %p",pClient);
             return 0;
          }
       }
@@ -890,7 +890,7 @@
       {
          /* add client to client list */
          pClient=kmalloc(sizeof(struct r3964_client_info), GFP_KERNEL);
-         TRACE_M("enable_signals - kmalloc %x",(int)pClient);
+         TRACE_M("enable_signals - kmalloc %p",pClient);
          if(pClient==NULL)
             return -ENOMEM;
 
@@ -954,7 +954,7 @@
 queue_the_message:
 
       pMsg = kmalloc(sizeof(struct r3964_message), GFP_KERNEL);
-      TRACE_M("add_msg - kmalloc %x",(int)pMsg);
+      TRACE_M("add_msg - kmalloc %p",pMsg);
       if(pMsg==NULL) {
          return;
       }
@@ -1067,11 +1067,11 @@
    struct r3964_info *pInfo;
    
    TRACE_L("open");
-   TRACE_L("tty=%x, PID=%d, disc_data=%x", 
-          (int)tty, current->pid, (int)tty->disc_data);
+   TRACE_L("tty=%p, PID=%d, disc_data=%p", 
+          tty, current->pid, tty->disc_data);
    
    pInfo=kmalloc(sizeof(struct r3964_info), GFP_KERNEL); 
-   TRACE_M("r3964_open - info kmalloc %x",(int)pInfo);
+   TRACE_M("r3964_open - info kmalloc %p",pInfo);
 
    if(!pInfo)
    {
@@ -1080,26 +1080,26 @@
    }
 
    pInfo->rx_buf = kmalloc(RX_BUF_SIZE, GFP_KERNEL);
-   TRACE_M("r3964_open - rx_buf kmalloc %x",(int)pInfo->rx_buf);
+   TRACE_M("r3964_open - rx_buf kmalloc %p",pInfo->rx_buf);
 
    if(!pInfo->rx_buf)
    {
       printk(KERN_ERR "r3964: failed to alloc receive buffer\n");
       kfree(pInfo);
-      TRACE_M("r3964_open - info kfree %x",(int)pInfo);
+      TRACE_M("r3964_open - info kfree %p",pInfo);
       return -ENOMEM;
    }
    
    pInfo->tx_buf = kmalloc(TX_BUF_SIZE, GFP_KERNEL);
-   TRACE_M("r3964_open - tx_buf kmalloc %x",(int)pInfo->tx_buf);
+   TRACE_M("r3964_open - tx_buf kmalloc %p",pInfo->tx_buf);
 
    if(!pInfo->tx_buf)
    {
       printk(KERN_ERR "r3964: failed to alloc transmit buffer\n");
       kfree(pInfo->rx_buf);
-      TRACE_M("r3964_open - rx_buf kfree %x",(int)pInfo->rx_buf);
+      TRACE_M("r3964_open - rx_buf kfree %p",pInfo->rx_buf);
       kfree(pInfo);
-      TRACE_M("r3964_open - info kfree %x",(int)pInfo);
+      TRACE_M("r3964_open - info kfree %p",pInfo);
       return -ENOMEM;
    }
 
@@ -1154,11 +1154,11 @@
           if(pMsg)
           {
              kfree(pMsg);
-             TRACE_M("r3964_close - msg kfree %x",(int)pMsg);
+             TRACE_M("r3964_close - msg kfree %p",pMsg);
           }
        }
        kfree(pClient);
-       TRACE_M("r3964_close - client kfree %x",(int)pClient);
+       TRACE_M("r3964_close - client kfree %p",pClient);
        pClient=pNext;
     }
     /* Remove jobs from tx_queue: */
@@ -1177,11 +1177,11 @@
     /* Free buffers: */
     wake_up_interruptible(&pInfo->read_wait);
     kfree(pInfo->rx_buf);
-    TRACE_M("r3964_close - rx_buf kfree %x",(int)pInfo->rx_buf);
+    TRACE_M("r3964_close - rx_buf kfree %p",pInfo->rx_buf);
     kfree(pInfo->tx_buf);
-    TRACE_M("r3964_close - tx_buf kfree %x",(int)pInfo->tx_buf);
+    TRACE_M("r3964_close - tx_buf kfree %p",pInfo->tx_buf);
     kfree(pInfo);
-    TRACE_M("r3964_close - info kfree %x",(int)pInfo);
+    TRACE_M("r3964_close - info kfree %p",pInfo);
 }
 
 static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
@@ -1234,7 +1234,7 @@
       count = sizeof(struct r3964_client_message);
 
       kfree(pMsg);
-      TRACE_M("r3964_read - msg kfree %x",(int)pMsg);
+      TRACE_M("r3964_read - msg kfree %p",pMsg);
 
       if (copy_to_user(buf,&theMsg, count))
 	return -EFAULT;
@@ -1279,7 +1279,7 @@
  * Allocate a buffer for the data and copy it from the buffer with header prepended
  */
    new_data = kmalloc (count+sizeof(struct r3964_block_header), GFP_KERNEL);
-   TRACE_M("r3964_write - kmalloc %x",(int)new_data);
+   TRACE_M("r3964_write - kmalloc %p",new_data);
    if (new_data == NULL) {
       if (pInfo->flags & R3964_DEBUG)
       {
