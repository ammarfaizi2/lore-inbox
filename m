Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVILUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVILUdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVILUdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:33:49 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:44363 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbVILUds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:33:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WUNhIhpFPlh/iZAqiqgt0aMT77KcvL7DcM5LJWvh9nIN29Atk73Uy285J7LU9yhe9Eu+PYHoPexDQqOwQh9w8zv2O3FzlfjKhGX9hoQbIuyYeWu0CSPiKrocIrKZt0q9DfRRWvykrOWLng13znoXLhF2ShZJGr/7NXKkV2r4jik=
Date: Tue, 13 Sep 2005 00:42:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] n_r3964: drop bogus fmt casts
Message-ID: <20050912204251.GA18962@mipter.zuzino.mipt.ru>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912191744.GN25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* print pointers with %p
* casting unsigned int structure field to int and printing it with %d...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/n_r3964.c |   84 ++++++++++++++++++++++++-------------------------
 1 files changed, 42 insertions(+), 42 deletions(-)

--- linux-vanilla/drivers/char/n_r3964.c
+++ linux-r3964/drivers/char/n_r3964.c
@@ -229,8 +229,8 @@ static int __init r3964_init(void)
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
@@ -267,8 +267,8 @@ static void add_tx_queue(struct r3964_in
    
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
-   TRACE_Q("add_tx_queue %x, length %d, tx_first = %x", 
-          (int)pHeader, pHeader->length, (int)pInfo->tx_first );
+   TRACE_Q("add_tx_queue %p, length %d, tx_first = %p", 
+          pHeader, pHeader->length, pInfo->tx_first );
 }
 
 static void remove_from_tx_queue(struct r3964_info *pInfo, int error_code)
@@ -285,10 +285,10 @@ static void remove_from_tx_queue(struct 
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
 
@@ -319,10 +319,10 @@ static void remove_from_tx_queue(struct 
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
@@ -346,9 +346,9 @@ static void add_rx_queue(struct r3964_in
    
    spin_unlock_irqrestore(&pInfo->lock, flags);
 
-   TRACE_Q("add_rx_queue: %x, length = %d, rx_first = %x, count = %d",
-          (int)pHeader, pHeader->length,
-          (int)pInfo->rx_first, pInfo->blocks_in_rx_queue);
+   TRACE_Q("add_rx_queue: %p, length = %d, rx_first = %p, count = %d",
+          pHeader, pHeader->length,
+          pInfo->rx_first, pInfo->blocks_in_rx_queue);
 }
 
 static void remove_from_rx_queue(struct r3964_info *pInfo,
@@ -360,10 +360,10 @@ static void remove_from_rx_queue(struct 
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
 
@@ -401,10 +401,10 @@ static void remove_from_rx_queue(struct 
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
@@ -506,8 +506,8 @@ static void transmit_block(struct r3964_
    if(tty->driver->write_room)
       room=tty->driver->write_room(tty);
 
-   TRACE_PS("transmit_block %x, room %d, length %d", 
-          (int)pBlock, room, pBlock->length);
+   TRACE_PS("transmit_block %p, room %d, length %d", 
+          pBlock, room, pBlock->length);
    
    while(pInfo->tx_position < pBlock->length)
    {
@@ -588,7 +588,7 @@ static void on_receive_block(struct r396
 
    /* prepare struct r3964_block_header: */
    pBlock = kmalloc(length+sizeof(struct r3964_block_header), GFP_KERNEL);
-   TRACE_M("on_receive_block - kmalloc %x",(int)pBlock);
+   TRACE_M("on_receive_block - kmalloc %p",pBlock);
 
    if(pBlock==NULL)
       return;
@@ -868,11 +868,11 @@ static int enable_signals(struct r3964_i
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
@@ -890,7 +890,7 @@ static int enable_signals(struct r3964_i
       {
          /* add client to client list */
          pClient=kmalloc(sizeof(struct r3964_client_info), GFP_KERNEL);
-         TRACE_M("enable_signals - kmalloc %x",(int)pClient);
+         TRACE_M("enable_signals - kmalloc %p",pClient);
          if(pClient==NULL)
             return -ENOMEM;
 
@@ -954,7 +954,7 @@ static void add_msg(struct r3964_client_
 queue_the_message:
 
       pMsg = kmalloc(sizeof(struct r3964_message), GFP_KERNEL);
-      TRACE_M("add_msg - kmalloc %x",(int)pMsg);
+      TRACE_M("add_msg - kmalloc %p",pMsg);
       if(pMsg==NULL) {
          return;
       }
@@ -1067,11 +1067,11 @@ static int r3964_open(struct tty_struct 
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
@@ -1080,26 +1080,26 @@ static int r3964_open(struct tty_struct 
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
 
@@ -1154,11 +1154,11 @@ static void r3964_close(struct tty_struc
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
@@ -1177,11 +1177,11 @@ static void r3964_close(struct tty_struc
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
@@ -1234,7 +1234,7 @@ repeat:
       count = sizeof(struct r3964_client_message);
 
       kfree(pMsg);
-      TRACE_M("r3964_read - msg kfree %x",(int)pMsg);
+      TRACE_M("r3964_read - msg kfree %p",pMsg);
 
       if (copy_to_user(buf,&theMsg, count))
 	return -EFAULT;
@@ -1279,7 +1279,7 @@ static ssize_t r3964_write(struct tty_st
  * Allocate a buffer for the data and copy it from the buffer with header prepended
  */
    new_data = kmalloc (count+sizeof(struct r3964_block_header), GFP_KERNEL);
-   TRACE_M("r3964_write - kmalloc %x",(int)new_data);
+   TRACE_M("r3964_write - kmalloc %p",new_data);
    if (new_data == NULL) {
       if (pInfo->flags & R3964_DEBUG)
       {

