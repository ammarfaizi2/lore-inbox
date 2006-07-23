Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGWARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGWARr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGWARr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:17:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7399 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWGWARr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:17:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:subject:message-id:mime-version:content-type;
        b=qNj0WrmNBOJ7L4GuXrUUH8VGDq1wuc/J1k8t8r0m4DleSwe5JcS1RjeECif9YdHeL4qVlJHHYQwsSq03TxGANmp5GxW1uW/+nTdDaXpq+ECmr6k3h4sU1fCbsqzMskVa9ekfG/5XyYC44B87ycwPe0ACkG06cLJQ933EKimDcLY=
Date: Sun, 23 Jul 2006 02:18:11 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Hi,
  I finally got around to send in the a new version of my fixes to PI. The main 
purpose is to fix the timeout bug of the rtmutex/PI-futex. To refresh:

If you try to take a rtmutex or a PI-futex with a timeout on UP machine you
will not get the lock before the owner is done with it anyway. This is because
the owner is boosted to the same priority as your task. When your task gets
the timeout it will not get the CPU and the owner will not be de-boosted
before it releases the lock on it's own.

This series of patches fixes that bug and in general secures the PI code 
against similar problems, which might be there, due to the preemptive 
PI-walking. Furthermore, it makes setscheduler() do the PI-walking - or
rather make the target task do it.

Esben
