Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbRGJJR4>; Tue, 10 Jul 2001 05:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266109AbRGJJRq>; Tue, 10 Jul 2001 05:17:46 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:3019 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S266093AbRGJJRg>; Tue, 10 Jul 2001 05:17:36 -0400
Date: Tue, 10 Jul 2001 12:17:25 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Rob Landley <landley@webofficenow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Message-ID: <20010710121724.Z1503@niksula.cs.hut.fi>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01070912485904.00705@localhost.localdomain>; from landley@webofficenow.com on Mon, Jul 09, 2001 at 12:48:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 12:48:59PM -0400, you [Rob Landley] claimed:
> 
> (P.S. What kind of CPU load is most likely to send a processor into overheat? 
>  (Other than "a tight loop", thanks.  I mean what kind of instructions?)  
> This is going to be CPU specific, isn't it?  Our would a general instruction 
> mix that doesn't call halt be enough?  It would need to keep the FPU busy 
> too, wouldn't it?  And maybe handle interrupts.  Hmmm...)

See Robert Redelmeier's cpuburn:

http://users.ev1.net/~redelm/

It is coded is assembly specificly to heat the CPU as much as possible. See
the README for details, but it seems that floating point operations are
tougher than integers and MMX can be even harder (depending on CPU model, of
course). Not sure what kind of role SSE, SSE2, 3dNow! play these days.
Perhaps Alan knows?
 
> I wonder...  The torture test Tom's Hardware guide uses for processor 
> overheating is GCC compiling the Linux kernel. 

That shouldn't really be that good a test. During compilation, CPU spends a
_lot_ of time waiting for the memory and even for the disk io. For maximum
heat, you really want a tight loop of instructions, that sits firmly in L1
cache.

The gcc compile is a good test for many other tests - it uses a lot of
memory with complex pointers references (tests memory, and bit errors in
pointers are likely to sig11 rather than produce subtle errors in output),
stresses chipset somewhat (memory throughput), and cpu somewhat. But to test
CPU overheating and nothing else, cpuburn should be a lot better. (Even
seti@home is better as it uses FPU). Just run them an observe the sensors
readings. Cpuburn gets several degrees higher.

> the compile in a loop, add in a processor temperature detector daemon to kill 
> the test and HLT the system if the temperature went too high...

Cpuburn exists when CPU miscalculates something (sign of overheat).

I'm not sure if cpuburn is included in cerberus these days (istr it is), but
a nice test set for memory, cpu, disk etc to run over night or over weekend
to catch most of the hw faults would definetely be nice. 


-- v --

v@iki.fi
