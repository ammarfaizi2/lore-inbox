Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287652AbRLaVMC>; Mon, 31 Dec 2001 16:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbRLaVLx>; Mon, 31 Dec 2001 16:11:53 -0500
Received: from riseup.net ([216.162.197.233]:42244 "EHLO riseup.net")
	by vger.kernel.org with ESMTP id <S287652AbRLaVLn>;
	Mon, 31 Dec 2001 16:11:43 -0500
Date: Mon, 31 Dec 2001 13:11:36 -0800
From: Micah Anderson <micah@riseup.net>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20 crashing every other day
Message-ID: <20011231131136.T19151@riseup.net>
In-Reply-To: <20011231115217.P19151@riseup.net> <20011231213024.A22942@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231213024.A22942@fafner.intra.cogenit.fr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Francois Romieu wrote:

> Micah Anderson <micah@riseup.net> :
> [data corruption]
> > This is an AMD 800mhz system with 256MB RAM, every partition, except
> [...]
> > 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
> 
> See:
> <URL:http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0690.html>
> <URL:http://www.cs.Helsinki.fi/linux/linux-kernel/2001-48/0958.html>
> <URL:http://www.cs.Helsinki.fi/linux/linux-kernel/2001-48/1113.html>

I must say, I am amazed at how quickly responses have come in!

The NorthBridge bug in the VIA chipset does seem to have the register
set to the "faulty" value on my machine. Evidence:

hexdump /proc/bus/pci/00/00.0:

0000000 1106 0305 0006 a210 0003 0600 0800 0000
0000010 0008 e000 0000 0000 0000 0000 0000 0000
0000020 0000 0000 0000 0000 0000 0000 147b a401
0000030 0000 0000 00a0 0000 0000 0000 0000 0000
0000040 0000 0000 0000 0000 0000 0000 0000 0000
0000050 f416 b46b 8947 1010 0080 1008 1010 1010

------------------^^

0000060 0003 2000 d4e4 00d4 0850 0d65 3f08 0000
0000070 88d8 0ccc 810e 00e2 b401 0219 0000 0000
0000080 400f 0000 00c0 0000 0002 0000 0000 0000
0000090 0000 0000 0000 0000 0000 0000 3200 0000
00000a0 c002 0020 0203 1f00 0000 0000 122f 0000
00000b0 63db 601a ff31 0e80 0067 0000 0000 0000
00000c0 0001 0002 0000 0000 0000 0000 0000 0000
00000d0 0000 0000 0000 0000 0000 0000 0000 0000
*
00000f0 0000 0000 0300 0003 0022 0000 8000 0000
0000100


Unfortunately, the patch which was posted at:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0817.htm is for
2.4.9:/arch/i386/kernel/pci-pc.c the likes of this file doesn't exist
in 2.2.20... I assume the equivalent is /drivers/pci/pci.c, but it
doesn't have some of the code which the patch plays with,
unfortunately I dont know enough about the kernels to determine how to
"backpatch" this, anyone have a 2.2 patch?!


> > 00:11.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
> > Linux 2.2.20RAID (root@sarai) (gcc 2.95.2 20000220 ) #2 1CPU [sarai.(none)]
>                                      ^^^^^^
> Buggy compiler. Drop it. 

Woops, now I'm running with 2.7.2.3, doubt that is causing the problem
however, sounds more likely the above issue.

Micah

