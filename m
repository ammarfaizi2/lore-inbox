Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319067AbSHSUa6>; Mon, 19 Aug 2002 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSHSUa6>; Mon, 19 Aug 2002 16:30:58 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24448 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319067AbSHSUa4>;
	Mon, 19 Aug 2002 16:30:56 -0400
Date: Mon, 20 Aug 2001 20:06:49 +0000
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Kasper Dupont <kasperd@daimi.au.dk>, "David S. Miller" <davem@redhat.com>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
Message-ID: <20010820200648.B111@toy.ucw.cz>
References: <3D4FD736.DA443B4B@daimi.au.dk> <20020806.065652.12285252.davem@redhat.com> <3D4FDA23.90CAB62F@daimi.au.dk> <20020806.070535.24871584.davem@redhat.com> <3D4FDCDB.744EE7C9@daimi.au.dk> <3D4FDEF3.8070207@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D4FDEF3.8070207@colorfullife.com>; from manfred@colorfullife.com on Tue, Aug 06, 2002 at 04:36:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I just get another idea, that might be easier to get right. If
> >the only problem is one process changing the mm while another
> >process is doing a copy_to_user, we should be able to fix it by
> >placing a readlock on the mm while the copy_to_user is in progress.
> >  
> >
> Yes, that would work. copy_to_user is never called with the mmap 
> semaphore locked, i.e.
> 
> #define copy_to_user(...) >         down(&current->mm->mmap_sem); >         check_wp_bit(); >         real_copy_to_user(); >         up(&current->mm->mmap_sem)
> 
> verify_area would just check that the pointer is below TASK_SIZE, and 
> the wp bit is checked within copy_to_user().
> 
> But how many 80386 Linux systems that run the 2.4 kernel exist?

Many embedded boxes, I beieve, have modern 386 CPUs.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

