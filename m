Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKKCUm>; Fri, 10 Nov 2000 21:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKKCUW>; Fri, 10 Nov 2000 21:20:22 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29957 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129302AbQKKCUQ>; Fri, 10 Nov 2000 21:20:16 -0500
Date: Fri, 10 Nov 2000 20:16:18 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001110201618.B3285@vger.timpanogas.org>
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com> <3A0C76C0.CAC8B9D4@timpanogas.org> <20001111024440.E29352@bacchus.dhis.org> <3A0CA4F5.4715FE49@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A0CA4F5.4715FE49@transmeta.com>; from hpa@transmeta.com on Fri, Nov 10, 2000 at 05:46:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 05:46:29PM -0800, H. Peter Anvin wrote:
> Ralf Baechle wrote:
> > 
> > Jeff,
> > 
> > On Fri, Nov 10, 2000 at 03:29:20PM -0700, Jeff V. Merkey wrote:
> > 
> > > Well, here's what the sendmail folks **REAL** opinion of Linux is and
> > > the way load average is calculated (senders name removed)
> > >
> > > [... sendmail person ...]
> > >
> > >  Ok, here's my blunt answer: Linux sucks.  Why does it have a load
> > > > average of 10 if there are two processes running? Let's check the
> > > > man page:
> > > >
> > > >             and the three load averages for the system.  The load
> > > >             averages  are  the average number of process ready to
> > > >             run during the last 1, 5 and 15 minutes.   This  line
> > > >             is  just  like  the  output of uptime(1).
> > > >
> > > > So: Linux load average on these systems is broken.
> > 
> > Or the documentation is b0rken?  This is how the load figure is actually
> > calculated:
> > 
> > /*
> >  * Nr of active tasks - counted in fixed-point numbers
> >  */
> > static unsigned long count_active_tasks(void)
> > {
> >         struct task_struct *p;
> >         unsigned long nr = 0;
> > 
> >         read_lock(&tasklist_lock);
> >         for_each_task(p) {
> >                 if ((p->state == TASK_RUNNING ||
> >                      (p->state & TASK_UNINTERRUPTIBLE)))
> >                         nr += FIXED_1;
> >         }
> >         read_unlock(&tasklist_lock);
> >         return nr;
> > }
> > 
> 
> Yes, the documentation is broken.  Linus did in fact implement this
> change because it made most daemons behave significantly better.  This
> ought to include sendmail; it's just that on modern systems the numbers
> get a little too high for it.


So everyone should up their defaults for most commercial Linux versions.  

Jeff

> 
> 	-hpa
> 
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
