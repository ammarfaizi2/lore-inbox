Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRDJRFH>; Tue, 10 Apr 2001 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRDJREr>; Tue, 10 Apr 2001 13:04:47 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:56886 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129051AbRDJREh>; Tue, 10 Apr 2001 13:04:37 -0400
Date: Tue, 10 Apr 2001 12:04:34 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104101704.MAA02175@tomcat.admin.navo.hpc.mil>
To: kees@schoen.nl, linux-kernel@vger.kernel.org
Subject: Re: [RFC] exec_via_sudo
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees <kees@schoen.nl>:
> 
> Hi
> 
> Unix/Linux have a lot of daemons that have to run as root because they
> need to acces some specific data or run special programs. They are
> vulnerable as we learn.
> Is there any way to have something like an exec call that is
> subject to a sudo like permission system? That would run the daemons
> as a normal user but allow only for specific functions i.e. NOT A SHELL.
> comments?

Simple answer: no.

1. The exec system call (or library) has no way to communicate with the
   user for getting a password.
2. A user is not always present when the exec is done (cron/at/batch...).
   there is no terminal like device available.
3. In the cases where terminals are available, which terminal? The program
   doing the exec may have been detatched (background/nohup...).
4. In the cases where the user is connected via a window - there is no
   known way to provide that communication. (the DISPLAY environment might
   not be present...)

More complex answer: in some cases.

If the application doing the exec is programmed to, then it may open
an input type and actually use "sudo" to start another program. It will
be up to the implementation of "sudo" to accept the communication path
and perform suitable validation.

The primary weakness in this is that the communication path may not be
trusted by sudo... terminals type devices are easier to validate than
others (windowing systems for instance).

The problem with cron/at/batch cannot be solved since the user context
for any authentication path is missing. It would be necessary to authenticate
the communication path, before authenticating to sudo...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
