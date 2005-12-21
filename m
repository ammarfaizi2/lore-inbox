Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVLUV5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVLUV5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLUV5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:57:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28924 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932214AbVLUV5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:57:12 -0500
Subject: [PATCH 02/02] RT: plist namespace cleanup
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: tglx@linutronix.de, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru
Content-Type: text/plain
Date: Wed, 21 Dec 2005 13:57:10 -0800
Message-Id: <1135202230.22970.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	Make the plist namespace consistent.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.14/include/linux/plist.h
===================================================================
--- linux-2.6.14.orig/include/linux/plist.h
+++ linux-2.6.14/include/linux/plist.h
@@ -79,64 +79,64 @@
 
 #include <linux/list.h>
 
-struct pl_head {
+struct plist_head {
 	struct list_head prio_list;
 	struct list_head node_list;
 };
 
-struct pl_node {
-	int		prio;
-	struct pl_head	plist;
+struct plist_node {
+	int			prio;
+	struct plist_head	plist;
 };
 
 /** 
- * #PL_HEAD_INIT - static struct pl_head initializer
+ * #PLIST_HEAD_INIT - static struct plist_head initializer
  *
- * @head:	struct pl_head variable name
+ * @head:	struct plist_head variable name
  */
-#define PL_HEAD_INIT(head)	\
+#define PLIST_HEAD_INIT(head)	\
 {							\
 	.prio_list = LIST_HEAD_INIT((head).prio_list),	\
 	.node_list = LIST_HEAD_INIT((head).node_list),	\
 }
 
 /** 
- * #PL_NODE_INIT - static struct pl_node initializer
+ * #PLIST_NODE_INIT - static struct plist_node initializer
  *
- * @node:	struct pl_node variable name
+ * @node:	struct plist_node variable name
  * @__prio:	initial node priority	
  */
-#define PL_NODE_INIT(node, __prio)	\
+#define PLIST_NODE_INIT(node, __prio)	\
 {							\
 	.prio  = (__prio),				\
-	.plist = PL_HEAD_INIT((node).plist),		\
+	.plist = PLIST_HEAD_INIT((node).plist),		\
 }
 
 /**
- * pl_head_init - dynamic struct pl_head initializer
+ * plist_head_init - dynamic struct plist_head initializer
  *
- * @head:	&struct pl_head pointer
+ * @head:	&struct plist_head pointer
  */ 
-static inline void pl_head_init(struct pl_head *head)
+static inline void plist_head_init(struct plist_head *head)
 {
 	INIT_LIST_HEAD(&head->prio_list);
 	INIT_LIST_HEAD(&head->node_list);
 }
 
 /**
- * pl_node_init - Dynamic struct pl_node initializer
+ * plist_node_init - Dynamic struct plist_node initializer
  *
- * @node:	&struct pl_node pointer
+ * @node:	&struct plist_node pointer
  * @prio:	initial node priority
  */
-static inline void pl_node_init(struct pl_node *node, int prio)
+static inline void plist_node_init(struct plist_node *node, int prio)
 {
 	node->prio = prio;
-	pl_head_init(&node->plist);
+	plist_head_init(&node->plist);
 }
 
-extern void plist_add(struct pl_node *node, struct pl_head *head);
-extern void plist_del(struct pl_node *node);
+extern void plist_add(struct plist_node *node, struct plist_head *head);
+extern void plist_del(struct plist_node *node);
 
 /**
  * plist_for_each - iterate over the plist
@@ -181,31 +181,31 @@ extern void plist_del(struct pl_node *no
 	 list_for_each_entry_safe(pos, n, &(head)->node_list, mem.plist.node_list)
 
 /** 
- * plist_empty - return !0 if plist is empty
+ * plist_empty_empty - return !0 if plist is empty
  *
- * @head:	&struct pl_head pointer 
+ * @head:	&struct plist_head pointer 
  */
-static inline int plist_empty(const struct pl_head *head)
+static inline int plist_empty_head(const struct plist_head *head)
 {
 	return list_empty(&head->node_list);
 }
 
 /** 
- * plist_unhashed - return !0 if plist node is not on a list
+ * plist_empty_node - return !0 if plist node is not on a list
  *
- * @node:	&struct pl_node pointer 
+ * @node:	&struct plist_node pointer 
  */
-static inline int plist_unhashed(const struct pl_node *node)
+static inline int plist_empty_node(const struct plist_node *node)
 {
 	return list_empty(&node->plist.node_list);
 }
 
-/* All functions below assume the pl_head is not empty. */
+/* All functions below assume the plist_head is not empty. */
 
 /**
  * plist_first_entry - get the struct for the first entry
  *
- * @ptr:        the &struct pl_head pointer.
+ * @ptr:        the &struct plist_head pointer.
  * @type:       the type of the struct this is embedded in.
  * @member:     the name of the list_struct within the struct.
  */
@@ -215,13 +215,13 @@ static inline int plist_unhashed(const s
 /** 
  * plist_first - return the first node (and thus, highest priority)
  *
- * @head:	the &struct pl_head pointer
+ * @head:	the &struct plist_head pointer
  *
  * Assumes the plist is _not_ empty.
  */
-static inline struct pl_node* plist_first(const struct pl_head *head)
+static inline struct plist_node* plist_first(const struct plist_head *head)
 {
-	return list_entry(head->node_list.next, struct pl_node, plist.node_list);
+	return list_entry(head->node_list.next, struct plist_node, plist.node_list);
 }
 
 #endif
Index: linux-2.6.14/include/linux/sched.h
===================================================================
--- linux-2.6.14.orig/include/linux/sched.h
+++ linux-2.6.14/include/linux/sched.h
@@ -1026,7 +1026,7 @@ struct task_struct {
 #endif
 	/* realtime bits */
 	struct list_head delayed_put;
-	struct pl_head pi_waiters;
+	struct plist_head pi_waiters;
 
 	/* RT deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *blocked_on;
Index: linux-2.6.14/kernel/fork.c
===================================================================
--- linux-2.6.14.orig/kernel/fork.c
+++ linux-2.6.14/kernel/fork.c
@@ -1027,7 +1027,7 @@ static task_t *copy_process(unsigned lon
 #endif
 	INIT_LIST_HEAD(&p->delayed_put);
 	preempt_disable();
-	pl_head_init(&p->pi_waiters);
+	plist_head_init(&p->pi_waiters);
 	preempt_enable();
 	p->blocked_on = NULL; /* not blocked yet */
 	spin_lock_init(&p->pi_lock);
Index: linux-2.6.14/lib/plist.c
===================================================================
--- linux-2.6.14.orig/lib/plist.c
+++ linux-2.6.14/lib/plist.c
@@ -24,12 +24,12 @@
  * plist_add - add @node to @head returns !0 if the plist prio changed, 0
  * otherwise. XXX: Fix return code.
  *
- * @node:	&struct pl_node pointer
- * @head:	&struct pl_head pointer
+ * @node:	&struct plist_node pointer
+ * @head:	&struct plist_head pointer
  */
-void plist_add(struct pl_node *node, struct pl_head *head)
+void plist_add(struct plist_node *node, struct plist_head *head)
 {
-	struct pl_node *iter;
+	struct plist_node *iter;
 
 	INIT_LIST_HEAD(&node->plist.prio_list);
 
@@ -38,7 +38,7 @@ void plist_add(struct pl_node *node, str
 			goto lt_prio;
 		else if (node->prio == iter->prio) {
 			iter = list_entry(iter->plist.prio_list.next,
-					struct pl_node, plist.prio_list);
+					struct plist_node, plist.prio_list);
 			goto eq_prio;
 		}
 
@@ -52,9 +52,9 @@ eq_prio:
  * plist_del - Remove a @node from plist. returns !0 if the plist prio
  * changed, 0 otherwise. XXX: Fix return code.
  *
- * @node:	&struct pl_node pointer
+ * @node:	&struct plist_node pointer
  */
-void plist_del(struct pl_node *node)
+void plist_del(struct plist_node *node)
 {
 	if (!list_empty(&node->plist.prio_list)) {
 		struct pl_node *next = plist_first(&node->plist);
Index: linux-2.6.14/include/linux/init_task.h
===================================================================
--- linux-2.6.14.orig/include/linux/init_task.h
+++ linux-2.6.14/include/linux/init_task.h
@@ -121,7 +121,7 @@ extern struct group_info init_groups;
 	.alloc_lock	= SPIN_LOCK_UNLOCKED(tsk.alloc_lock),		\
 	.proc_lock	= SPIN_LOCK_UNLOCKED(tsk.proc_lock),		\
 	.delayed_put	= LIST_HEAD_INIT(tsk.delayed_put),		\
-	.pi_waiters	= PL_HEAD_INIT(tsk.pi_waiters),			\
+	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters),		\
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
Index: linux-2.6.14/kernel/rt.c
===================================================================
--- linux-2.6.14.orig/kernel/rt.c
+++ linux-2.6.14/kernel/rt.c
@@ -735,7 +735,7 @@ check_pi_list_present(struct rt_mutex *l
 	struct rt_mutex_waiter *w;
 
 	_raw_spin_lock(&old_owner->task->pi_lock);
-	TRACE_WARN_ON_LOCKED(plist_unhashed(&waiter->pi_list));
+	TRACE_WARN_ON_LOCKED(plist_empty_node(&waiter->pi_list));
 
 	plist_for_each_entry(w, &old_owner->task->pi_waiters, pi_list) {
 		if (w == waiter)
@@ -910,7 +910,7 @@ static void pi_setprio(struct rt_mutex *
 
 		TRACE_BUG_ON_LOCKED(!lock_owner(l));
 
-		if (!plist_unhashed(&w->pi_list)) {
+		if (!plist_empty_node(&w->pi_list)) {
 			TRACE_BUG_ON_LOCKED(!was_rt && !ALL_TASKS_PI && !rt_task(p));
 			/*
 			 * If the task is blocked on a lock, and we just restored
@@ -980,7 +980,7 @@ void pi_changeprio(struct task_struct *p
 	p->normal_prio = prio;
 
 	/* Check, if we can safely lower the priority */
-	if (prio > p->prio && !plist_empty(&p->pi_waiters)) {
+	if (prio > p->prio && !plist_empty_head(&p->pi_waiters)) {
 		struct rt_mutex_waiter *w;
 		w = plist_first_entry(&p->pi_waiters,
 				      struct rt_mutex_waiter, pi_list);
@@ -1021,7 +1021,7 @@ task_blocks_on_lock(struct rt_mutex_wait
 	task->blocked_on = waiter;
 	waiter->lock = lock;
 	waiter->ti = ti;
-	pl_node_init(&waiter->pi_list, task->prio);
+	plist_node_init(&waiter->pi_list, task->prio);
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
@@ -1060,7 +1060,7 @@ static void __init_rt_mutex(struct rt_mu
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
 	preempt_disable();
-	pl_head_init(&lock->wait_list);
+	plist_head_init(&lock->wait_list);
 	preempt_enable();
 #ifdef CONFIG_DEBUG_DEADLOCKS
 	lock->save_state = save_state;
@@ -1097,7 +1097,7 @@ void set_new_owner(struct rt_mutex *lock
 	if (unlikely(old_owner))
 		change_owner(lock, old_owner, new_owner);
 	lock->owner = new_owner;
-	if (!plist_empty(&lock->wait_list))
+	if (!plist_empty_head(&lock->wait_list))
 		set_lock_owner_pending(lock);
 #ifdef CONFIG_DEBUG_DEADLOCKS
 	if (trace_on) {
@@ -1199,7 +1199,7 @@ static inline void init_lists(struct rt_
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_DEADLOCKS)
 	// we have to do this until the static initializers get fixed:
 	if (unlikely(!lock->wait_list.prio_list.prev)) {
-		pl_head_init(&lock->wait_list);
+		plist_head_init(&lock->wait_list);
 #ifdef CONFIG_DEBUG_DEADLOCKS
 		pi_initialized++;
 #endif
@@ -1331,8 +1331,8 @@ capture_lock(struct rt_mutex_waiter *wai
 			ret = 0;
 		} else {
 			/* Add ourselves back to the list */
-			TRACE_BUG_ON_LOCKED(!plist_unhashed(&waiter->list));
-			pl_node_init(&waiter->list, task->prio);
+			TRACE_BUG_ON_LOCKED(!plist_empty_node(&waiter->list));
+			plist_node_init(&waiter->list, task->prio);
 			task_blocks_on_lock(waiter, ti, lock __W_EIP__(waiter));
 			ret = 1;
 		}
@@ -1352,16 +1352,16 @@ static inline void INIT_WAITER(struct rt
 {
 #ifdef CONFIG_DEBUG_DEADLOCKS
 	memset(waiter, 0x11, sizeof(*waiter));
-	pl_node_init(&waiter->list, MAX_PRIO);
-	pl_node_init(&waiter->pi_list, MAX_PRIO);
+	plist_node_init(&waiter->list, MAX_PRIO);
+	plist_node_init(&waiter->pi_list, MAX_PRIO);
 #endif
 }
 
 static inline void FREE_WAITER(struct rt_mutex_waiter *waiter)
 {
 #ifdef CONFIG_DEBUG_DEADLOCKS
-	TRACE_WARN_ON(!plist_unhashed(&waiter->list));
-	TRACE_WARN_ON(!plist_unhashed(&waiter->pi_list));
+	TRACE_WARN_ON(!plist_empty_node(&waiter->list));
+	TRACE_WARN_ON(!plist_empty_node(&waiter->pi_list));
 	memset(waiter, 0x22, sizeof(*waiter));
 #endif
 }
@@ -1388,7 +1388,7 @@ ____down(struct rt_mutex *lock __EIP_DEC
 
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
-		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON_LOCKED(!plist_empty_head(&lock->wait_list) && !old_owner);
 		if (old_owner) {
 			_raw_spin_lock(&old_owner->task->pi_lock);
 			set_new_owner(lock, old_owner, ti __EIP__);
@@ -1405,7 +1405,7 @@ ____down(struct rt_mutex *lock __EIP_DEC
 
 	set_task_state(task, TASK_UNINTERRUPTIBLE);
 
-	pl_node_init(&waiter.list, task->prio);
+	plist_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, ti, lock __EIP__);
 
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
@@ -1471,7 +1471,7 @@ ____down_mutex(struct rt_mutex *lock __E
 
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
-		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON_LOCKED(!plist_empty_head(&lock->wait_list) && !old_owner);
 		if (old_owner) {
 			_raw_spin_lock(&old_owner->task->pi_lock);
 			set_new_owner(lock, old_owner, ti __EIP__);
@@ -1486,7 +1486,7 @@ ____down_mutex(struct rt_mutex *lock __E
 		return;
 	}
 
-	pl_node_init(&waiter.list, task->prio);
+	plist_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, ti, lock __EIP__);
 
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
@@ -1596,10 +1596,10 @@ ____up_mutex(struct rt_mutex *lock, int 
 #endif
 
 #if ALL_TASKS_PI
-	if (plist_empty(&lock->wait_list))
+	if (plist_empty_head(&lock->wait_list))
 		check_pi_list_empty(lock, lock_owner(lock));
 #endif
-	if (unlikely(!plist_empty(&lock->wait_list))) {
+	if (unlikely(!plist_empty_head(&lock->wait_list))) {
 		if (save_state)
 			__up_mutex_waiter_savestate(lock __EIP__);
 		else
@@ -1854,7 +1854,7 @@ static int __sched __down_interruptible(
 
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
-		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON_LOCKED(!plist_empty_head(&lock->wait_list) && !old_owner);
 		if (old_owner) {
 			_raw_spin_lock(&old_owner->task->pi_lock);
 			set_new_owner(lock, old_owner, ti __EIP__);
@@ -1871,7 +1871,7 @@ static int __sched __down_interruptible(
 
 	set_task_state(task, TASK_INTERRUPTIBLE);
 
-	pl_node_init(&waiter.list, task->prio);
+	plist_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, ti, lock __EIP__);
 
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
@@ -1911,7 +1911,7 @@ wait_again:
 				 * If we were the last waiter then clear
 				 * the pending bit:
 				 */
-				if (plist_empty(&lock->wait_list))
+				if (plist_empty_head(&lock->wait_list))
 					lock->owner = lock_owner(lock);
 				/*
 				 * Just remove ourselves from the PI list.
@@ -1988,7 +1988,7 @@ static int __down_trylock(struct rt_mute
 
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
-		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON_LOCKED(!plist_empty_head(&lock->wait_list) && !old_owner);
 		if (old_owner) {
 			_raw_spin_lock(&old_owner->task->pi_lock);
 			set_new_owner(lock, old_owner, ti __EIP__);
@@ -2065,7 +2065,7 @@ static void __up_mutex_waiter_nosavestat
 	 */
 	_raw_spin_lock(&old_owner->pi_lock);
 	prio = old_owner->normal_prio;
-	if (unlikely(!plist_empty(&old_owner->pi_waiters))) {
+	if (unlikely(!plist_empty_head(&old_owner->pi_waiters))) {
 		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
 		if (w->ti->task->prio < prio)
 			prio = w->ti->task->prio;
@@ -2105,7 +2105,7 @@ static void __up_mutex_waiter_savestate(
 	 */
 	_raw_spin_lock(&old_owner->pi_lock);
 	prio = old_owner->normal_prio;
-	if (unlikely(!plist_empty(&old_owner->pi_waiters))) {
+	if (unlikely(!plist_empty_head(&old_owner->pi_waiters))) {
 		w = plist_first_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
 		if (w->ti->task->prio < prio)
 			prio = w->ti->task->prio;
@@ -2925,13 +2925,13 @@ EXPORT_SYMBOL_GPL(rt_mutex_owner);
 
 int fastcall rt_mutex_has_waiters(struct rt_mutex *lock)
 {
-	return !plist_empty(&lock->wait_list);
+	return !plist_empty_head(&lock->wait_list);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_has_waiters);
 
 int fastcall rt_mutex_free(struct rt_mutex *lock)
 {
-	return plist_empty(&lock->wait_list) && !lock->owner;
+	return plist_empty_head(&lock->wait_list) && !lock->owner;
 }
 
 int fastcall rt_mutex_owned_by(struct rt_mutex *lock, struct thread_info *t)
@@ -2958,7 +2958,7 @@ down_try_futex(struct rt_mutex *lock, st
 
 	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
 		/* granted */
-		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		TRACE_WARN_ON_LOCKED(!plist_empty_head(&lock->wait_list) && !old_owner);
 		if (old_owner) {
 			_raw_spin_lock(&old_owner->task->pi_lock);
 			set_new_owner(lock, old_owner, proxy_owner __EIP__);


