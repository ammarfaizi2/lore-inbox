Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbUCUQkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbUCUQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:40:40 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:28782 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263674AbUCUQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:40:39 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 21 Mar 2004 08:40:37 -0800
In-Reply-To: <405D7D2F.9050507@colorfullife.com>
Message-ID: <52u10i2lx6.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2004 16:40:37.0563 (UTC) FILETIME=[3D2B18B0:01C40F63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Manfred> I think just get_user_pages() should be sufficient: the
    Manfred> pages won't be swapped out. You don't need to set
    Manfred> VM_LOCKED in vma->vm_flags to prevent the swap out. In
    Manfred> the worst case, the pte is cleared a that will cause a
    Manfred> soft page fault, but the physical address won't
    Manfred> change. Multiple get_user_pages() calls on overlapping
    Manfred> regions are ok, the page count is an atomic_t, at least
    Manfred> 24-bit large.

There is one case that we ran into where the physical address can
change: if a process does a fork() and then triggers COW.

 - Roland

