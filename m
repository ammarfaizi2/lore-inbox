Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUKWSD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUKWSD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUKWSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:03:20 -0500
Received: from pop.gmx.net ([213.165.64.20]:58859 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261384AbUKWRz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:55:27 -0500
Date: Tue, 23 Nov 2004 18:55:22 +0100 (MET)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: mtk-lkml@gmx.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, hugh@veritas.com
MIME-Version: 1.0
References: <20041123090449.1672494f.akpm@osdl.org>
Subject: Re: [PATCH 2.6.10-rc2] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is broken
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <14793.1101232522@www8.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Michael Kerrisk" <mtk-lkml@gmx.net> wrote:
> >
> > The accounting of shmctl() SHM_LOCK memory locks against the
> >  user structure is broken.  The problem is that the check
> >  of the size of the to-be-locked region is based on 
> >  the size of the segment as specified when it was created
> >  by shmget() (this size is *not* rounded up to a page 
> >  boundary).  This size is then rounded down (>> PAGE_SHIFT)
> >  to PAGE_SIZE during the check in 
> >  mm/mlock.c::user_shm_lock().
> 
> True.  We should make the same change to user_shm_unlock(), and we may as
> well tweak the excessive spinlock coverage in there too.

Thanks for the confirmation Andrew.

[...]

> and then ask Hugh and Manfred to double-check.
> 
> Looking at the callers, we do:
> 
> 	user_shm_lock(inode->i_size, ...);
> 
> then, later:
> 
> 	user_shm_unlock(inode->i_size, ...);
> 
> which does make one wonder "what happens if the file got larger while it
> was locked"?

Not sure if I'm missing your point, but, just considering it from 
the point of view of System V shared memory, the segment can't 
change in size after it has been created.

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
