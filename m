Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284537AbRLMSTk>; Thu, 13 Dec 2001 13:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284518AbRLMSTU>; Thu, 13 Dec 2001 13:19:20 -0500
Received: from cti06.citenet.net ([206.123.38.70]:54793 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S282967AbRLMSTO>; Thu, 13 Dec 2001 13:19:14 -0500
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Thu, 13 Dec 2001 11:02:15 -0500
To: linux-kernel@vger.kernel.org
Subject: re: User-manageable sub-ids proposals
X-mailer: tlmpmail 0.1
Message-ID: <20011213110215.bfcc4bfa0b14@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001 11:36:16 -0500, Romano Giannetti wrote
> Good morning to everyone.
>
> I was thinking about the idea of sub-ids to enable users to run "untrusted"
> binary or "dangerous" one without risk for their files/privacy.

I have another solution, which is almost completed. I am combining
two project. One is the vserver project (see the url in my signature) and the
other is the AclFS component of the virtualfs project
(http://www.solucorp.qc.ca/virtualfs).

Using the chcontext utility from the vserver project, you can isolate a process
from the rest of the system, including the other user processes

For example, as a normal user, you can do

	xterm &
	/usr/sbin/chcontext /bin/sh
	ps ax
	killall xterm

and you only see your new shell, the ps command and init. The killall fails
finding no xterm to kill.

Another part of the vserver project is the capability ceiling, which is a way to
turn off some capabilities for a process and its children, even setuid child.

I was thinking about introducing a new capability CAP_OPEN. This capability
would prevent any open system call from succeeding. Wow. Now that's secure :-)

The acslfs daemon works using a unix domain socket. Using a preload object
the client does various system call request to aclfsd, including open, socket
and so on. If aclfsd grant the access, it opens the file and pass back the
file handle using the socket. So the client does not need to open the file
itself.

So the CAP_OPEN is there to force the client to use aclfsd. Even if using aclfsd
is transparent to normal clients, some client might do a direct call to the OS.
All those calls would fail.

Not also that aclfsd does not need any privilege. A normal user may start
it with its own configurations (access privileges).

Ultimatly, one goal of this would be to run your favorite browser in a security
box and allow fine grain access to your own file. Then one could do the so
cool thing windows user do all the time: They visit a site, select a plugin
and run it. Unlike windows, you would not get all the virus though :-)

Anyway, the vserver and virtual projects are used for different purpose today
but could be combined to achieve this kind of result.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
