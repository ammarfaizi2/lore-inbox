Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJJOie>; Wed, 10 Oct 2001 10:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJJOiP>; Wed, 10 Oct 2001 10:38:15 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:7693 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S275734AbRJJOiN>; Wed, 10 Oct 2001 10:38:13 -0400
Date: Wed, 10 Oct 2001 09:38:16 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110101438.JAA35345@tomcat.admin.navo.hpc.mil>
To: balbir.singh@wipro.com, Balbir Singh <balbir.singh@wipro.com>
Subject: Re: is reparent_to_init a good thing to do?
CC: landley@trommello.org, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"BALBIR SINGH" <balbir.singh@wipro.com>:
> Balbir Singh wrote:
> 
> > Rob Landley wrote:
> >
> >> Or long lived kernel threads from short lived login sessions.
> >>
> >> You have a headless gateway box for your local subnet, administered 
> >> via ssh from a machine on the local subnet.  So you SSH into the box 
> >> through eth1, ifconfig eth0 down back up again.  If eth0 is an 
> >> rtl8039too, this fires off a kernel thread (which, before 
> >> reparent_to_init, was parented to your ssh login session).
> >>
> >> Now exit the login session.  SSH does not exit until all the child 
> >> processes exit, so it just hangs there until you kill it from another 
> >> console window...
> >>
> >> Rob
> >>
> > The question one can ask is what should a thread do then?
> > Should reparent_to_init() send a SIGCHLD to the process/task
> > that was parent before init became the parent? this should be easy
> > to do, but will this fix the problem? I think so.
> >
> > I can patch up something soon, if somebody is willing to test it.
> 
> 
> Ooh! sorry this is a wrong approach to send SIGCHLD to the previous parent.
> AFAIK, all shells send their children SIGHUP when the shell exits, but SSH
> may have some special security consideration in waiting for all children to
> exit, does anyone know?

Not exactly - sshd will not terminate a connection until all forwarded socket
connections are terminated. If processes are running in the background, then
they will remain after sshd terminates. Foreground processes will terminate as
specified by the shell.

If the sshd TCP socket remains open after the network interface is shutdown,
then you are into the TCP timeout.. Not a ssh logout.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
