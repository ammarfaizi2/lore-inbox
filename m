Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUBJLQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUBJLQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:16:37 -0500
Received: from dsl-082-083-128-026.arcor-ip.net ([82.83.128.26]:50057 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S265820AbUBJLQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:16:35 -0500
Date: Tue, 10 Feb 2004 12:16:33 +0100
From: Dominik Kubla <dominik@kubla.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dominik Kubla <dominik@kubla.de>, Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040210111632.GA1229@intern.kubla.de>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk> <20040209124739.GC1738@mail.shareable.org> <20040209134005.GA15739@axis.demon.co.uk> <Pine.LNX.4.53.0402090853020.8894@chaos> <20040209175119.GC1795@intern.kubla.de> <Pine.LNX.4.53.0402091327020.9986@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402091327020.9986@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 01:27:24PM -0500, Richard B. Johnson wrote:
> On Mon, 9 Feb 2004, Dominik Kubla wrote:
> 
> > On Mon, Feb 09, 2004 at 09:00:24AM -0500, Richard B. Johnson wrote:
> > > > On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> > > > > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?
> > >
> > > Only people who want to log-in from the network..... Of course
> > > you could force a re-write of all the stuff like telnet, adding
> > > another layer of bugs that'll take another N years to find and
> > > remove.
> >
> > What are you talking about?  On my system (Debian Sid) there are no BSD
> > pty's (i removed the device nodes) and everything works without even a
> > recompile.
> >
> > Regards,
> >   Dominik
> 
> 
> Really? Then you don't have anybody trying to log-in
> from the network using telnet, then do you?

Really? How do you diagnose my system without even logging in?

[kubla@duron] telnet server1
Trying 192.168.xxx.xxx...
Connected to server1.intern.kubla.de.
Escape character is '^]'.
[SSL - attempting to switch on SSL]
[SSL - handshake starting]
[SSL - OK]
Password: 
Last login: Tue Feb 10 12:03:36 2004 from duron.intern.kubla.de on pts/0
Linux server1 2.6.0-1-k7 #2 Sun Jan 11 17:06:46 EST 2004 i686 GNU/Linux

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
You have mail.
[kubla@server1] tty
/dev/pts/0
[kubla@server1] ls -l /dev/pts/0
crw-------    1 kubla    tty      136,   0 Feb 10 12:08 /dev/pts/0


> The BSD virtual terminals go in pairs, /dev/ptyp* /dev/ttyp*
...
> Here, rjohnson is logged in using telnet. The code is so common
> that there is even some C runtime library support in later
> C libraries, it's called forkpty(). `man forkpty`. It does a lot
> of the dirty-work of using BSD virtual terminals.

Try removing you BSD pty's and most likely you will see that telnetd
happily uses System V pty's. If not then you should really update your
telnetd.  Both netkit-telnetd and telnetd-ssl, which is derived from it,
can use System V-ptys since at least 5 years, probably even longer.
If both BSD and System V pty's are present on the system, the code will use
BSD. (That's why i removed the BSD pty's in the first place!)

Regards,
  Dominik
-- 
"Conversion, fastidious Goddess, loves blood better than brick, and feasts
most subtly on the human will."
-- Virginia Woolf, "Mrs. Dalloway"
