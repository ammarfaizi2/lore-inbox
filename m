Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRBTKFe>; Tue, 20 Feb 2001 05:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRBTKFY>; Tue, 20 Feb 2001 05:05:24 -0500
Received: from [195.63.194.11] ([195.63.194.11]:57609 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129443AbRBTKFS>; Tue, 20 Feb 2001 05:05:18 -0500
Message-ID: <3A924CA1.10C913E7@evision-ventures.com>
Date: Tue, 20 Feb 2001 11:53:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
In-Reply-To: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu> <20010219230106.A23699@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [BERECZ Szabolcs]
> > Here is a new syscall. With this you can change the owner of a running
> > procces.
> 
> > +       if (current->euid)
> > +               return -EPERM;
> 
> Use capable().
> 
> > +       p = find_task_by_pid(pid);
> > +       p->fsuid = p->euid = p->suid = p->uid = uid;
> 
> Race -- you need to make sure the task_struct doesn't disappear out
> from under you.
> 
> Anyway, why not use the interface 'chown uid /proc/pid'?  No new
> syscall, no arch-dependent part, no user-space tool, etc.

Becouse of exactly the same race condition as above maybe?
