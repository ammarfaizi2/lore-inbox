Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129365AbQJ3ORi>; Mon, 30 Oct 2000 09:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbQJ3ORT>; Mon, 30 Oct 2000 09:17:19 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:39477 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129326AbQJ3ORM>; Mon, 30 Oct 2000 09:17:12 -0500
Date: Mon, 30 Oct 2000 08:17:08 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200010301417.IAA224937@tomcat.admin.navo.hpc.mil>
To: sweh@spuddy.mew.co.uk, pollard@cats-chateau.net
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <200010291718.RAA19325@spuddy.mew.co.uk>
Cc: vonbrand@sleipnir.valparaiso.cl, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Harris <sweh@spuddy.mew.co.uk>:
> > It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a
> 
> Huh?  "SHOULD"?   Why?  If syslog dies for any reason (bug, DOS, hack,
> admin stupidity) then I sure don't want the system freezing up.

Should because this is the only audit logging facility presently available
to Linux.

> ( heh...  at work on Solaris I monitor 300+ systems, and it's not unusual
> to find 1 box a week with syslog not running for some reason or another.
> I can't decide whether it's admin stupidity or bugs in Solaris syslog - of
> which there are many :-(( )

On these boxes you should be running the audit log. Which has the property
of shutting the system down when it is aborted...

> syslog is not meant to be a secure audit system.  Messages can be
> legitimately dropped.   Applications have been coded assuming that they
> will not be frozen in syslog().  Linux should not be different in this
> respect.   Hmm... it might be nice to be this a system tunable parameter
> but I'm not sure the best way of doing that (glibc maybe?)

The best way would be to have a true audit daemon that has the property of
hanging/shutdown of the system. I would prefer a shutdown to single user
mode than a hang. That way I would get a chance to examine the log/restart
the daemon and examine the log. Even better would be a way to
suspend/checkpoint all processing, switch to a "audit emergency" mode with
no network activity allowed, and then examine things. It would provide an
option to clean the system and reboot, or restart the audit daemon and
resume multiuser mode (resuming all suspended/checkpointed processes).

Once there is an audit daemon then the security messages/alerts, and only
those messages, would be sent to it.

That way syslogd is available for non-security related events, and these
could be dropped when necessary.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
