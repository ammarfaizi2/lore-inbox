Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRHGHts>; Tue, 7 Aug 2001 03:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRHGHt3>; Tue, 7 Aug 2001 03:49:29 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:22031 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S270130AbRHGHtZ>; Tue, 7 Aug 2001 03:49:25 -0400
Date: Tue, 7 Aug 2001 03:49:35 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807034935.C2399@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru> <Pine.LNX.4.33.0108062338130.5491-100000@mackman.net> <200108070705.f7775xl27094@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108070705.f7775xl27094@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Tue, Aug 07, 2001 at 11:08:38AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 07/08/01 11:08 +0400 - Evgeny Polyakov:
> Hello.
> RM> accessible for one power cycle.  Thus the computer can generate a key at
> No, computer can not do this.
> This will do some program,and this program is not crypted.
> Yes?
> We disassemle this program, get algorithm and regenerate a key in evil machine?
> Am i wrong?
> 
> P.S. off-topic What algorithm do you want to use to regenerate a key for once crypted data?
> I don't know anyone, or i can't understand your point of view.

The weakness here is in the seed we use for generating the encryption
key. This is not a fatal weakness. There are several scenarios:

a) the environment is trusted at boot. It has not been compromised, yet.
   In this scenario, the random state stored for the RG is pretty
chaotic; and we can read it in to initialize the RG, then immediatly
wipe it from disk. Assuming we are good about clearing the data, it
cannot be recovered; and the RG can be trusted to give us a good key.

In this scenario, you can not recover the key.

b) the environment is not trusted at boot. someone might have a dump of
the harddrive already, and is waiting to take a second dump.
   If we wish, we can write algorithms which induce chaos into the RG by
thrashing the page table, the cache, and the harddrives. We could devote
a second or two on boot to doing this, and get a few thousand bytes of
entropy from the /physical/ chaos we'd be playing with.
   Alternatively, physical RG devices exist; and are rather easy to
make. We install a device designed to be pyhsically chaotic, and write a
driver for it which constantly seeds the RG. This would give us very
good chaos.

In this scenario, you can not recover the key.

Do not assume that, since random number generation is patently
impossible with an algorithm; that it is impossible with a computer.
Computers /are/ machines, and minute timing differences, or devices
designed for the purpose, can be used to pull chaos out of the physical
world, and into our algorithms. In addition information which was once
predictable, but has been destroyed along with its sources, is still
lost to you.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
