Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTI2TSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbTI2TSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:18:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:32723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264510AbTI2TRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:17:09 -0400
Date: Mon, 29 Sep 2003 11:56:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test6-mm1
Message-Id: <20030929115650.46472ede.akpm@osdl.org>
In-Reply-To: <20030929111447.GA21451@redhat.com>
References: <20030928191038.394b98b4.akpm@osdl.org>
	<20030929111447.GA21451@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Sun, Sep 28, 2003 at 07:10:38PM -0700, Andrew Morton wrote:
>  
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1
> 
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<02123550>] do_page_fault+0x0/0x588
>  [<021291be>] __might_sleep+0x9e/0xc0
>  [<021237e0>] do_page_fault+0x290/0x588
>  [<02135a85>] update_process_times+0x45/0x50
>  [<02113ab8>] timer_interrupt+0x188/0x1e0
>  [<0210ea0b>] do_IRQ+0x18b/0x230
>  [<02123550>] do_page_fault+0x0/0x588
> 

You have the 4G split enabled, and took a pagefault in the timer interrupt
handler.  Conceivably that fault hit vmalloc space, but I don't see how.

Even if it did, it shouldn't have got through to taking mmap_sem.

I'm stumped.  Maybe Ingo can spot it?

