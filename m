Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVDXMff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVDXMff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVDXMfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 08:35:33 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:15311 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S262315AbVDXMfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 08:35:24 -0400
Date: Sun, 24 Apr 2005 13:35:01 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hotplug CPU and setaffinity?
Message-ID: <20050424123501.GB7111@gallifrey>
References: <20050423173514.GA7111@gallifrey> <20050423182227.GE18688@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423182227.GE18688@otto>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.10-5-k7-smp (i686)
X-Uptime: 13:31:51 up 1 day,  1:28,  1 user,  load average: 0.34, 0.24, 0.14
User-Agent: Mutt/1.5.6+20040907i
X-Originating-Heisenberg-IP: [212.23.14.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Lynch (ntl@pobox.com) wrote:

Hi Nathan,
  Thanks for the reply.

> Dr. David Alan Gilbert wrote:
> >
> >   I got to wondering how Hotplug CPU and sched_setaffinity interact;
> > if I have a process that has its affinity set to one CPU and some
> > nasty person comes along and unplugs it what happens to that process-
> > does it get scheduled onto another cpu, just not get any time or
> > die ?
> 
> The affinity of the process is reset to the default and it is migrated
> to another cpu, for better or worse.  The kernel assumes the admin
> know what he/she is doing.

Yeh that's ok - is there anything that would hotplug a cpu
automatically; say on receiving some MCEs ; and thus not
give the admin a look in.

> > In particular I was thinking of the cases where a thread has a
> >  functional reason for remaining on one particular CPU (e.g. if you
> > had calibrated for some feature of that CPU say its time stamp
> > counter skew/speed). Another case would be a set of threads which
> > had set their affinity to the same CPU and then made memory
> > consistency or locking assumptions that wouldn't be valid
> > if they got rescheduled onto different CPUs.
> 
> Yeah.  But I don't think this is an issue to be solved in the kernel.
> Applications that are this sensitive to cpu hotplugging need to
> arrange to be notified before the hotplug occurs, which I think would
> be best done with dbus or some other IPC.

Agreed; since the kernel will reset it to the default affinity then
this involvement must happen before the hotplug, if the kernel were
to stop scheduling them anywhere then this is something that could
be fixed up externally to the app by a hotplug type of thing after
the hot un-plug happened. 

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
