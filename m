Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbQJ3DKp>; Sun, 29 Oct 2000 22:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129989AbQJ3DK0>; Sun, 29 Oct 2000 22:10:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24839 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129965AbQJ3DKX>;
	Sun, 29 Oct 2000 22:10:23 -0500
Message-ID: <39FCE67D.5847DF8@mandrakesoft.com>
Date: Sun, 29 Oct 2000 22:09:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kevin Lawton <kevin@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.0.10.6: wrapper.h cleanup
In-Reply-To: <39FCE576.9425F7F5@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------7E8EC04087F0CEB84B2C6507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7E8EC04087F0CEB84B2C6507
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,

Attached is a patch against 2.4.0-test10-pre6.  I went the ultra-safe
route and put parentheses around every macro arg.  Compiles ok for me
here...

If you were wondering if we can remove wrapper.h altogether, IMHO no,
there are too many users (43) right now..

Changes:
	* add lots of parens
	* line up vm_xxx and mem_map_xxx nicely with tabs
	* remove unused:
		wait_handle
		file_handle
		inode_handle
		select_table_handle
		vm_area_handle
		connect_wrapper
		current_got_fatal_signal
		current_set_timeout
		module_interruptible_sleep_on
		module_select_wait
		module_wake_up
		module_register_chrdev
		module_unregister_chrdev
		module_register_blkdev
		module_unregister_blkdev
		inode_get_rdev
		file_get_flags
		mem_map_inc_count
		mem_map_dec_count

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max

Kevin Lawton wrote:
> 
> Listed in 2.4 headers as:
> 
>         #define mem_map_reserve(p) set_bit(PG_reserved, &p->flags)
>         #define mem_map_unreserve(p) clear_bit(PG_reserved, &p->flags)
> 
> ...but should be:
> 
>         #define mem_map_reserve(p) set_bit(PG_reserved, &((p)->flags))
>         #define mem_map_unreserve(p) clear_bit(PG_reserved, &((p)->flags))
> 
> Because of the 'void *' nature of the 2nd parameter to set_bit/clear_bit,
> the compiler is not picking up this error.  Either expression generates
> a pointer, but not the same values.
> 
> Might as well also wrap the parameter 'p' with parentheses in the
> subsequent macros, mem_map_inc_count() and mem_map_dec_count(),
> for clarity.
> 
> CC me if needed.  I'm not on this list.
> 
> -Kevin Lawton
> Plex86 project
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
--------------7E8EC04087F0CEB84B2C6507
Content-Type: text/plain; charset=us-ascii;
 name="wrapper-2.4.0.10.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wrapper-2.4.0.10.6.patch"

Index: include/linux/wrapper.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/wrapper.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 wrapper.h
--- include/linux/wrapper.h	2000/10/22 21:00:45	1.1.1.3
+++ include/linux/wrapper.h	2000/10/30 03:07:00
@@ -1,36 +1,14 @@
 #ifndef _WRAPPER_H_
 #define _WRAPPER_H_
-#define wait_handle struct wait_queue
-#define file_handle struct file
-#define inode_handle struct inode
-#define select_table_handle select_table
-#define vm_area_handle struct vm_area_struct
 
-#define connect_wrapper(x) 0
-#define current_got_fatal_signal() (signal_pending(current))
-#define current_set_timeout(val) current->timeout = val
+#define vma_set_inode(v,i)	((v)->vm_inode = (i))
+#define vma_get_flags(v)	((v)->vm_flags)
+#define vma_get_pgoff(v)	((v)->vm_pgoff)
+#define vma_get_start(v)	((v)->vm_start)
+#define vma_get_end(v)		((v)->vm_end)
+#define vma_get_page_prot(v)	((v)->vm_page_prot)
 
-#define module_interruptible_sleep_on interruptible_sleep_on
-#define module_wake_up wake_up
-#define module_select_wait select_wait
-#define module_register_chrdev register_chrdev
-#define module_unregister_chrdev unregister_chrdev
-#define module_register_blkdev register_blkdev
-#define module_unregister_blkdev unregister_blkdev
+#define mem_map_reserve(p)	set_bit(PG_reserved, &((p)->flags))
+#define mem_map_unreserve(p)	clear_bit(PG_reserved, &((p)->flags))
 
-#define inode_get_rdev(i) i->i_rdev
-
-#define file_get_flags(f) f->f_flags
-
-#define vma_set_inode(v,i) v->vm_inode = i
-#define vma_get_flags(v) v->vm_flags
-#define vma_get_pgoff(v) v->vm_pgoff
-#define vma_get_start(v) v->vm_start
-#define vma_get_end(v) v->vm_end
-#define vma_get_page_prot(v) v->vm_page_prot
-
-#define mem_map_reserve(p) set_bit(PG_reserved, &p->flags)
-#define mem_map_unreserve(p) clear_bit(PG_reserved, &p->flags)
-#define mem_map_inc_count(p) atomic_inc(&(p->count))
-#define mem_map_dec_count(p) atomic_dec(&(p->count))
-#endif
+#endif /* _WRAPPER_H_ */

--------------7E8EC04087F0CEB84B2C6507--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
