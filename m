Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSKMWSX>; Wed, 13 Nov 2002 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSKMWSW>; Wed, 13 Nov 2002 17:18:22 -0500
Received: from smtpout.mac.com ([204.179.120.88]:21184 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S262648AbSKMWSQ>;
	Wed, 13 Nov 2002 17:18:16 -0500
Message-ID: <3DD2D154.AB45F0CD@mac.com>
Date: Wed, 13 Nov 2002 23:25:24 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Michal Wronski <wrona@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
References: <Pine.LNX.4.44.0211131555530.9870-100000@Leon>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Wronski schrieb:
> 
> > The interface boils down to 7 new syscalls (for now just i386):
> > - sys_mq_open
> > - sys_mq_unlink
> > - sys_mq_timedsend
> > - sys_mq_timedreceive
> > ...
> 
> Why add a new syscalls?? It's better to do this via ioctl's
> 

Hmh, there was some discussion concluding that ioctl is
"bad taste from hell". Syscalls are considered cleaner
and less error prone.

> I suggest doing this independently to SysV IPC

I just reused the message storage code.

> 
> > userspace lib and test progs are on
> > http://homepage.mac.com/pwaechtler/linux/mqueue/
> 
> "We're sorry, but we can't find the HomePage you've requested."
> 

Yes, I'm also sorry ;-) 

a wget http://homepage.mac.com/pwaechtler/linux/mqueue.tgz
should work. (i'm not comfortable with my own homepage, shame on me :)

> > +#ifndef _LINUX_MQUEUE_H
> > +#define _LINUX_MQUEUE_H
> > +
> > +#define MQ_MAXMSG 40 /* max number of messages in each queue */
> > +#define MQ_MAXSYSSIZE 1048576 /* max size that all m.q. can have
> > together
> > */
> > +#define MQ_PRIO_MAX 10000 /* max priority */
> 
> I see that you've read our sources....
> 

Yes, indeed. I also evaluated your implementation and the one from Jakub.
First I thought: hey cool, they use binary trees for the messages - but
no: you use trees to keep track which process uses which queue.
Your code carries a lot of baggage.. the VFS can do all this for you/me

> We (K. Benedyczak with me) are currently working on new implementation of
> mqueues. It's very similar to yours (filesystem, without new syscalls) and
> it's almost done. Maybe we should collaborate??
> 

Yes, why not. But to be honest my implementation is already "full featured".
Perhaps one could handle the message lists more effectively .. 

I'm currently trying to do some performance measurements with NPTL and the
userspace implementation I have.
