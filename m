Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUBISY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUBISY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:24:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29058 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265319AbUBISYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:24:52 -0500
Date: Mon, 9 Feb 2004 13:27:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dominik Kubla <dominik@kubla.de>
cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
In-Reply-To: <20040209175119.GC1795@intern.kubla.de>
Message-ID: <Pine.LNX.4.53.0402091327020.9986@chaos>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk>
 <20040209124739.GC1738@mail.shareable.org> <20040209134005.GA15739@axis.demon.co.uk>
 <Pine.LNX.4.53.0402090853020.8894@chaos> <20040209175119.GC1795@intern.kubla.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Dominik Kubla wrote:

> On Mon, Feb 09, 2004 at 09:00:24AM -0500, Richard B. Johnson wrote:
> > > On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> > > > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?
> >
> > Only people who want to log-in from the network..... Of course
> > you could force a re-write of all the stuff like telnet, adding
> > another layer of bugs that'll take another N years to find and
> > remove.
>
> What are you talking about?  On my system (Debian Sid) there are no BSD
> pty's (i removed the device nodes) and everything works without even a
> recompile.
>
> Regards,
>   Dominik


Really? Then you don't have anybody trying to log-in
from the network using telnet, then do you?

The BSD virtual terminals go in pairs, /dev/ptyp* /dev/ttyp*

Script started on Mon Feb  9 13:19:16 2004
# ls -la /dev/ptyp*
crw-rw-rw-   1 root     root       2,   0 Feb  9 13:17 /dev/ptyp0
crw-rw-rw-   1 root     root       2,   1 Feb  9 13:19 /dev/ptyp1
crw-rw-rw-   1 root     root       2,   2 Feb  5 11:22 /dev/ptyp2
crw-rw-rw-   1 root     root       2,   3 Mar 19  2003 /dev/ptyp3
[SNIPPED...]

# ls -la /dev/ttyp0
# ls -la /dev/ttyp*
crw--w----   1 rjohnson tty        3,   0 Feb  9 13:17 /dev/ttyp0
crw-rw-rw-   1 root     root       3,   1 Feb  9 13:19 /dev/ttyp1
crw-rw-rw-   1 root     root       3,   2 Feb  5 11:22 /dev/ttyp2
crw-rw-rw-   1 root     root       3,   3 Mar 19  2003 /dev/ttyp3
Script done on Mon Feb  9 13:20:03 2004

Here, rjohnson is logged in using telnet. The code is so common
that there is even some C runtime library support in later
C libraries, it's called forkpty(). `man forkpty`. It does a lot
of the dirty-work of using BSD virtual terminals.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


