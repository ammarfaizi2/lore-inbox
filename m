Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSFRPYJ>; Tue, 18 Jun 2002 11:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317447AbSFRPYI>; Tue, 18 Jun 2002 11:24:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317446AbSFRPYH>; Tue, 18 Jun 2002 11:24:07 -0400
Date: Tue, 18 Jun 2002 11:26:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Myrddin Ambrosius <imipak@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers, Hardware, and their relationship to Bagels.
In-Reply-To: <20020618150628.12694.qmail@web12305.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020618111156.3808B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Myrddin Ambrosius wrote:

> Hi all,
> 
> With the discussion on kernel crypto a while back,
> there was one very important recurring element that I
> would like someone to clarify for me.
> 
> The issue is this. My understanding is that -all-
> hardware access should be through the kernel, partly
> so that similar hardware can have a similar API, but
> also so that kernel security code (eg: capabilities)
> applies to ALL hardware and ALL lower-level
> operations.
> 
> However, there were a number of mentions of userland
> hardware drivers, which did NOT operate through the
> kernel. (This was in reference to why it wouldn't be
> necessary to have a kernel-level driver for the
> Motorola M190 crypto chip.)
> 
> If you can blithely ignore restrictions placed by the
> kernel on some piece of hardware, and access it
> directly, then surely this would apply to any
> hardware. Including disk drives, RAM, etc.
> 
> I could be wrong (and I hope, very much, that I am),
> but if my understanding is correct, then that's a hole
> you could drive a truck through, and have room to
> spare.
> 
> This isn't intended as a critisism of anyone, or of
> any decisions made regarding the way the kernel
> operates. (I know my phrasing leaves a lot to be
> desired. Sometimes I think my best chance of a long
> life would be to take a vow of silence and become a
> monk.)
> 
> I'd really appreciate it if someone could clarify this
> for me, especially the security aspect of non-kernel
> drivers.


No hole you can drive through. A process with a UID of 0 and
a GID of 0 can do anything it wants. It can execute iopl(3)
and set an I/O permission level that allows it to directly access
hardware I/O ports, etc. It can also turn off interrupts. Basically,
it can do anything, since such a process can also memory-map anything.

Users are not supposed to execute as 'root'. Also, only certain
priviliged tasks execute as root. Ignore that this account
"seems-to-be" root@chaos.analogic.com. This is an anti-spam trick.
The real root on this machine is called "system". Names mean nothing
to Unix, it's the UID/GID that counts.

You can make a priviliged task by setting the UID/GID to zero in
the first few lines of 'C' code of main(). This will fail unless
the resulting executable has its SUID bit set (chmod 4755 filename).
Further, this file has to execute in a root-owned directory. Once
these conditions are satisfied, the program can do anything it wants.

main()
{
   setuid(0);
   setgid(0);
   iopl(3);
   mmap(everything);
   destroy_the_world();
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

