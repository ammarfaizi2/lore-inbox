Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQKKBpV>; Fri, 10 Nov 2000 20:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbQKKBpM>; Fri, 10 Nov 2000 20:45:12 -0500
Received: from u-172.karlsruhe.ipdial.viaginterkom.de ([62.180.19.172]:38405
	"EHLO u-172.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org
	with ESMTP id <S129501AbQKKBoy>; Fri, 10 Nov 2000 20:44:54 -0500
Date: Sat, 11 Nov 2000 02:44:40 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001111024440.E29352@bacchus.dhis.org>
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com> <3A0C76C0.CAC8B9D4@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A0C76C0.CAC8B9D4@timpanogas.org>; from jmerkey@timpanogas.org on Fri, Nov 10, 2000 at 03:29:20PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

On Fri, Nov 10, 2000 at 03:29:20PM -0700, Jeff V. Merkey wrote:

> Well, here's what the sendmail folks **REAL** opinion of Linux is and
> the way load average is calculated (senders name removed)
> 
> [... sendmail person ...]
> 
>  Ok, here's my blunt answer: Linux sucks.  Why does it have a load
> > average of 10 if there are two processes running? Let's check the
> > man page:
> > 
> >             and the three load averages for the system.  The load
> >             averages  are  the average number of process ready to
> >             run during the last 1, 5 and 15 minutes.   This  line
> >             is  just  like  the  output of uptime(1).
> > 
> > So: Linux load average on these systems is broken.

Or the documentation is b0rken?  This is how the load figure is actually
calculated:

/*
 * Nr of active tasks - counted in fixed-point numbers
 */
static unsigned long count_active_tasks(void)
{
        struct task_struct *p;
        unsigned long nr = 0;

        read_lock(&tasklist_lock);
        for_each_task(p) {
                if ((p->state == TASK_RUNNING ||
                     (p->state & TASK_UNINTERRUPTIBLE)))
                        nr += FIXED_1;
        }
        read_unlock(&tasklist_lock);
        return nr;
}

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
