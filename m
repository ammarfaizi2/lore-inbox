Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVFIWZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVFIWZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVFIWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:25:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33781 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S262489AbVFIWZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:25:19 -0400
Date: Thu, 9 Jun 2005 15:25:18 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: George Anzinger <george@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: RT and timers
In-Reply-To: <42A8BF18.80706@mvista.com>
Message-ID: <Pine.LNX.4.44.0506091520210.11001-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George, 

	I wanted to show you the code below, from the RT patch. I think 
it's possible that, if the code isn't changed in the way below, the 
while() loop could run forever. If jiffies is very fast moving , and the 
softirqd is low priority. Do you have any comments on this?

Daniel


@@ -436,13 +437,30 @@ static int cascade(tvec_base_t *base, tv
 static inline void __run_timers(tvec_base_t *base)
 {
        struct timer_list *timer;
+       unsigned long jiffies_sample = jiffies;

        spin_lock_irq(&base->lock);
-       while (time_after_eq(jiffies, base->timer_jiffies)) {
+       while (time_after_eq(jiffies_sample, base->timer_jiffies)) {
                struct list_head work_list = LIST_HEAD_INIT(work_list);
                struct list_head *head = &work_list;
                int index = base->timer_jiffies & TVR_MASK;


