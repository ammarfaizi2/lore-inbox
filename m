Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUJKP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUJKP2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbUJKP15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:27:57 -0400
Received: from ns1.kazix.com ([69.93.95.154]:30644 "EHLO server1.kazix.com")
	by vger.kernel.org with ESMTP id S268971AbUJKP0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:26:37 -0400
From: Vadim Lebedev <vadim@mbdsys.com>
Organization: MBDSYS
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Mon, 11 Oct 2004 17:28:39 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111728.39200.vadim@mbdsys.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server1.kazix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mbdsys.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote in message 
news:<2Nir3-4iC-13@gated-at.bofh.it>...
> Announcing the availability of prototype real-time (RT)
> enhancements to the Linux 2.6 kernel.

Reading the sources i believe that __p_mutex_up  is not constant time
operation because of __p_mutex_down....

It is clear that
__p_mutex_down is not constant time operation because of insertion
into the priority-sorted sleepers list.  However both __p_mutex_down
and __p_mutex_up are synchronize on the same global spinlock
(m_spin_lock) ....  so if the __p_mutex_down is holding this spinlock
while inserting NO other process(or) is able to perform any __p_mutex
operation...

Maybe the better idea would be to have a per-mutex spinlock? or even
better, given that the task->rt_priority have a finite range maybe each
mutex can have a table of sleeper lists indexed by rt_priority?


Vadim
