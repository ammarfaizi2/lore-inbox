Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWIQFYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIQFYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWIQFYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:24:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWIQFYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:24:14 -0400
Date: Sat, 16 Sep 2006 22:24:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, adobriyan@gmail.com, rossb@google.com
Subject: Re: [PATCH] config.gz doesn't need module_exit
Message-Id: <20060916222408.c3268a89.akpm@osdl.org>
In-Reply-To: <20060916151122.7d57eeb8.rdunlap@xenotime.net>
References: <20060916151122.7d57eeb8.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 15:11:22 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> This is an alternative patch to the current /proc/config.gz
> 'module' patch from Ross.  Pointed out by Alexey.
> 
> /proc/config.gz handler doesn't need module_exit() since it
> isn't built as a module and the exit function won't be used
> when the code is built into the kernel.

It doesn't buy us much though - the __exit code is all freed up
at runtime.

Or it should be. arch/i386/kernel/vmlinux.lds.S says

  /* .exit.text is discard at runtime, not link time, to deal with references
     from .altinstructions and .eh_frame */

but free_initmem() doesn't free it.
