Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWJTM5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWJTM5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWJTM5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:57:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:17385 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423125AbWJTM5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:57:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=PWfAemRPXj7/zJqo5cLEe6kVi/AC2cveq6LhHUJzO+XeYMjXYzDnPK+1n75TxFhV0694VWA1NpMKShDAV2U6JgsBdu+P9g++akhhPbTzdQHZ8frQvLEuQkTAu3VusC2N8lfN0v6bxwbbrEHkrZk7o+xAxIdZ6EWQxkfdrx9qboo=
Date: Fri, 20 Oct 2006 16:57:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: [PATCH 1/3] parisc: use "unsigned long flags" in semaphore code
Message-ID: <20061020125722.GA17199@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like everyone else.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-parisc/semaphore.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/include/asm-parisc/semaphore.h
+++ b/include/asm-parisc/semaphore.h
@@ -115,7 +115,8 @@ extern __inline__ int down_interruptible
  */
 extern __inline__ int down_trylock(struct semaphore * sem)
 {
-	int flags, count;
+	unsigned long flags;
+	int count;
 
 	spin_lock_irqsave(&sem->sentry, flags);
 	count = sem->count - 1;
@@ -131,7 +132,7 @@ extern __inline__ int down_trylock(struc
  */
 extern __inline__ void up(struct semaphore * sem)
 {
-	int flags;
+	unsigned long flags;
 	spin_lock_irqsave(&sem->sentry, flags);
 	if (sem->count < 0) {
 		__up(sem);

