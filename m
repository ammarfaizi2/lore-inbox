Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWEUJws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWEUJws (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEUJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:52:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbWEUJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:52:47 -0400
Date: Sun, 21 May 2006 02:52:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: zach@vmware.com, virtualization@lists.osdl.org, torvalds@osdl.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386, vdso=[0|1] boot option and
 /proc/sys/vm/vdso_enabled
Message-Id: <20060521025222.1e2790f0.akpm@osdl.org>
In-Reply-To: <1148204118.31087.8.camel@localhost.localdomain>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060520010303.GA17858@elte.hu>
	<20060519181125.5c8e109e.akpm@osdl.org>
	<Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	<20060520085351.GA28716@elte.hu>
	<20060520022650.46b048f8.akpm@osdl.org>
	<446EE1C2.7060400@vmware.com>
	<20060520024842.69c77aaf.akpm@osdl.org>
	<446EE992.4020604@vmware.com>
	<1148186298.29161.8.camel@localhost.localdomain>
	<1148204118.31087.8.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Hypervisors want to use memory at the top of the address space
>  (eg. 64MB for Xen, or 168MB for Xen w/ PAE).  Creating this hole means
>  moving the vsyscall page away from 0xffffe000.
> 
>  If we create this hole statically with a config option, we give up,
>  say, 256MB of lowmem for the case where a hypervisor-capable kernel is
>  actually running on native hardware.
> 
>  If we create this hole dynamically and leave the vsyscall page at the
>  top of kernel memory, we would have to patch up the vsyscall elf
>  header at boot time to reflect where we put it.
> 
>  Instead, this patch moves the vsyscall page into the user address
>  region, just below PAGE_OFFSET: it's still at a fixed address, but
>  it's not where the hypervisor wants to be, so resizing the hole is
>  trivial.

Seems to work.
