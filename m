Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUGNWq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUGNWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 18:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUGNWq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 18:46:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:21389 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265966AbUGNWq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 18:46:27 -0400
Date: Wed, 14 Jul 2004 14:31:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, lmb@suse.de
Subject: Re: [PATCH] was: [RFC] removal of sync in panic
Message-Id: <20040714143112.1d8d1892.akpm@osdl.org>
In-Reply-To: <200407141939.52316.linux-kernel@borntraeger.net>
References: <200407141745.47107.linux-kernel@borntraeger.net>
	<20040714162357.GU3922@marowsky-bree.de>
	<200407141939.52316.linux-kernel@borntraeger.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger <linux-kernel@borntraeger.net> wrote:
>
> Lars Marowsky-Bree wrote:
> > > 1. remove sys_sync completely: syslogd and klogd use fsync. No need to
> > > help them. Furthermore we have a severe problem which is worth a panic,
> > > so we better dont do any I/O.
> 
> > I've seen exactly the behaviour you describe and would be inclined to go
> > for this option too.
> 
> As this problem definitely exists, here is a patch. 
> 
> --- linux-2.6.8-rc1/kernel/panic.c      2004-06-16 07:20:04.000000000 +0200
> +++ linux-patch/kernel/panic.c  2004-07-14 19:37:02.000000000 +0200
> @@ -59,13 +59,7 @@ NORET_TYPE void panic(const char * fmt,
>         va_start(args, fmt);
>         vsnprintf(buf, sizeof(buf), fmt, args);
>         va_end(args);
> -       printk(KERN_EMERG "Kernel panic: %s\n",buf);
> -       if (in_interrupt())
> -               printk(KERN_EMERG "In interrupt handler - not syncing\n");
> -       else if (!current->pid)
> -               printk(KERN_EMERG "In idle task - not syncing\n");
> -       else
> -               sys_sync();
> +       printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
>         bust_spinlocks(0);
> 
>  #ifdef CONFIG_SMP

I agree with the patch in principle, but I'd be interested in what observed
problem motivated it?
