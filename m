Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbUKXOQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUKXOQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUKXON4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:13:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29170 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262651AbUKXODO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:03:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16804.38029.818691.368174@alkaid.it.uu.se>
Date: Wed, 24 Nov 2004 15:02:53 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.28] gcc34 fastcall mismatch fixes for rwsem-spinlock
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.28 fails to compile with gcc-3.4 when CONFIG_M386=y
because of fastcall mismatches between include/linux/rwsem-spinlock.h
and lib/rwsem-spinlock.c. This patch fixes that.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 lib/rwsem-spinlock.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -rupN linux-2.4.28/lib/rwsem-spinlock.c linux-2.4.28.gcc34-fastcall-fixes/lib/rwsem-spinlock.c
--- linux-2.4.28/lib/rwsem-spinlock.c	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28.gcc34-fastcall-fixes/lib/rwsem-spinlock.c	2004-11-24 14:41:34.000000000 +0100
@@ -32,7 +32,7 @@ void rwsemtrace(struct rw_semaphore *sem
 /*
  * initialise the semaphore
  */
-void init_rwsem(struct rw_semaphore *sem)
+void fastcall init_rwsem(struct rw_semaphore *sem)
 {
 	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
@@ -120,7 +120,7 @@ static inline struct rw_semaphore *__rws
 /*
  * get a read lock on the semaphore
  */
-void __down_read(struct rw_semaphore *sem)
+void fastcall __down_read(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
@@ -166,7 +166,7 @@ void __down_read(struct rw_semaphore *se
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
-int __down_read_trylock(struct rw_semaphore *sem)
+int fastcall __down_read_trylock(struct rw_semaphore *sem)
 {
 	int ret = 0;
 	rwsemtrace(sem,"Entering __down_read_trylock");
@@ -189,7 +189,7 @@ int __down_read_trylock(struct rw_semaph
  * get a write lock on the semaphore
  * - note that we increment the waiting count anyway to indicate an exclusive lock
  */
-void __down_write(struct rw_semaphore *sem)
+void fastcall __down_write(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
@@ -235,7 +235,7 @@ void __down_write(struct rw_semaphore *s
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
-int __down_write_trylock(struct rw_semaphore *sem)
+int fastcall __down_write_trylock(struct rw_semaphore *sem)
 {
 	int ret = 0;
 	rwsemtrace(sem,"Entering __down_write_trylock");
@@ -257,7 +257,7 @@ int __down_write_trylock(struct rw_semap
 /*
  * release a read lock on the semaphore
  */
-void __up_read(struct rw_semaphore *sem)
+void fastcall __up_read(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering __up_read");
 
@@ -274,7 +274,7 @@ void __up_read(struct rw_semaphore *sem)
 /*
  * release a write lock on the semaphore
  */
-void __up_write(struct rw_semaphore *sem)
+void fastcall __up_write(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering __up_write");
 
