Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWBPO6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWBPO6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWBPO6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:58:34 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:9603 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932530AbWBPO6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:58:33 -0500
Date: Thu, 16 Feb 2006 15:58:23 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <20060216145823.GA25759@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Ulrich Drepper <drepper@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@infradead.org>,
	David Singleton <dsingleton@mvista.com>,
	Andrew Morton <akpm@osdl.org>
References: <20060215151711.GA31569@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215151711.GA31569@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.190.174.89
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006, Ingo Molnar wrote:
> "Robustness" is about dealing with crashes while holding a lock: if a 
> process exits prematurely while holding a pthread_mutex_t lock that is 
> also shared with some other process (e.g. yum segfaults while holding a 
> pthread_mutex_t, or yum is kill -9-ed), then waiters for that lock need 
> to be notified that the last owner of the lock exited in some irregular 
> way.
...
> At the heart of this new approach there is a per-thread private list of 
> robust locks that userspace is holding (maintained by glibc) - which 
> userspace list is registered with the kernel via a new syscall [this 
> registration happens at most once per thread lifetime]. At do_exit() 
> time, the kernel checks this user-space list: are there any robust futex 
> locks to be cleaned up?
...
> i've tested the new syscalls on x86 and x86_64, and have made sure the 
> parsing of the userspace list is robust [ ;-) ] even if the list is 
> deliberately corrupted.

I've no knowledge about all this, and maybe I didn't get your
description, so forgive me if I'm talking garbage.

Anyway: If a process can trash its robust futext list and then
die with a segfault, why are the futexes still robust?
In this case the kernel has no way to wake up waiters with
FUTEX_OWNER_DEAD, or does it?


Johannes
