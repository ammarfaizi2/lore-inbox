Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUEGFSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUEGFSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUEGFSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 01:18:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:45788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261920AbUEGFSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 01:18:07 -0400
Date: Thu, 6 May 2004 22:17:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
Subject: Re: Is it possible to implement interrupt time printk's reliably?
Message-Id: <20040506221746.7bb45421.akpm@osdl.org>
In-Reply-To: <20040507025252.38914.qmail@web14929.mail.yahoo.com>
References: <20040507025252.38914.qmail@web14929.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@yahoo.com> wrote:
>
> Problem:
>  1) Some operations on graphics cards cannot be stopped once they are started.
>  It's not reasonable to turn interrupts off around these operations.
>  2) Kernel developers want console printk's to work from interrupt routines.
> 
>  How do you fix this situation?

Really you should use spin_lock_irqsave() on some driver-private lock
around the operation.  Why is it not reasonable to disable irq's? 
Duration, presumably?

If you're in process context you can use acquire_console_sem(), which will
serialise against printk.

