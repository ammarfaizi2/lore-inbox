Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVL1Ak2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVL1Ak2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVL1Ak2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:40:28 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:56722 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932417AbVL1Ak1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:40:27 -0500
Date: Wed, 28 Dec 2005 09:40:20 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: oom-killer causes lockups in cpuset_excl_nodes_overlap()
X-Mailer: Sylpheed version 2.1.6+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20051228004026.72F3474005@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oom-killer causes lockups because it calls
cpuset_excl_nodes_overlap() with tasklist_lock read-locked.
cpuset_excl_nodes_overlap() gets cpuset_sem (or callback_sem in
later linux versions) semaphore, which might_sleep even if the
semaphore could be down without sleeping.  If processes call
exit() or fork() when the oom-killer sleeps in the down(), they
lockup because they call write_lock_irq(&tasklist_lock).

The lockup occurred on linux-2.6.14.  The problem also seems to exist
in linux-2.6.15-rc5-mm3 and linux-2.6.15-rc7.

Regards,

-- 
KUROSAWA, Takahiro
