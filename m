Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269873AbUJNDPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269873AbUJNDPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269899AbUJNDPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:15:18 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:59090 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269873AbUJNDPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:15:07 -0400
Message-ID: <46561a7904101320151575843d@mail.gmail.com>
Date: Thu, 14 Oct 2004 08:45:06 +0530
From: suthambhara nagaraj <suthambhara@gmail.com>
Reply-To: suthambhara nagaraj <suthambhara@gmail.com>
To: nhorman@redhat.com
Subject: Re: kernel stack
Cc: main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>, gaurav.dhiman@ca.com
In-Reply-To: <46561a7904101220299d1604e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <46561a79041011231549ea310a@mail.gmail.com>
	 <416BBB55.6020509@redhat.com>
	 <46561a7904101220299d1604e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I went through the code of do_fork.
do_fork calls copy_process which in turn calls 
dup_task_struct .Here alloc_thread_info allocates the 
kernel stack for the process

Thanks all

Regards
Suthambhara


On Wed, 13 Oct 2004 08:59:14 +0530, suthambhara nagaraj
<suthambhara@gmail.com> wrote:
> Thanks Neil. I was an idiot to have overlooked  that.
> Thanks once again
> 
> Regards
> Suthambhara
> 
> 
> 
> 
> On Tue, 12 Oct 2004 07:09:09 -0400, Neil Horman <nhorman@redhat.com> wrote:
> >
> >
> > suthambhara nagaraj wrote:
> > > Hi all,
> > >
> > > I have not understood how the common kernel stack in the
> > > init_thread_union(2.6 ,init_task_union in case of 2.4) works for all
> > > the processes which run on the same processor. The scheduling is round
> > > robin and yet the things on the stack (saved during SAVE_ALL) have to
> > > be maintained after a switch without them getting erased. I am
> > > familiar with only the i386 arch implementation.
> > >
> > > Please help
> > >
> > There is no such thing as "the common kernel stack".  Each process
> > (represented by a task_struct in the kernel) has its own private data
> > space to be used as a kernel stack when that process traps into the
> > kernel.  You can see where this per task_struct stack space is reserved
> > in the definition of task_union.  init_[task|thread]_union just defines
> > the first task union in the system.  Because of the way unions are laid
> > out in memory, The kernel knows that when a process traps into kernel
> > space, it just needs to round the current task pointer to the nearest 8k
> > (prehaps 4k in 2.6) boundary, and thats the start of that processes
> > kernel stack.  Thats how the SAVE_ALL command avoids trampling registers.
> >
> > HTH
> > Neil
> > > regards,
> > > Suthambhara
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > --
> > /***************************************************
> >  *Neil Horman
> >  *Software Engineer
> >  *Red Hat, Inc.
> >  *nhorman@redhat.com
> >  *gpg keyid: 1024D / 0x92A74FA1
> >  *http://pgp.mit.edu
> >  ***************************************************/
> >
>
