Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUCURPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUCURPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:15:32 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:8576 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263684AbUCURPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:15:22 -0500
Message-ID: <405DCDA1.3080008@colorfullife.com>
Date: Sun, 21 Mar 2004 18:15:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com> <52u10i2lx6.fsf@topspin.com>
In-Reply-To: <52u10i2lx6.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>    Manfred> I think just get_user_pages() should be sufficient: the
>    Manfred> pages won't be swapped out. You don't need to set
>    Manfred> VM_LOCKED in vma->vm_flags to prevent the swap out. In
>    Manfred> the worst case, the pte is cleared a that will cause a
>    Manfred> soft page fault, but the physical address won't
>    Manfred> change. Multiple get_user_pages() calls on overlapping
>    Manfred> regions are ok, the page count is an atomic_t, at least
>    Manfred> 24-bit large.
>
>There is one case that we ran into where the physical address can
>change: if a process does a fork() and then triggers COW.
>
You are right.
What should happen if there are registered transfers during fork()? Copy 
the pages during the fork() syscall?

--
    Manfred

