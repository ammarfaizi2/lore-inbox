Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSHTNE7>; Tue, 20 Aug 2002 09:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSHTNE7>; Tue, 20 Aug 2002 09:04:59 -0400
Received: from pD9E23620.dip.t-dialin.net ([217.226.54.32]:27526 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317056AbSHTNE5>; Tue, 20 Aug 2002 09:04:57 -0400
Date: Tue, 20 Aug 2002 07:08:55 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: William Lee Irwin III <wli@holomorphy.com>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Generic list push/pop
In-Reply-To: <20020819120550.GA21683@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0208200701580.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Aug 2002, William Lee Irwin III wrote:
> How's this look?

Doesn't solve the typeness. Anyway, this work had already been done by 
Thomas 'Dent' Mirlacher. We might want to work on that.

=== BEGIN INCLUDEDE MESSAGE ===
From:     "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To:       "Thunder from the hill" <thunder@ngforever.de>
Date:     2002-06-09 15:45:53
Subject:  [PATCH] adding slist.h: simple single-linked-list helper functions

hi,

this patch adds slist.h, a header-file providing simple single-linked-list
helper functions.

especially slist_for_each will improve:
	o readability
	o performance (due to the use of prefetch())
wherever it's used

please apply,

	tm

diff -Nru a/include/linux/slist.h b/include/linux/slist.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/linux/slist.h     Sun Jun  9 22:32:55 2002
@@ -0,0 +1,57 @@
+#ifndef _LINUX_SLIST_H
+#define _LINUX_SLIST_H
+
+#if defined(__KERNEL__)
+
+#include <linux/prefetch.h>
+
+/*
+ * Simple single linked list helper-functions.
+ * (taken from list.h)
+ */
+
+/**
+ * slist_add_front - add a new entry at the first slot, moving the old head
+ *                     to the second slot
+ * @new:       new entry to be added
+ * @head:      head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ */
+
+#define slist_add_front(_new, _head)   \
+do {                                   \
+       _new->next = _head;             \
+       _head = _new->next;             \
+} while (0)
+
+
+/**
+ * slist_add - add a new entry
+ * @new:       new entry to be added
+ * @head:      head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ */
+
+#define slist_add(_new, _head)         \
+do {                                   \
+       _new->next = _head->next;       \
+       _head->next = _new;             \
+} while (0)
+
+
+/**
+ * slist_for_each      -       iterate over a list
+ * @pos:       the pointer to use as a loop counter.
+ * @head:      the head for your list (this is also the first entry).
+ */
+#define slist_for_each(pos, head) \
+       for (pos = head, prefetch(pos->next); pos; \
+               pos = pos->next, prefetch(pos->next))
+
+
+#endif /* __KERNEL__ */
+
+#endif

-- 
in some way i do, and in some way i don't.
=== END INCLUDED MESSAGE ===

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

