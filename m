Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbUKXIR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbUKXIR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKXIPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:15:55 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:32179 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262547AbUKXIOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:14:50 -0500
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: Chris Wright <chrisw@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041123135144.F14339@build.pdx.osdl.net>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
	 <20041123080643.GD23974@kroah.com>
	 <1101219268.6210.133.camel@frecb000711.frec.bull.fr>
	 <20041123135144.F14339@build.pdx.osdl.net>
Date: Wed, 24 Nov 2004 09:14:46 +0100
Message-Id: <1101284087.6946.13.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/11/2004 09:21:52,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/11/2004 09:21:54,
	Serialize complete at 24/11/2004 09:21:54
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 13:51 -0800, Chris Wright wrote:
> * Guillaume Thouvenin (Guillaume.Thouvenin@Bull.net) wrote:
> > static int elsa_task_alloc_security(struct task_struct *p)
> > {
> > 	printk(KERN_ALERT "intercept a fork: %d created by %d\n",
> > 	       p->pid, p->parent->pid);
> 		       
> It's created by current.  So, current->pid.  p is not completely setup
> yet, and is still largely duplication of current from dup_task_struct().

I see. Thus the correct answer is: process pointed by "current" is the
parent of the process pointed by "p" when elsa_task_alloc_security() is
called. 

> And, IIRC, elsa is accounting related.
> LSM is not the right framework, you should be using something like PAGG
> or CKRM.

I understand your point of view. Elsa is accounting related that's true
but I'm trying to provide a solution without modifying the Linux kernel
tree. To achieve this I just need a hook in the fork to be inform when a
process creates a child. LSM hook does the trick and it is already in
the kernel. That's why I use the LSM hook (and I'm waiting to see PAGG
or CKRM in the Linux kernel).

Thanks,
Guillaume

