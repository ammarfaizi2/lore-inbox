Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUCBXVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCBXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:21:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:42302 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261226AbUCBXVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:21:11 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021318580.796@chaos>
	<527jy3qalg.fsf@topspin.com> <Pine.LNX.4.53.0403021510270.1856@chaos>
	<52vflnq807.fsf@topspin.com> <Pine.LNX.4.53.0403021624300.2296@chaos>
	<52n06zq67n.fsf@topspin.com> <Pine.LNX.4.53.0403021651010.9048@chaos>
	<52hdx6rh7t.fsf@topspin.com> <Pine.LNX.4.53.0403021808240.9351@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 15:21:10 -0800
In-Reply-To: <Pine.LNX.4.53.0403021808240.9351@chaos>
Message-ID: <5265dmrg2h.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 23:21:10.0866 (UTC) FILETIME=[0C48DB20:01C400AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> There are two routines where the CPU is actually given
    Richard> up, do_select() and do_poll().  Search for
    Richard> schedule_timeout().  Once the scheduler has the CPU, it's
    Richard> available for any of the other drivers. It's also
    Richard> available for the timer queues, other tasks, and the
    Richard> interrupts.

OK, fine, I can't argue with that.  But it has nothing to do with the
discussion at hand.

You still haven't said where poll_wait() sleeps in kernel 2.4.  You
claimed it was in add_wait_queue(), but add_wait_queue() doesn't sleep
(it's just a list_add() guarded by a lock).

Also, why would another driver for the same poll() call run?  There's
only one thread around that cares about this call to poll() -- the
userspace process that originally called poll().  If one driver
sleeps, no other drivers will run until that driver wakes up.

 - Roland
