Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVDNJti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVDNJti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 05:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDNJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 05:49:38 -0400
Received: from mail01.baslerweb.com ([145.253.187.134]:19422 "EHLO
	mail01.baslerweb.com") by vger.kernel.org with ESMTP
	id S261215AbVDNJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 05:49:22 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-kernel@vger.kernel.org
Subject: need advice about wait queue usage
Date: Thu, 14 Apr 2005 11:49:19 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200504141149.20001.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anybody on this list answer the following question:

My code contains a call to wait_event_interruptible_exclusive().
This results in the current task going to sleep on a wait queue.
It builds a wait_queue_t struct in its current stack frame,
setting the .func member to autoremove_wake_function(), adds it
to the wait queue, and finally reschedules.

At a later point in time, another thread calls wake_up_interruptible()
on the wait queue. This results in a call to autoremove_wake_function(),
which in turn calls default_wake_function(), which then calls
try_to_wake_up(). At this point, the previously sleeping task becomes
runnable again. Then, after default_wake_function() returns,
list_del_init() is called to remove the wait_queue_t from the
wait queue.

Now, since the wait_queue_t is allocated in the stack frame of the
just woken-up task, which could already be running at this point,
how can I be sure that the wait_queue_t is still valid at the point
list_del_init() is called to remove it from the wait queue? It
seems to me that I cannot and hence autoremove_wake_function() is
broken, or am I missing something?

Any responders pls. cc me; I am not subscribed to this list.

thanks,
Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
