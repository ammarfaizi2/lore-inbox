Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319548AbSH3LfA>; Fri, 30 Aug 2002 07:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319550AbSH3LfA>; Fri, 30 Aug 2002 07:35:00 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:30453 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S319548AbSH3Le7>; Fri, 30 Aug 2002 07:34:59 -0400
Date: Fri, 30 Aug 2002 13:39:13 +0200
From: Frank Otto <Frank.Otto@tc.pci.uni-heidelberg.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, mdheffner@yahoo.com
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
Message-ID: <20020830133913.A13049@goedel.pci.uni-heidelberg.de>
References: <20020826170037.69164.qmail@web40210.mail.yahoo.com> <1030381725.1750.10.camel@irongate.swansea.linux.org.uk> <200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de> <20020829121103.48b5920d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020829121103.48b5920d.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Aug 29, 2002 at 12:11:03PM +1000, Stephen Rothwell wrote:
> 
> Interesting ... Howlong does "cat /proc/apm" take?
> On my Thinkpad T22 I get:
> 
> # time cat /proc/apm
> 1.16 1.2 0x03 0x01 0x00 0x01 99% -1 ?
> 
> real	0m0.009s
> user	0m0.000s
> sys	0m0.010s

On my Thinkpad R32, the timings vary:

real:  anything between 15ms and 40ms
user:  mostly 0ms, sometimes 10ms
sys:   mostly 20ms, sometimes 30ms

To get average values, I did this:

blackmagic:~> time for i in `seq 1 600`; do cat /proc/apm >/dev/null; done

real    0m14.775s
user    0m0.700s
sys     0m12.650s

However, these values are rather bogus; I also measured the time with
my digital wristwatch. Result: 60.60s
                               ======
To measure the overhead of the shell command itself, I did this:

blackmagic:~> cat /proc/apm >/tmp/apm 
blackmagic:~> time for i in `seq 1 600`; do cat /tmp/apm >/dev/null; done

real    0m1.769s
user    0m0.900s
sys     0m0.690s

For the sake of simplicity, this overhead can be neglected. So:
reading /proc/apm 600 times roughly takes 60 real seconds, which
means that reading it once takes about 100ms. This is huge, isn't it?

BTW, I tried this both with apm_allow_ints enabled and disabled.
Didn't make much difference. (And my Thinkpad didn't hang after
the BIOS calls with apm_allow_ints disabled, so maybe IBM has fixed
a bug? By introducing another one ;-)

I think I haven't mentioned yet that I'm using a vanilla 2.4.19 kernel.

> while ...
> 
> # time ./tppow
> Battery 0 present power units mW[h] design capacity 38880 last full charge capacity 29260
> status 0x0 rate 0 cap 29172 voltage 12485
> 
> real	0m0.311s
> user	0m0.100s
> sys	0m0.000s
> 
> tppow is a C implementation of the disassembled APCI method for reading the
> battery status. It does not disable interrupts but does talk to the
> embedded controller in the Thinkpad.

Interesting. Where can I get `tppow'? Would it even be safe to use it
on a different Thinkpad?

Thanks,
Frank
