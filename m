Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUJMOWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUJMOWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269726AbUJMOWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:22:47 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:23945 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269725AbUJMOWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:22:45 -0400
Message-ID: <02bb01c4b138$8a786f10$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: <linux-kernel@vger.kernel.org>
Subject: waiting on a condition
Date: Wed, 13 Oct 2004 16:23:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.

I'd like to do something similar as can be done using a POSIX condition
variable in the kernel, i.e. wait for some condition to become true. The
pthread_cond_wait() function allows atomically unlocking a mutex and
waiting on a condition. I think I should do something like:
(the condition is updated from an interrupt handler)

disable interrupts
acquire spinlock
if condition not satisfied
    add task to wait queue
    set task to sleep
release spinlock
restore interrupts
schedule

Now, this will only work with preemption disabled within the critical
section. How would something like this be done whith preemption
enabled?


--ms




