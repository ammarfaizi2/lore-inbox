Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVASVcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVASVcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVASVcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:32:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:27551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261906AbVASVcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:32:01 -0500
Date: Wed, 19 Jan 2005 13:31:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 hang
Message-Id: <20050119133136.7a1c0454.akpm@osdl.org>
In-Reply-To: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
References: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I was playing with kexec+kdump and ran into this on 2.6.10-mm1.
>  I have seen similar behaviour on 2.6.10. 
> 
>  I am using a 4-way P-III machine. I have a module which tries
>  gets same spinlock twice. When I try to "insmod" this module,
>  my system hangs. All my windows froze, no more new logins,
>  console froze, doesn't respond to sysrq. I wasn't expecting
>  a system hang. Why ? Ideas ?
> 

Maybe all the other CPUs are stuck trying to send an IPI to this one?  An
NMI watchdog trace would tell.

>  #include <linux/init.h>
>  #include <asm/uaccess.h>
>  #include <linux/spinlock.h>
>  spinlock_t mylock = SPIN_LOCK_UNLOCKED;
>  static int __init panic_init(void)
>  {
>          spin_lock_irq(&mylock);
>          spin_lock_irq(&mylock);
>         return 1;
>  }
