Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWAWVeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWAWVeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWAWVeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:34:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:23217 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964959AbWAWVeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:34:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Jan 2006 22:33:26 +0100
To: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D54BA6.nailC6M2150CO@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
In-Reply-To: <1138048255.21481.15.camel@mindpipe>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

> > In our case, the kernel did accept the call to mlockall(MLC_FUTURE), but later 
> > ignores this contract. This bug should be fixed.
>
> Joerg,
>
> You will be happy to know that in future Linux distros, cdrecord will
> not require setuid to mlock() and get SCHED_FIFO - both are now
> controlled by rlimits, so if the distro ships with a sane PAM/group
> configuration, all you will need to do is add cdrecord users to the
> "realtime" or "cdrecord" or "audio" group.
>
> This will take a while to make it into distros as it requires changes to
> PAM and glibc in addition to the kernel.

Well, on Solaris running cdrecord root-less is possible since 2 years.

What you do is to add a line

joerg::::profiles=CD RW

to /etc/user_attr

and a line:

CD RW:solaris:cmd:::/opt/schily/bin/cdrecord: privs=file_dac_read,sys_devices,proc_lock_memory,proc_priocntl,net_privaddr

to /etc/security/exec_attr

or to just a line

All:solaris:cmd:::/opt/schily/bin/cdrecord: privs=file_dac_read,sys_devices,proc_lock_memory,proc_priocntl,net_privaddr

to /etc/security/exec_attr

the command then is executed via /usr/vin/pfexec and gets the listed fine 
grained privileges in addition to the basic privileges.

We plan to break sys_devices into more fine grained privs that
include several levels of SCSI rights in the near future.

If Linux manages to do something similar, I would be happy.
It is obvious that this is someting that could only be used if there
is not only kernel code to support fine grained privs but there is a need
for a user space infrastructure that allows to use a seamless integration.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
