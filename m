Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWAWFiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWAWFiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAWFiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:38:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbWAWFiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:38:12 -0500
Date: Sun, 22 Jan 2006 21:37:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] device-mapper log bitset: fix endian
Message-Id: <20060122213741.7d2ed8ef.akpm@osdl.org>
In-Reply-To: <20060120211300.GC4724@agk.surrey.redhat.com>
References: <20060120211300.GC4724@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
>  -	set_bit(bit, (unsigned long *) bs);
>  +	ext2_set_bit(bit, (unsigned long *) bs);

We really should give those things a more appropriate name.

ext2_set_bit() is non-atomic, so the above code must provide its own
locking against other CPUs (and threads, if preempt) performing
modification of this memory.

Is such locking present?  If not, we should use ext2_set_bit_atomic(). 
(And if so, the old code could have used __set_bit)
