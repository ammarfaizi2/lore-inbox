Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUJFPVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUJFPVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJFPSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:18:43 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:41481 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S269300AbUJFPSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:18:10 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Proper use of daemonize()?
Date: Wed, 6 Oct 2004 11:18:07 -0400
Organization: Connect Tech Inc.
Message-ID: <030601c4abb7$af573770$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at the kernel threads that use daemonize() and have
some questions about the proper use of this call:

1: Some threads use the lock_kernel() calls around the daemonize()
call. Is this necessary? I thought the BKL was phasing out.

2: Some threads do their setup (like changing the comm string, setting
the signal masks, etc) before daemonize(), some do it after. Is there
any benefit to a particular order of operations? I can't see one.

3: Some threads set current->tty to NULL. Why would a thread *not* do
this?

4: Some threads grab the sigmask_lock before manipulating their masks.
Is this necessary? If so, some threads have bugs. If not, why do some
threads bother?

5: Some threads do flush_signals() or recalc_sigpending() before
updating their blocked mask, some do it after. Does the order matter?
I suspect not.

6: MOD_INC_USE_COUNT should be used by all threads that could be in
drivers built as modules, correct?

7: If you're not spawning a permanent kernel thread (like kswapd frex)
is the any benefit to using reparent_to_init()? I can't see one.

Thanks,
..Stu

