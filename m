Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282393AbRLDLhE>; Tue, 4 Dec 2001 06:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283077AbRLDLgp>; Tue, 4 Dec 2001 06:36:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:43765 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S283058AbRLDLgm>; Tue, 4 Dec 2001 06:36:42 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <21084.1007432885@kao2.melbourne.sgi.com> 
In-Reply-To: <21084.1007432885@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Hiro Yoshioka <hyoshiok@miraclelinux.com>, kdb@oss.sgi.com,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: [Linux-ia64] Announce: kdb v1.9 is available for kernel 2.4.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 11:36:09 +0000
Message-ID: <14342.1007465769@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@melbourne.sgi.com said:
> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2000-Week-36/0575.html
> http://marc.theaimsgroup.com/?l=linux-kernel&m=96865229622167&w=2 

The answer, of course, is to do all your debugging in the MIPS kernel, which
even in Linus' tree contains gdb stubs, although I think Linus' tree is 
missing the gdbconsole which sends all printk output as GDB $O packets.

	(gdb) tar rem /dev/ttyS0
	Remote debugging using /dev/ttyS0
	0x80110070 in breakinst ()
	(gdb) cont
	Continuing.
	CPU revision is: 00002721
	FPU revision is: 00002720
	Primary instruction cache 16KiB.
	Primary data cache 16KiB.
	Secondary cache 256KiB, linesize 32 bytes.
	Enabling secondary cache...Done
	Tertiary cache present, not (yet) enabled
	TLB has 64 entries.
	Linux version 2.4.16-0.4 (dwmw2@passion.cambridge.redhat.com) (gcc version

While I sort of see Linus' point, there are two cases where it falls down 
most often for me.

Firstly, roughly half the bugs which I track by poking around with GDB are
caused by toolchain/compiler problems, not by bogus code. Looking at the
code and thinking hard does _not_ help you here. You have to see what's
buggered, compare the code with the asm and slowly find out what went wrong.
If BUG() contains a breakpoint and you can poke at it all immediately,
that's a _lot_ easier than forty-five recompilations and reboots with extra
printks in random places, the final one of which changes the compiler's
output so it no longer exhibits the same bug.

Secondly, the point about not having a debugger making you more careful may
be true - but half the time I track bugs, they're not in my own code. In
fact, I'd go as far as to say the 99% of the bugs I actually use GDB for
aren't in my own code. Some _other_ bugger has been careless, and I'm here
trying to pick up the pieces. 

(Sorry for taking the bait - but anything's better than the evolution thread)

--
dwmw2


