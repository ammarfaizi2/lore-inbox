Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262332AbTCIBTl>; Sat, 8 Mar 2003 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTCIBTl>; Sat, 8 Mar 2003 20:19:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33575 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262332AbTCIBTk>; Sat, 8 Mar 2003 20:19:40 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
	<m1d6l2lih9.fsf@frodo.biederman.org>
	<20030308100359.A27153@flint.arm.linux.org.uk>
	<m18yvpluw7.fsf@frodo.biederman.org> <3E6A5C44.9060002@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 18:29:46 -0700
In-Reply-To: <3E6A5C44.9060002@zytor.com>
Message-ID: <m1n0k5jpit.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > The last time I worked on something like this I put a dhcp client, and
> > a tftp client in a single binary, my compressed initrd was only 16K on
> > x86.  And I had a complete network boot loader using the linux kernel.
> > Now the kernel is so big and bloated it has not been practical to use
> > it.  So my effort has mostly been concentrated on etherboot.  Which
> > is essentially a mini-kernel that just focuses on being a network boot
> > loader.  And with etherboot I can get a udp/ip stack. With dhcp and
> > tftp support, and an eepro100 nic driver into 38K on an Itanium (The
> > platform with possible the most bloated binaries known to man).  On x86
> > with an eepro100 driver I can usually get it down to around 16K.  (All
> > sizes represent self decompressing executables).
> >
> 
> Incidentally, any hope of getting Etherboot to act as a PXE stack any time soon?

Etherboot is unlikely to support UNDI.

However there is already some code that was integrated that exports
the UDP/TFTP layers PXE clients use.  The code just needs some
cleanups so that it works, maybe weeks worth of work.  All of the
calls pxelinux use are already present.

> 	-hpa (ducks & runs)

I prefer an interface that does not need callbacks, things are just
plain simpler.  But when the callback is easy and there already is a
better mechanism I don't have a problem with it.

Of course it is worth noting that PXE runtime support on the itanium
does not even resemble PXE runtime support on x86.  Unlike unix it
does not have a stable API.

Eric
