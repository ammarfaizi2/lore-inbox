Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268721AbUILNi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbUILNi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUILNi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:38:56 -0400
Received: from ozlabs.org ([203.10.76.45]:26767 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268721AbUILNiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:38:46 -0400
Date: Sun, 12 Sep 2004 23:34:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912133414.GP25741@krispykreme>
References: <20040912085609.GK32755@krispykreme> <1094991480.2626.0.camel@laptop.fenrus.com> <20040912122959.GN25741@krispykreme> <20040912124420.GA29587@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912124420.GA29587@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> /*
>  * the semaphore definition
>  */
> struct rw_semaphore {
>         /* XXX this should be able to be an atomic_t  -- paulus */
>         signed int              count;
> #define RWSEM_UNLOCKED_VALUE            0x00000000
> #define RWSEM_ACTIVE_BIAS               0x00000001
> #define RWSEM_ACTIVE_MASK               0x0000ffff
> 
> that counter is split in 2 16 bit entities....

Yuck, 64k waiters is asking for trouble. BTW x86-64 mentions it can only
handle 32k writers, that probably wants looking at.

Anton
