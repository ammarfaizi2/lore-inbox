Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTE2MzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTE2MzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:55:02 -0400
Received: from holomorphy.com ([66.224.33.161]:43143 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262030AbTE2My5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:54:57 -0400
Date: Thu, 29 May 2003 06:08:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com, zwane@linuxpower.ca, akpm@digeo.com
Subject: list_head debugging patch
Message-ID: <20030529130807.GH19818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, manfred@colorfullife.com,
	zwane@linuxpower.ca, akpm@digeo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to get the kernel to crap its pants in very, very short
order. Given the number of things going wrong, I almost wonder if I
did something wrong. Things get real ugly, really, really fast.

Some review could be helpful, especially since some hard problems come
up right from the start and I can't get a clean boot with this.

Enjoy.


-- wli

Some oopses with the patch applied (virgin 2.5.70):

Unable to handle kernel paging request at virtual address afafafaf
 printing eip:
c01796d6
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01796d6>]    Not tainted
EFLAGS: 00010282
EIP is at dput+0x5a6/0x5e0
eax: 9e9e9e9e   ebx: c019e7f0   ecx: c16e7dbc   edx: afafafaf
esi: c16e7d4c   edi: 0000000f   ebp: cf851ef8   esp: cf851ed8
ds: 007b   es: 007b   ss: 0068
Process rcS (pid: 51, threadinfo=cf850000 task=cfec8080)
Stack: c16e7d4c c0422ad0 c16e7d4c c16e7d4c cf851ef8 cf850000 cfec8c80 0000000f
       cf851f20 c01218a8 c16e7d4c cfec8624 cf99a3e8 cf9e106c c16e7d4c cfec8c80
       bfffee1c 00000000 cf851f4c c01236b3 cfec8c80 00040001 00030002 00000000
Call Trace:
 [<c01218a8>] release_task+0x278/0x300
 [<c01236b3>] wait_task_zombie+0x143/0x1a0
 [<c0123c4a>] sys_wait4+0x21a/0x270
 [<c011bb20>] default_wake_function+0x0/0x30
 [<c012c980>] sys_rt_sigprocmask+0x90/0x120
 [<c011bb20>] default_wake_function+0x0/0x30
 [<c010b3ab>] syscall_call+0x7/0xb

Code: 89 02 74 03 89 50 04 c7 46 70 9e 9e 9e 9e c7 41 04 af af af

elem = c03a77b4, elem->prev = c0420d80, elem->prev->next = c03a73b4
------------[ cut here ]------------
kernel BUG at include/linux/list.h:39!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0279bbc>]    Not tainted
EFLAGS: 00010286
EIP is at ide_register_subdriver+0xdc/0x200
eax: 00000047   ebx: c03a77b4   ecx: 00000002   edx: c0363d98
esi: c14e6000   edi: c04213f4   ebp: c14e7ed4   esp: c14e7eb4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c14e6000 task=cfef5a80)
Stack: c0320c20 c03a77b4 c0420d80 c03a73b4 c0421628 c04213f4 c0421348 00000000
       c14e7eec c027aa64 c04213f4 c03a7700 00000001 c14e6000 c14e7f10 c0279008
       c04213f4 00000202 00000002 00000000 00000000 c0421348 00000000 c14e7f24
Call Trace:
 [<c027aa64>] idedefault_attach+0x24/0x50
 [<c0279008>] ata_attach+0xa8/0x190
 [<c02716ab>] probe_hwif_init+0x7b/0x80
 [<c0285d4a>] ide_setup_pci_device+0x7a/0x90
 [<c026e89b>] piix_init_one+0x3b/0x50
 [<c03f03bd>] ide_scan_pcidev+0x5d/0x70
 [<c03f0408>] ide_scan_pcibus+0x38/0x120
 [<c03f013e>] probe_for_hwifs+0x8e/0x90
 [<c03ef769>] init_ide_data+0x39/0x50
 [<c03f0148>] ide_init_builtin_drivers+0x8/0x20
 [<c03f018f>] ide_init+0x2f/0x60
 [<c03da85b>] do_initcalls+0x2b/0xa0
 [<c012efd2>] init_workqueues+0x12/0x30
 [<c01050a6>] init+0x36/0x1c0
 [<c0105070>] init+0x0/0x1c0
 [<c010917d>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 27 00 72 f3 31 c0 8b 55 0c 8b 82 b4 00 00 00 8b 50 04


--- linux-2.5.70/include/linux/list.h	2003-05-26 18:00:41.000000000 -0700
+++ pgcl-2.5.70-2/include/linux/list.h	2003-05-29 05:32:43.000000000 -0700
@@ -30,6 +30,22 @@
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
 } while (0)
 
+static inline void __list_head_check(const struct list_head *elem)
+{
+	if (elem->prev->next != elem) {
+		printk(KERN_CRIT "elem = %p, elem->prev = %p, "
+					"elem->prev->next = %p\n",
+					elem, elem->prev, elem->prev->next);
+		BUG();
+	}
+	if (elem->next->prev != elem) {
+		printk(KERN_CRIT "elem = %p, elem->next = %p, "
+				"elem->next->prev = %p\n",
+				elem, elem->next, elem->next->prev);
+		BUG();
+	}
+}
+
 /*
  * Insert a new entry between two known consecutive entries. 
  *
@@ -56,6 +72,7 @@
  */
 static inline void list_add(struct list_head *new, struct list_head *head)
 {
+	__list_head_check(head);
 	__list_add(new, head, head->next);
 }
 
@@ -69,6 +86,7 @@
  */
 static inline void list_add_tail(struct list_head *new, struct list_head *head)
 {
+	__list_head_check(head);
 	__list_add(new, head->prev, head);
 }
 
@@ -136,7 +154,10 @@
  */
 static inline void list_del(struct list_head *entry)
 {
+	__list_head_check(entry);
 	__list_del(entry->prev, entry->next);
+	entry->prev = (void *)0x7c7c7c7c;
+	entry->next = (void *)0x8d8d8d8d;
 }
 /**
  * list_del_rcu - deletes entry from list without re-initialization
@@ -156,6 +177,7 @@
  */
 static inline void list_del_init(struct list_head *entry)
 {
+	__list_head_check(entry);
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
 }
@@ -167,6 +189,8 @@
  */
 static inline void list_move(struct list_head *list, struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
         __list_del(list->prev, list->next);
         list_add(list, head);
 }
@@ -179,6 +203,8 @@
 static inline void list_move_tail(struct list_head *list,
 				  struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
         __list_del(list->prev, list->next);
         list_add_tail(list, head);
 }
@@ -189,6 +215,7 @@
  */
 static inline int list_empty(struct list_head *head)
 {
+	__list_head_check(head);
 	return head->next == head;
 }
 
@@ -199,6 +226,9 @@
 	struct list_head *last = list->prev;
 	struct list_head *at = head->next;
 
+	__list_head_check(head);
+	__list_head_check(list);
+
 	first->prev = head;
 	head->next = first;
 
@@ -262,7 +292,11 @@
  * or 1 entry) most of the time.
  */
 #define __list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (head); pos = pos->next)
+	for (pos = (head)->next;					\
+		pos != (head);						\
+		__list_head_check(pos),					\
+		__list_head_check(head),				\
+		pos = pos->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -290,11 +324,13 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		     prefetch(pos->member.next);			\
-	     &pos->member != (head); 					\
-	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     prefetch(pos->member.next))
+	for (pos = list_entry((head)->next, typeof(*(pos)), member),	\
+		     prefetch((pos)->member.next);			\
+	     &(pos)->member != (head); 					\
+	     pos = list_entry((pos)->member.next, typeof(*(pos)), member),\
+		     __list_head_check(head),				\
+		     __list_head_check(&(pos)->member),			\
+		     prefetch((pos)->member.next))
 
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
@@ -304,10 +340,10 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry_safe(pos, n, head, member)			\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		n = list_entry(pos->member.next, typeof(*pos), member);	\
-	     &pos->member != (head); 					\
-	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+	for (pos = list_entry((head)->next, typeof(*(pos)), member),	\
+		n = list_entry((pos)->member.next, typeof(*(pos)), member);\
+	     &(pos)->member != (head); 					\
+	     pos = n, n = list_entry((n)->member.next, typeof(*(n)), member))
 
 /**
  * list_for_each_rcu	-	iterate over an rcu-protected list
@@ -401,9 +437,15 @@
 {
 	if (n->pprev)
 		__hlist_del(n);
+	n->next = (void *)0x9e9e9e9e;
+	n->pprev = (void *)0xafafafaf;
 }
 
-#define hlist_del_rcu hlist_del  /* list_del_rcu is identical too? */
+static __inline__ void hlist_del_rcu(struct hlist_node *n)
+{
+	if (n->pprev)
+		__hlist_del(n);
+}
 
 static __inline__ void hlist_del_init(struct hlist_node *n) 
 {
