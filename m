Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVLBCFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVLBCFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLBCFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:05:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964786AbVLBCFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:05:23 -0500
Date: Thu, 1 Dec 2005 18:04:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: lkml@rtr.ca, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix bytecount result from printk()
Message-Id: <20051201180459.2afa2b1d.akpm@osdl.org>
In-Reply-To: <20051201175732.GD19433@redhat.com>
References: <438F1D05.5020004@rtr.ca>
	<20051201175732.GD19433@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Thu, Dec 01, 2005 at 10:55:49AM -0500, Mark Lord wrote:
>  > printk() returns a bytecount, which nothing actually appears to use.
> 
> We do check it in a few places.
> 
> arch/x86_64/kernel/traps.c:                             i += printk(" "); \
> arch/x86_64/kernel/traps.c:                     i += printk(" <%s> ", id);
> arch/x86_64/kernel/traps.c:                     i += printk(" <EOE> ");
> arch/x86_64/kernel/traps.c:                             i += printk(" <IRQ> ");
> arch/x86_64/kernel/traps.c:                             i += printk(" <EOI> ");
> drivers/char/mem.c:             ret = printk("%s", tmp);
> 

And if you don't fix kmsg_write(), this patch will actually break /dev/kmsg
- userspace complains about the write() return value.

Please review these patches, queued since 2.6.15-rc1-mm1:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/broken-out/printk-return-value-fix-it.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/broken-out/kmsg_write-dont-return-printk-return-value.patch
