Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDEUIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDEUIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWDEUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:08:52 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:9867 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751163AbWDEUIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:08:51 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604052004.k35K4u56010157@wildsau.enemy.org>
Subject: Re: Q on audit, audit-syscall
In-Reply-To: <296FAFD9-3D3E-421C-A474-1998BCB8F718@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Date: Wed, 5 Apr 2006 22:04:55 +0200 (MET DST)
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 5, 2006, at 09:50:17, Herbert Rosmanith wrote:
> >> On Apr 5, 2006, at 08:06:30, Herbert Rosmanith wrote:
> >>> as I said, "ptrace" is not an option.
> >>
> >> Why not, exactly?  (No, we don't know why).
> >
> > according to the man-page:
> >
> > RETURN VALUES
> >      EPERM   The specified process [...] is already being traced.
> >
> > this makes it unusable for me.
> 
> Please stop being unclear and describe _exactly_ what you want to do;  
                                         ^^^^^^^^^

Check my initial email, you'll see that I've been pretty _clear_ and
I've _exactly_ described what I am looking for: for description of
interfaces and software.  I cannot find good (if any) documentation on
this (see below), neither via google, nor by examining the
kernel-sources.

You see, I am asking for documentation. I am not asking "please solve my
problem."

Or is the LKML the wrong place to ask this kind of question?

okay then:

(1) CONFIG_AUDIT and CONFIG_AUDITSYSCALL: how do I use that from
    userspace? is it possible at all (1.1) to use this from userspace or
    (1.2) is this a "kernel-only" infrastructure provided for other
    kernel-modules only (such as e.g. LSM?). is there a description
    of this interface and how and where to use it? I cannot find it.
    clear enough?

(2) in linux/Documentation/devices.txt I've found an "audit device":

        103 block       Audit device
                          0 = /dev/audit        Audit device

    which software implements this device? I see no block-device
    registration in linux/kernel/audit.c nor in linux/kernel/auditsc.c.
    Booting a kernel with CONFIG_AUDIT* enabled does not show this
    device in /proc/devices.

    so, what the deal with this block device? clear enough?


(3) audit-1.1.5/lib is using "socket(PF_NETLINK,SOCK_RAW,NETLINK_AUDIT)"
    is this the way to communicate with the audit-system enabled by
    CONFIG_AUDIT/_AUDITSYSCALL? or is this something different.
    (thanks to auto-tools, compilation of audit-1.1.5 fails, so unfortunately
    I could not watch it running until now. God, I hate automake!)

> otherwise it's impossible to help you.  You want to trace and  
> intercept syscalls, no?

> It implicitly doesn't make any sense to try to trace and intercept syscalls
> from one process in more than one other.

I'm pretty sure I can find a quote from the fortune program saying
that "if something does not make sense for you, that doesnt mean that it wont
make sense for someone else". In fact, it makes sense for me.
  
> >> ptrace is _the_ Linux  mechanism to trace and intercept syscalls.   
> >> There is no other way.
> > "there is no other way": [1,2,3,4]
> >
> > [1] http://www.uniforum.chi.il.us/slides/HardeningLinux/LAuS- 
> > Design.pdf
> > [2] http://www.usenix.org/publications/library/proceedings/als01/ 
> > full_papers/edwards/edwards.pdf
> > [3] http://www.citi.umich.edu/u/provos/papers/systrace.pdf
> > [4] http://www.nsa.gov/selinux/papers/freenix01.pdf
> 
> It looks like you solved your own problem, then!

obviously not, because then I would not be asking question on LKML.
Of course I have read these papers before, but I am not 100% satisfied.

>  Feel free to use  any one of those.  The only commonly-available
> mainline mechanism to  _trace_ and _intercept_ syscalls is ptrace.  

with the limitation of ptrace, -EPERM -- see above.

> If you happen to be  looking for how to implement extra process
> security checks, might I suggest looking at Linux Security Modules?  On
> the other hand, I  think LSMs may never even see some requests if they
> fail access- restrictions before calling into the LSM.  I believe
> there's  documentation on them in the linux/Documentation dir of your
                                        ^^^^^^^^^^^^^^^^^^^

hm, yes, maybe, on the other hand:

/usr/src/linux/Documentation$ grep -i audit *
devices.txt:103 block   Audit device
devices.txt:              0 = /dev/audit        Audit device
/usr/src/linux/Documentation$ find -type d | grep -i audit
/usr/src/linux/Documentation$ 

that's not much. a textual search through linux/Documentation shows hits
in RCU/listRCU.txt mostly, which doesnt seem to deal with auditing. In my
experience, linux/Documentation is not a full documentation.
I wonder if IBM and SuSE/Novell are right when they write in~\ref{1}:

\begin{quote}
The vanilla 2.6 Linux kernel does not provide a mechanism to
trace syscalls in the desired way, nor does it contain the
capability to to track process and generate an audit trail.
\end{quote}

But on the other hand, we see kernel-options like CONFIG_AUDIT,
CONFIG_AUDITSYSCALL, CONFIG_SECURITY etc. etc. So, how can IBM & SuSE
argue this way? The attempt to review their statement is one
reason for my email to LKML.

> copies  of the linux sources.

regards,
h.rosmanith

[1] http://www.uniforum.chi.il.us/slides/HardeningLinux/LAuS-Design.pdf
