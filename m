Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270702AbTGUUye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTGUUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:54:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22253 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270702AbTGUUyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:54:32 -0400
Date: Mon, 21 Jul 2003 18:05:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
In-Reply-To: <20030721212453.4139a217.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307211800450.2317@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
 <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
 <20030718112758.1da7ab03.skraw@ithnet.com> <20030721162033.GA4677@x30.linuxsymposium.org>
 <20030721212453.4139a217.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just FYI, the 8way box is running for three days with LOTS of IO and
memory pressure:

hostname:  dev8-005 (dev8-005.pdx.osdl.net) running linux

bash-2.05a$ uptime
  2:03pm  up 3 days,  3:14,  2 users,  load average: 82.48, 91.67, 94.29
bash-2.05a$ vmstat 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 1 77  2   3436   8232  77288 885880   0   0     3    12   13    16   4
9   8
 0 78  3   3436   7300  77448 886596   0   0   108 12184  619   448   0
9  90
 0 78  2   3436  11472  77760 880692   0   0   400 22922  836  2497   2
33  65
 0 77  2   3428   7292  78176 884640   6   0   414  7858  761   511   0
11  88
 0 77  3   3428   7392  78348 884776   0   0   238  9942  687   449   0
9  91
....


Interactivity under this extreme circumstances is impressive. Very good.

Great work Andrea, Mason and Jens. Thanks.


On Mon, 21 Jul 2003, Stephan von Krawczynski wrote:

> On Mon, 21 Jul 2003 12:20:33 -0400
> Andrea Arcangeli <andrea@suse.de> wrote:
>
> > > I managed to freeze the pre7 box within these few hours. There was no nfs
> > > involved, only tar-to-tape.
> > > I switched back to 2.4.21 to see if it is still stable.
> > > Is there a possibility that the i/o-scheduler has another flaw somewhere
> > > (just like during mount previously) ...
> >
> > is it a scsi tape?
>
> yes.
>
> > Is the tape always involved?
>
> No, I experience both freeze during nfs-only action and freeze during
> tar-to-scsi-tape.
> My feelings are that the freeze does (at least in the nfs case) not happen
> during high load but rather when load seems relatively light. Handwaving one
> could say it looks rather like an I/O sched starvation issue than breakdown
> during high load. Similar to the last issue.
>
> > there are st.c updates
> > between 2.4.21 to 22pre7. you can try to back them out.
>
> Hm, which?
>
> > [...]
> > You should also provide a SYSRQ+P/T of the hang or we can't debug it at
> > all.
>
> Well, I really tried hard to produce something, but failed so far, if I had
> more time I would try a serial console hoping that it survives long enough to
> show at least _something_.
> The only thing I ever could see was the BUG in page-alloc thing from the
> beginning of this thread.
>
> Regards,
> Stephan
>
