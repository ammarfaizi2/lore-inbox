Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318777AbSHGSMQ>; Wed, 7 Aug 2002 14:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHGSMQ>; Wed, 7 Aug 2002 14:12:16 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9552 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S318777AbSHGSMP>; Wed, 7 Aug 2002 14:12:15 -0400
Date: Wed, 7 Aug 2002 13:15:36 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208071815.NAA01988@tomcat.admin.navo.hpc.mil>
To: Gregoryg@ParadigmGeo.com,
       "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
> >     > In what I see, a simple test doesn't work in the expected way,
> >     > which is one client writes to a file opened with O_SYNC on a
> >     > drive mounted with sync option and the other client cannot
> >     > immediatelly see the written data.  Are you saying that this is
> >     > the way it should be?
> >
> >Yes. That is all the NFS protocol allows you to do.
> 
> Well, this is the way it's been working on all UN*X platforms I know. In
> fact, we came across this problem with NFS clients being unable to
> synchronize on Linux. 
> If this is a "feature", it makes it impossible to read/write files via NFS
> because of the risk of corruption - or am I missing something here?
> 
> Also, integrating Linux into heterogeneous networks becomes impossible
> (though, it doesn't work in Linux only network as well).

This in neither a "feature" nor an error. It is the way it was designed
to work. There are VERY few distributed file systems, and NFS is NOT
one of them.

It is intended that a file server support one writer/reader to one client
for a file.

A server may support multiple clients, multiple files, BUT the same file
MUST NOT be used by multiple clients at the same time.

If you want examples of an attempt to support this, look at the gyrations
necessary for mail handling via NFS.

Only file level locking is permitted. You can only open the file IF you get
the lock. And be sure to close the file before releasing the lock. Make sure
that all accesses to the file use the SAME lock technique.

Integrating Linux is possible. You just have to follow the rules. I'm working
in a heterogeneous mix now - Solaris (file server, and one workstation), Linux
(several workstations), and SGI. It works. The hardest part was dropping
the NFS mail (couldn't agree on file locking for all systems/applications).

We are also migrating from an SGI based network (different net) to a Linux
net. A mixed environment does have some surprises (uid for mail, application
lock functions). Basic user access to data works fine though. We just don't
mix multiple client access to the same file, unless everybody is only reading
that file.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
