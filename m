Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSENSyn>; Tue, 14 May 2002 14:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315994AbSENSym>; Tue, 14 May 2002 14:54:42 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:65394 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315993AbSENSyl>; Tue, 14 May 2002 14:54:41 -0400
Date: Tue, 14 May 2002 13:54:40 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205141854.NAA59350@tomcat.admin.navo.hpc.mil>
To: mark@mark.mielke.cc, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Cc: elladan@eskimo.com, Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Don't put /var/log on the same file system as /home, and don't grant
> access to /var/log to any normal userid.
> 
> This isn't 'new'.

Also not relevent. If you want to get picky, don't put root, /usr, /var
and /etc on the same filesystem. Make them all separate. Don't put
/tmp, /var/tmp, on the same filesystem either. Mount /usr read only.
mount / read only, mount all user writable filesystems nosetuid, nosetgid.

However, not all daemons run as root, but do log into /var/adm or /var/log.
If these fill up the log device without restraint, then your audit logs will
ALSO be affected (unless you have syslog send them to a different host).

Users don't have to have access to the filesystem to cause write activity
to it. The reserved space is just a small thing. It can't catch everything,
but the system CAN continue to function after the filesystem fills up.
Hopefully, long enough to record events and allow the administrator to
clean up. That is the ONLY security function it has.

> mark
> 
> 
> On Tue, May 14, 2002 at 12:53:47PM -0500, Jesse Pollard wrote:
> > If the root file system is ext2, it does become a security issue since
> > currently active logs will continue to record log entries until the
> > filesystem is absolutly filled. I should say, if the log device fills up,
> > since the log directory is usually /var/log, or /var/adm. Some logs show
> > up in etc, but that really depends on the configuration. It IS usefull if the
> > filesystem is "full" due to attacks - daemons tend to terminate themselves,
> > and their log entry indicates what the problem was. If it is an attack, then
> > it's a security issue.
> > 
> > The only reason it helps fragmentation (subject to actual implementor
> > statements) is that the filesystem code will use every scavanged block
> > possible under saturation. When the filesystem gets cleand up later,
> > these excessively fragmented files will remain, and continue to cause
> > access delays.
> > 
> > Naturally, deleting (or backup/restore) the file(s) cleans up the fragmentation.
> > 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
