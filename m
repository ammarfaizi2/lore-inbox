Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUKWVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUKWVyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUKWVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:53:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:39579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbUKWVvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:51:45 -0500
Date: Tue, 23 Nov 2004 13:51:44 -0800
From: Chris Wright <chrisw@osdl.org>
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
Message-ID: <20041123135144.F14339@build.pdx.osdl.net>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr> <20041123080643.GD23974@kroah.com> <1101219268.6210.133.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101219268.6210.133.camel@frecb000711.frec.bull.fr>; from Guillaume.Thouvenin@Bull.net on Tue, Nov 23, 2004 at 03:14:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Guillaume Thouvenin (Guillaume.Thouvenin@Bull.net) wrote:
> static int elsa_task_alloc_security(struct task_struct *p)
> {
> 	printk(KERN_ALERT "intercept a fork: %d created by %d\n",
> 	       p->pid, p->parent->pid);
		       
It's created by current.  So, current->pid.  p is not completely setup
yet, and is still largely duplication of current from dup_task_struct().

>   PID  PPID USER     %CPU CPU COMMAND
>  2009  2008 guill     0.0   0 bash
>  2109  2108 guill     0.0   0 bash
>  2704  2109 guill     0.0   0 top
> 
> and here is the message found in the kernel log:
> 
>  intercept a fork: 2704 created by 2108
> 
> It should be 2109... not 2108
> I think that the problem occurs because the security_task_alloc() is
> called, the field p->parent is not set. 
> 
> Is it true? and if it is, is it possible to move the hook after the
> initialization of the variable p->parent?

No, it's correct where it is.  And, IIRC, elsa is accounting related.
LSM is not the right framework, you should be using something like PAGG
or CKRM.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
