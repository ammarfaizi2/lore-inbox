Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbTCaLJD>; Mon, 31 Mar 2003 06:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCaLJD>; Mon, 31 Mar 2003 06:09:03 -0500
Received: from cascadia.drizzle.com ([216.162.192.17]:16398 "EHLO drizzle.com")
	by vger.kernel.org with ESMTP id <S261572AbTCaLJB>;
	Mon, 31 Mar 2003 06:09:01 -0500
Date: Mon, 31 Mar 2003 03:20:22 -0800 (PST)
From: Beau Hargis <beauh@drizzle.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-mjb1 network oddities encountered
Message-ID: <Pine.LNX.4.44.0303302037270.31608-100000@drizzle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Everything seems to work ok, except the networking.  At first I was not
sure what to think of it until I realized that ACPI was compiled in by
default. I disabled acpi at boot (acpi=off) and was then able to get the
interface eth0 to work. The card is an ISA smc_ultra.

The module smc_ultra loads fine, as well as 8390 and crc32, and reports
that it is using irq=10, io=0x240 and memory=0xde000-0xdffff which is
correct and the same values reported under 2.4. The routes configure
correctly, the address for the interface (10.0.0.10) can be pinged and
localhost can be pinged, but outside is unreachable. The error that is
occuring is:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x2, t=1097.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x2, t=2073.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x43, t=1142.

Again, if I disable ACPI, everything works beautifully. It is not an issue
for me; it was just that ACPI was compiled in by default. I don't know if
that is a known issue (I couldnt find any mention of it), or perhaps some
user-space setup is required (I never had any reason to mess with ACPI
before). Also, it's the same with or without IO-APIC, FWIW. I checked, 
just in case, since it seemed to be an interrupt related problem.

The only other strange thing that I discovered is that PCMCIA was compiled
in by default as well as a PCMCIA NE2K driver which caused be a bit of
confusion at first because I was looking for the 8390 module and it wasn't
there. Some digging led me to the discovery that 8390.o was compiled into
the kernel as well as CRC32. No missing symbols when the modules were
installed or when loaded. The odd part was that upon deselecting PCMCIA to
be compiled, 8390.ko was generated, but CRC32 symbols did not get
exported, where as they did get exported when 8390 was compiled into the
kernel.  But, again, not a problem, changing CRC32 to a module fixed 
that... just odd to me, that's all.


Other than that, I am worried that there might be something seriously 
wrong. There were no oopses of any kind, at all. :)

-- 

-------------------------
&${\eval(unpack("u*",'F(\'-U8GMP<FEN=")<;F)E875H7$!S8VAW;V]G;&4N;W)G7&XB.WT`'))}


