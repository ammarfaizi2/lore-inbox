Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271641AbRHVNlE>; Wed, 22 Aug 2001 09:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272002AbRHVNky>; Wed, 22 Aug 2001 09:40:54 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:50701 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S271641AbRHVNkt>; Wed, 22 Aug 2001 09:40:49 -0400
Date: Wed, 22 Aug 2001 08:41:00 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108221341.IAA35277@tomcat.admin.navo.hpc.mil>
To: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Could NFS daemons be started via inetd?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA <VDA@port.imtp.ilyichevsk.odessa.ua>:
> Hi,
> 
> I am setting up NFS on my Linux box.
> When I start server daemons from init scripts or by hand,
> everything is working fine.
> 
> I tried to arrange these daemons to be run by inetd
> but after I issue an NFS mount command inetd starts spawning
> tons on rpc.mountd daemons. Log is filled with:
> rpc.mountd[179]: connect from 127.0.0.1
> rpc.mountd[180]: connect from 127.0.0.1
> ...
> and load average goes up (went up to 40)
> I repeatedly killall'ed rpc.mountd and eventually inetd
> noticed failing service and disabled it.
> 
> Does anybody tried this? If you do, I am very interested in your
> inetd.conf and/or NFS part of startup script. Mine is:
....

Simple answer - no.

The reason it can't is in two parts:

1. these daemons create their own socket rather than recieving one
   from inetd.
2. The daemons must connect to rpcbind or portmap. Usually this daemon
   is not running at the time inetd is started.

The nfs daemon actually starts multiple daemons (it forks up to n servers
for "optimum" client support). Each server daemon may be servicing a
different client (or even the same client, different request). I have
seen performance improvements (NOT on a Linux server...) of one server
for each mount on each client (up to 18-25 servers).

These daemons must run all the time or performance will be REALLY bad. Each
connection may request ~ 8K bytes of data. 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
