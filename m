Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHHNoz>; Thu, 8 Aug 2002 09:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSHHNoy>; Thu, 8 Aug 2002 09:44:54 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:48467 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317541AbSHHNox>; Thu, 8 Aug 2002 09:44:53 -0400
Date: Thu, 8 Aug 2002 08:48:26 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208081348.IAA11830@tomcat.admin.navo.hpc.mil>
To: trond.myklebust@fys.uio.no, Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
Cc: "'Jesse Pollard'" <pollard@tomcat.admin.navo.hpc.mil>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> >>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:
> 
>      > When the writer closes the file, how do you make the readers
>      > see the latest changes (assuming that you always open/close
>      > files per transaction type).
> 
> There is a convention amongst NFS clients that each client will always
> flush *all* changes to the server upon close(), and it will always
> check the file attributes upon a call to open() (and if the mtime or
> file size have changed, one flushes the page cache).
> This suffices to guarantee file cache consistency *provided* that only
> one client opens the file at any given time.
> 
> If locking is used, all changes are flushed to the server upon
> taking/releasing a lock, and the page cache is guaranteed to get
> flushed upon taking a lock.

And remember- this depends entirely on the server working the way
lockd assumes. Some systems DON'T do this anyway, since locks are not
necessarily available except on the local system, and not on the server.

Even when they are available, race conditions will/can still void the
assumptions.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
