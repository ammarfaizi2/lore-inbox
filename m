Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318489AbSGSHne>; Fri, 19 Jul 2002 03:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSGSHne>; Fri, 19 Jul 2002 03:43:34 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:30997 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318489AbSGSHnd>; Fri, 19 Jul 2002 03:43:33 -0400
Date: Fri, 19 Jul 2002 10:46:30 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: more thoughts on a new jail() system call
Message-ID: <20020719074629.GD1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <1026959170.14737.102.camel@zaphod> <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 12:21:47AM +0000, you [David Wagner] wrote:
> Shaya Potter  wrote:
> >sys_mknod) J - Need FIFO ability, everything else not.
> 
> Beware the ability to pass file descriptors across Unix
> domain sockets.  This should probably be restricted somehow.
> Along similar lines, you didn't mention sendmsg() and
> recvmsg(), but the fd-passing parts should probably be
> restricted.

I gather FreeBSD allow passing fd's, but not in or out the jail. Just inside
it.
 
> >sys_setuid16) ^J - since jail is secure, can setuid all you want.
> 
> I'd look very carefully at whether root can bypass any
> of the access controls you're relying on.  For instance,
> with root, one can bind to ports below 1024.

In FreeBSD jail, jailed root is supposed to be safe. So if something is
jailed - and has the necessary privileges - it can bind to the jail ip (each
jail has its own ip). But it can't bind to any other ip's of the box. 

http://docs.freebsd.org/44doc/papers/jail/jail-6.html#section10
 
> >sys_socketcall) J - Bind seems to be the only problem. jail() includes
> >an ip address, and a jailed process can only bind to that address. so
> >do we force the addr to be this address, or does one allow INADDR_ANY
> >and translate that to the jail'd ip address?

In FreeBSD, INADDR_ANY is explicitly translated to jail's IP. Many daemons
use INADDR_ANY routinely, so I think it makes sense.

> >sys_syslog) NOT SURE (probably jailed away)
> 
> sys_syslog touches a global shared resource, hence
> should probably be denied to jailed processes.

Ummh, most logical way would be to create an own syslog for each jail.
That's also the most laborous alternative, though...
 


-- v --

v@iki.fi
