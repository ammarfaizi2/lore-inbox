Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTILXPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTILXPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:15:44 -0400
Received: from [65.248.4.67] ([65.248.4.67]:26550 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261938AbTILXPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:15:40 -0400
Message-ID: <00ed01c37962$141237c0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br> <20030912165047.Z18851@schatzie.adilger.int>
Subject: Re: stack overflow
Date: Fri, 12 Sep 2003 20:14:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that size limit of user stack is 8mb

Breno
----- Original Message -----
From: "Andreas Dilger" <adilger@clusterfs.com>
To: "Breno" <brenosp@brasilsec.com.br>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
Sent: Friday, September 12, 2003 11:50 PM
Subject: Re: stack overflow


> On Sep 12, 2003  18:53 +0100, Breno wrote:
> > Hi ... this is my idea to check a stack overflow. What do you think ?
> >
> > #define STACK_LIMIT (1024*8192)/PAGE_SIZE
> >
> > int check_stack_overflow(struct task_struct *tsk)
> > {
> >
> >     unsigned long stack_size,stack_addr,stack_ptr;
> >     int i;
> >
> >          if(tsk->mm != NULL)
> >          {
> >                   stack_addr = tsk->mm->start_stack;
> >
> >                   stack_ptr = tsk->thread.esp;
> >
> >                   for(i=0; i < stack_ptr; i++)
> >                   stack_addr++;
> >
> >                   stack_size = (stack_addr - stack_ptr)/PAGE_SIZE;
> >
> >                   if(stack_size > ( STACK_LIMIT - 1))
>
> Well, with the exception of the fact that STACK_LIMIT is 8MB, and kernel
> stacks are only 8kB (on i386)...
>
> Also, see "do_IRQ()" (i386) for CONFIG_DEBUG_STACKOVERFLOW to see this
already.
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

