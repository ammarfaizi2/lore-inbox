Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272223AbRIEQTK>; Wed, 5 Sep 2001 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272220AbRIEQTB>; Wed, 5 Sep 2001 12:19:01 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:46932 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S272218AbRIEQSw>; Wed, 5 Sep 2001 12:18:52 -0400
Date: Wed, 5 Sep 2001 11:19:07 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109051619.LAA58471@tomcat.admin.navo.hpc.mil>
To: Florian.Weimer@RUS.Uni-Stuttgart.DE,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: getpeereid() for Linux
Cc: Michael Bacarella <mbac@nyct.net>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>:
> 
> Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:
> 
> > It is not possible to get a creditential from TCP connections yet. That
> > requires an extension to IPSec to even be able to carry credentials. There
> > is no reliable communication path (even for identd) to be able to pass
> > credentials.
> 
> I need the credentials only for local connections, though.  This is
> technically possible.  A userspace implementation partially cloning
> ident seems to be a possible approach.

It won't be reliable. Even the documentation for ident (at least the version
I looked at a while ago, might be different now, but I don't think so) says
that the data returned is not reliable. (even fuser doesn't always get this
right when trying to identify processes with open sockets).

Part of the problem is that TCP sockets don't carry the same information
that domain sockets have (could be partially wrong here, it just may not
be filled in since the source of the data can't supply it). The other
part is that it depends on what allocated the socket. Ownership is established
at socket allocation time, and the socket can be passed to a totally different
user. Identity of the user of the socket is therefore lost.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
