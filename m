Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131891AbQJ2Qol>; Sun, 29 Oct 2000 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131892AbQJ2Qoc>; Sun, 29 Oct 2000 11:44:32 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:21232
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131891AbQJ2QoS>; Sun, 29 Oct 2000 11:44:18 -0500
From: Jesse Pollard <pollard@cats-chateau.net>
Reply-To: pollard@cats-chateau.net
To: Stephen Harris <sweh@spuddy.mew.co.uk>,
        vonbrand@sleipnir.valparaiso.cl (Horst von Brand)
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
Date: Sun, 29 Oct 2000 10:35:27 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200010290920.JAA03918@spuddy.mew.co.uk>
In-Reply-To: <200010290920.JAA03918@spuddy.mew.co.uk>
MIME-Version: 1.0
Message-Id: <00102910423100.15754@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2000, Stephen Harris wrote:
>Horst von Brand wrote:
>
>> > > If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
>> > > kernel 2.2.x), within a few minutes you will find your entire machine
>> > > grinds to a halt.  For example, nobody can log in.
>> 
>> Great! Yet another way in which root can get the rope to shoot herself in
>> the foot. Anything _really_ new?
>
>OK, let's go a step further - what if syslog dies or breaks in some way
>shape or form so that the syslog() function blocks...?
>
>My worry is the one that was originally raised but ignored:  syslog() should
>not BLOCK regardless of whether it's local or remote.  syslog is not a
>reliable mechanism and many programs have been written assuming they can
>fire off syslog() calls without worry.

It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a
few seconds (depending on the log rate...).

I do believe that restarting syslog should be possible... Perhaps syslog
should be started by inetd at the very beginning. Then it could be restarted
after an exit/abort.

This can STILL fail if the syslog.conf is completely invalid - but then the
system SHOULD be stopped pending the investigation of why the file has been
corrupted, or syslogd falls back on a default configuration (record everything
in the syslog file).
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@cats-chateau.net

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
