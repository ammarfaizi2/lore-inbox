Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULJMmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULJMmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 07:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULJMmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 07:42:02 -0500
Received: from pop.gmx.net ([213.165.64.20]:13258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261188AbULJMmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 07:42:00 -0500
Date: Fri, 10 Dec 2004 13:41:58 +0100 (MET)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, mtk-lkml@gmx.net, alan@redhat.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <41B898F8.6060500@colorfullife.com>
Subject: Re: [PATCH] fix missing wakeup in ipc/sem
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <24417.1102682518@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred,

> My patch that removed the spin_lock calls from the tail of
> sys_semtimedop introduced a bug:
> Before my patch was merged, every operation that altered an array called
> update_queue. That call woke up threads that were waiting until a
> semaphore value becomes 0. I've accidentially removed that call.
> 
> The attached patch fixes that by modifying update_queue: the function
> now loops internally and wakes up all threads. The patch also removes
> update_queue calls from the error path of sys_semtimedop: failed
> operations do not modify the array, no need to rescan the list of
> waiting threads.

Thanks -- tested on 2.6.10-rc3 and it works for me.

Cheers,

Michael

-- 
GMX ProMail mit bestem Virenschutz http://www.gmx.net/de/go/mail
+++ Empfehlung der Redaktion +++ Internet Professionell 10/04 +++
