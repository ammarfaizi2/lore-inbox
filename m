Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129283AbQKVONS>; Wed, 22 Nov 2000 09:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130612AbQKVONI>; Wed, 22 Nov 2000 09:13:08 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:19041 "EHLO mel.alcatel.fr")
        by vger.kernel.org with ESMTP id <S129283AbQKVOMz>;
        Wed, 22 Nov 2000 09:12:55 -0500
Message-ID: <3A1BCD2C.8F489FB3@vz.cit.alcatel.fr>
Date: Wed, 22 Nov 2000 14:42:05 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
Organization: xgen@linuxstart.com
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: silly [< >] and other excess
In-Reply-To: <UTC200011221320.OAA140634.aeb@aak.cwi.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl a écrit :

>  I also left something else
> that always annoyed me: valuable screen space (on a 24x80 vt)
> is lost by these silly [< >] around addresses in an Oops.
> They provide no information at all, but on the other hand
> cause loss of information because these lines no longer
> fit in 80 columns causing line wrap and the loss of the
> top of the Oops.]
>

What a good idea!
Moreover, there is another problem in Oops:
the dumped stack is limited to 3 or 4 lines to prevent loss of information
but the call trace is unlimited and can loose all information,
and sometimes is printing forever!
--- arch/i386/kernel/traps.c.orig Mon Oct  2 20:57:01 2000
+++ arch/i386/kernel/traps.c Sun Nov  5 14:33:52 2000
@@ -142,11 +142,12 @@
    * out the call path that was taken.
    */
   if (((addr >= (unsigned long) &_stext) &&
+    (i<32) &&
        (addr <= (unsigned long) &_etext)) ||
       ((addr >= module_start) && (addr <= module_end))) {
    if (i && ((i % 8) == 0))
     printk("\n       ");
-   printk("[<%08lx>] ", addr);
+   printk("%08lx ", addr);
    i++;
   }
  }

And do not scroll the screen after the last printed line!

--- kernel/panic.c.orig Tue Jun 20 23:32:27 2000
+++ kernel/panic.c Sun Nov  5 07:53:04 2000
@@ -56,7 +56,7 @@
  va_end(args);
  printk(KERN_EMERG "Kernel panic: %s\n",buf);
  if (in_interrupt())
-  printk(KERN_EMERG "In interrupt handler - not syncing\n");
+  printk(KERN_EMERG "In interrupt handler - not syncing");
  else if (!current->pid)
   printk(KERN_EMERG "In idle task - not syncing\n");
  else


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
