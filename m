Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270607AbRHQTbA>; Fri, 17 Aug 2001 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHQTas>; Fri, 17 Aug 2001 15:30:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270584AbRHQTap>; Fri, 17 Aug 2001 15:30:45 -0400
Date: Fri, 17 Aug 2001 15:30:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nicholas Knight <tegeran@home.com>
cc: Adrian Cox <adrian@humboldt.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <01081711510800.00814@c779218-a>
Message-ID: <Pine.LNX.3.95.1010817152158.4584B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Nicholas Knight wrote:

> On Friday 17 August 2001 10:36 am, Adrian Cox wrote:
> > Richard B. Johnson wrote:
> > > ** At this instant, you just killed everything in RAM with precharge
> > > **
> >
> > I've done a bit more reading. The documentation I have here suggests
> > the precharge doesn't erase all of memory.  Precharge copies from the
> > sense amplifiers back into the current row. The erasure is a result of
> > the sense amplifiers losing their contents faster than the memory
> > cells, but even so only one of the 2^12 rows gets erased.
> 
> Now that we've established that SDRAM doesn't neccisarily get erased from 
> rebooting, does anyone know how long it takes for SDRAM to clear after 
> losing power? It seems to me that the fact that the RAM isn't neccisarily 
> wiped by the BIOS at boot is less important than wether or not shutting 
> down the system and having it shut down for 10 minutes causes the RAM to 
> be cleared so that any intruder/thief would be unable to get the 
> information neccisary to decrypt the swap...

We've established no such thing. In fact, you can't properly initialize
SDRAM memory without writing something to it. Further, reading SDRAM
after a power-on or a reset, will result in all 1s (0xffffffff) because
the SDRAM controller isn't even connected to the RAM. Further, in the
process of connecting it up (logically), the lowest 15 bits of all
SDRAM commands will end up being written to every chip. With SDRAM,
data are normally clocked in/out, once the precharge command is
executed, it's not even clocked. It works like this:

(1) Put a memory controller command in a controller register.
(2) Attempt to write RAM (anywhere), that makes the controller read
    and acccept the command.
(3) Continue with all commands. The last enables refresh.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


