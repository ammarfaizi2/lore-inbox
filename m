Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTHTS12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbTHTS12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:27:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:16273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbTHTS11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:27:27 -0400
Date: Wed, 20 Aug 2003 11:29:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: BKL on reboot ?
Message-Id: <20030820112918.0f7ce4fe.akpm@osdl.org>
In-Reply-To: <3F434BD1.9050704@suse.de>
References: <3F434BD1.9050704@suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <Hannes.Reinecke@suse.de> wrote:
>
> Hiya,
> 
> I've got a dumb question: Why is the BKL held on entering sys_reboot() 
> in kernel/sys.c:405 ?

Probably for no good reason.

> It is getting especially interesting on SMP, when one cpu is entering 
> sys_reboot, acquires the BKL and then waits (via machine_restart) for 
> all other cpus to shut down. If any of the other cpus is executing a 
> task which also needs the BKL, we have a nice deadlock.
> We've seen this here on 2-way s390, where the other cpu tried to execute 
> kupdated() (what did it try that for? Anyway...), which of course 
> resulted in a deadlock.

I guess that dropping the BKL around the machine_restart() call would be an
appropriate 2.4 fix.

Where exactly does the rebooting CPU get stuck in machine_restart()?  If
someone has done lock_kernel() with local interrupts disabled then yes,
it'll deadlock.  But that's unlikely?  Confused.

