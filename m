Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbREBDnn>; Tue, 1 May 2001 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbREBDnY>; Tue, 1 May 2001 23:43:24 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:31762 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132398AbREBDnU>; Tue, 1 May 2001 23:43:20 -0400
Date: Tue, 1 May 2001 23:43:18 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Seth Goldberg <bergsoft@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <3AEF6F71.A75D478F@home.com>
Message-ID: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this has nothing to do with the very specific disk corruption
> > being discussed (which has to do with the ide controller, according
> > to the most recent rumors.).
> 
>   Actually, I think there are 2 problems that have been discussed -- the
> disk corruption and a general instability resulting in oops'es at
> various points shortly after boot up.

I don't see this.  specifically, there were scattered reports
of a via-ide problem a few months ago; this is the issue that's 
gotten some press, and for which Alan has a fix.  and there are reports 
of via-smp problems at boot (which go away with noapic).  I see no reports 
of the kind of general instability you're talking about.  and all the 
via-users I've heard of have no such stability problems - 
me included (kt133/duron).

the only general issue is that kx133 systems seem to be difficult
to configure for stability.  ugly things like tweaking Vio.
there's no implication that has anything to do with Linux, though.
> 
>   My memory system jas been set up very conservitavely and has been
> rock solid in my other board (ka7), so I doubt it's that, but I
> sure am happy to try a few more cominations of bios settings.  Anything
> I should look for in particular?

how many dimms do you have?  interleave settings?  Vio jumper?
already checked on cooling issues?  and that you're not overclocking...

> > why resort to silly windows tools, when lspci under Linux does it for you?
> 
>   Because lspci does not display all 256 bytes of pci configuration
> information.

sure it does: (from my kt133 hostbridge)

[root@crema /root]# lspci -s 00:00.0 -xxx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00: 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 27 a4 0b b4 46 02 08 08 08 00 00 00 04 08 08 08
60: 0c 00 00 00 d5 d6 d5 00 50 5d 86 0d 08 01 00 00
70: c9 88 cc 0c 0e a0 d2 00 01 b4 01 02 00 00 00 00
80: 0f 40 00 00 f0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 2b 02 04 00
b0: 7f 63 2a 65 31 33 c0 0c 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 00 00

[root@crema /root]# od -Ax -txC /proc/bus/pci/00/00.0 
000000 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
000010 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
000020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000030 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
000040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000050 27 a4 0b b4 46 02 08 08 08 00 00 00 04 08 08 08
000060 0c 00 00 00 d5 d6 d5 00 50 5d 86 0d 08 01 00 00
000070 c9 88 cc 0c 0e a0 d2 00 01 b4 01 02 00 00 00 00
000080 0f 40 00 00 f0 00 00 00 02 00 00 00 00 00 00 00
000090 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0000a0 02 c0 20 00 07 02 00 1f 00 00 00 00 2b 02 04 00
0000b0 7f 63 2a 65 31 33 c0 0c 00 00 00 00 00 00 00 00
0000c0 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
0000d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0000f0 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 00 00
000100


