Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTILWws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTILWws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:52:48 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:8184 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261940AbTILWwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:52:17 -0400
Date: Fri, 12 Sep 2003 16:50:47 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: stack overflow
Message-ID: <20030912165047.Z18851@schatzie.adilger.int>
Mail-Followup-To: Breno <brenosp@brasilsec.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br>; from brenosp@brasilsec.com.br on Fri, Sep 12, 2003 at 06:53:58PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 12, 2003  18:53 +0100, Breno wrote:
> Hi ... this is my idea to check a stack overflow. What do you think ?
> 
> #define STACK_LIMIT (1024*8192)/PAGE_SIZE
> 
> int check_stack_overflow(struct task_struct *tsk)
> {
> 
>     unsigned long stack_size,stack_addr,stack_ptr;
>     int i;
> 
>          if(tsk->mm != NULL)
>          {
>                   stack_addr = tsk->mm->start_stack;
> 
>                   stack_ptr = tsk->thread.esp;
> 
>                   for(i=0; i < stack_ptr; i++)
>                   stack_addr++;
> 
>                   stack_size = (stack_addr - stack_ptr)/PAGE_SIZE;
> 
>                   if(stack_size > ( STACK_LIMIT - 1))

Well, with the exception of the fact that STACK_LIMIT is 8MB, and kernel
stacks are only 8kB (on i386)...

Also, see "do_IRQ()" (i386) for CONFIG_DEBUG_STACKOVERFLOW to see this already.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

