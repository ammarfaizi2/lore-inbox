Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSENMac>; Tue, 14 May 2002 08:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSENMab>; Tue, 14 May 2002 08:30:31 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2834 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315198AbSENMab>; Tue, 14 May 2002 08:30:31 -0400
Date: Tue, 14 May 2002 09:30:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <3CE073FA.57DAC578@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0205140929230.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Andrew Morton wrote:

> > ===== fs/buffer.c 1.64 vs edited =====
> > --- 1.64/fs/buffer.c    Mon May 13 19:04:59 2002
> > +++ edited/fs/buffer.c  Mon May 13 19:16:57 2002
> > @@ -156,8 +156,10 @@
> >         get_bh(bh);
> >         add_wait_queue(&bh->b_wait, &wait);
> >         do {
> > +               atomic_inc(&nr_iowait_tasks);
> >                 run_task_queue(&tq_disk);
> >                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> > +               atomic_dec(&nr_iowait_tasks);
> >                 if (!buffer_locked(bh))
> >                         break;
> >                 schedule();
>
> Shouldn't the atomic_inc cover the schedule()?

DOH, indeed.  Placed in the wrong place ;/

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

