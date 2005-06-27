Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVF0IYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVF0IYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVF0IYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:24:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261926AbVF0IXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:23:04 -0400
Date: Mon, 27 Jun 2005 01:22:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.12-mm2
Message-Id: <20050627012226.450bc86d.akpm@osdl.org>
In-Reply-To: <42BFAF1F.8050201@reub.net>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no>
	<42BFA05B.1090208@reub.net>
	<20050627002429.40231fdf.akpm@osdl.org>
	<42BFAF1F.8050201@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
>  > Anyway, scary trace.  It look like some spinlock is thought to be in the
>  > wrong state in schedule().  Send the .config, please.
> 
>  Now online at  http://www.reub.net/kernel/.config

Me too.

BUG: spinlock recursion on CPU#0, swapper/0, c120d520             
 [<c01039ed>] dump_stack+0x19/0x20                   
 [<c01d9af2>] spin_bug+0x42/0x54  
 [<c01d9bfa>] _raw_spin_lock+0x3e/0x84
 [<c031d0ad>] _spin_lock+0x9/0x10     
 [<c031b9e9>] schedule+0x479/0xbc8
 [<c0100cb4>] cpu_idle+0x88/0x8c  
 [<c01002c1>] rest_init+0x21/0x28
 [<c0442899>] start_kernel+0x151/0x158
 [<c010020f>] 0xc010020f              
Kernel panic - not syncing: bad locking

The bug is in the new spinlock debugging code itself.  Ingo, can you test
that .config please?

Reuben, I guess disabling CONFIG_DEBUG_SPINLOCK will get you going.
