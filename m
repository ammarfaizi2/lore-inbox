Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIJTwM>; Mon, 10 Sep 2001 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271655AbRIJTwC>; Mon, 10 Sep 2001 15:52:02 -0400
Received: from d117.dhcp212-140.cybercable.fr ([212.198.140.117]:5979 "HELO
	pridamix.molteni.net") by vger.kernel.org with SMTP
	id <S271627AbRIJTvu>; Mon, 10 Sep 2001 15:51:50 -0400
Message-ID: <3B9D19EA.7F3AE823@molteni.net>
Date: Mon, 10 Sep 2001 21:52:10 +0200
From: Olivier Molteni <olivier@molteni.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Erik DeBill <erik@www.creditminders.com>, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: nfs client oops, all 2.4 kernels
In-Reply-To: <20010910100202.A14106@www.creditminders.com> <20010910173420.11d2fa71.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

> On Mon, 10 Sep 2001 10:02:02 -0500 Erik DeBill <erik@www.creditminders.com>
> wrote:
>
> > I've been running into a repeatable oops in the NFS client code,
> > apparently related to file locking.
>

>
> in linux/fs/locks.c I would say it fails either because thisfl_p is NULL or
> *thisfl_p is NULL. Try securing it via:
>
> static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
> {
>         struct file_lock *fl;
>
>         if (thisfl_p == NULL || *thisfl_p == NULL)
>                 return;
>
>         fl = *thisfl_p;
>
>         *thisfl_p = fl->fl_next;
>         fl->fl_next = NULL;
>
> ...
> }
>
> This is for sure not the cure, but may help your setup.

Hi, see my post and related answers [ Oops NFS Locking in 2.4.x] I have the same
Problem.
Returning on *thisfl_p == NULL don't fix the trouble... Kernel no more Oops, but
process stay in wait state on IO (D).

See the answers from Trond Myklebust, I think he is right...

Regards,
Olivier.


