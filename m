Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVBWDkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVBWDkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 22:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVBWDkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 22:40:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7910 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261412AbVBWDkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 22:40:09 -0500
Message-Id: <200502230105.j1N15e56005773@laptop11.inf.utfsm.cl>
To: Chris Friesen <cfriesen@nortel.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups 
In-reply-to: <421B9C86.8090800@nortel.com> 
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com> <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl> <421B9C86.8090800@nortel.com>
Comments: In-reply-to Chris Friesen <cfriesen@nortel.com>
   message dated "Tue, 22 Feb 2005 14:56:38 -0600."
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 22 Feb 2005 22:05:35 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> said:
> Horst von Brand wrote:
> > Anthony DiSante <theant@nodivisions.com> said:

> >>That's one of the things I asked a few messages ago.  Some people on
> >>the list were saying that it'd be "really hard" and would "require a
> >>lot of bookkeeping" to "fix" permanently-D-stated processes... which is
> >>completely different than "impossible."

> > Most people here have little clue. It can't be done.

> I realize it would be extremely difficult if not impossible to do in the 
> current linux architecture, but I find it hard to believe that it is 
> technically impossible if one were allowed to design the system from 
> scratch.

It is hard (if not impossible) to find out /what/ is broken (and how) and
fix it automatically. As you were told, D means the process is waiting for
some event. That event /might/ happen sometime (waiting for slow hardware)
or never (kernel programming error, hardware forgot the operation in
progress, ...).  So you might fake it out by making believe the event did
happen. What if was just delayed, and /does/ then happen with nobody
waiting?

Any such is just papering over the problems, and is /massive/ complexity
for no real gain.

> Maybe I'm on crack, but would it not be technically possible to have all 
> resource usage be tracked so that when a task tries to do something and 
> hangs, eventually it gets cleaned up?

Sure. But there is /no way/ to know if the task will ever do something
(Turing's undecibility sees to that, even with perfect hardware), so the
only chance is to wait and see if the task releases it by itself. If you
just want to axe the task, you'd have to know beforehand what it will do
(and do it for the task on killing it). But the /task/ couldn't do it, what
guarantees the cleanup can?

> We already handle cleaning up stuff for userspace (memory, file 
> descriptors, sockets, etc.).

On process end, i.e., when we know the stuff won't be used anymore. If the
program is stuck, kill it and go as before. If it doesn't go away cleanly,
something is /seriously/ wrong... and it is anybody's guess what.

>                              Why not enforce a design that says "all 
> entities taking a lock must specify a maximum hold time".

It is hard enough to program without such restrictions. This would
incidentally also mean that the kernel has to be hard real time,
always. The usual PC hardware just isn't up to that, for starters.

And what would you do if you have nested locks, and the outer one times
out? Must kill the inner one beforehand... more complexity still.

>                                                            After that 
> time expires, they are assumed to be hung, and all their resources 
> (which were being tracked by some system) get cleaned up.

> It would probably be complicated, slow, and generally not worth the 
> effort.  But it seems at least technically possible.

If the system takes all extant resources for managing said resources, it is
somewhat pointless...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
