Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271810AbRHRLJs>; Sat, 18 Aug 2001 07:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRHRLJk>; Sat, 18 Aug 2001 07:09:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57723 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271810AbRHRLJa>; Sat, 18 Aug 2001 07:09:30 -0400
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: root@chaos.analogic.com, Nicholas Knight <tegeran@home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817152158.4584B-100000@chaos.analogic.com>
	<3B7E2CA5.50904@humboldt.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Aug 2001 05:02:28 -0600
In-Reply-To: <3B7E2CA5.50904@humboldt.co.uk>
Message-ID: <m1itflocl7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox <adrian@humboldt.co.uk> writes:

> Richard B. Johnson wrote:
> > We've established no such thing. In fact, you can't properly initialize
> > SDRAM memory without writing something to it.
> 
> After all of this theory it was time to do some experiments. I modified the BIOS
> 
> on my current PowerPC system to compare memory against a test pattern (I chose
> 0x31415926 incrementing by 0x27182817) over the address range 0x0 to
> 0x100000. This pattern has approximately 50% 1s and 50% 0s.

I'm curious was this embedded system or was it a stock PowerPC.  I
don't know of any off the shelf machines that come with BIOS source code.
 
> On pressing the reset button, I got 100% of bits holding the same value. If I
> turn the power off for 20s, I get approximately 90% of bits holding the same
> value. After a minute, it's dropped to the 50% level, which I take as random.

As another data point, I earlier tried a similiar experiment by
accident.  In that case I forgot to enable ram refresh.   And then
read and wrote patterns to the SDRAM.  In that case I could find one
or two bits wrong (but 99.99% of them correct), after only a second or
two.

> For added fun, I then tried turning off, pulling out the DIMM, plugging it into
> the other slot, and turning back on. 97% of the bits had the original value. So
> one attack we must consider is the attacker removing power, ripping the DIMM
> out, and plugging it into a special DIMM reading device.
> 
> Your descriptions on how memory is started look very machine specific. On mine
> (Motorola MPC107) I write the number of row bits, column bits, and internal
> banks to the memory controller, along with the CAS latency. I then set MEMGO,
> and the memory controller precharges each bank.

Ah you have one of the nice memory controllers.  On some you have
to do the prefreshs & co manually on others the memory controller will
do it for you.

The result here is interesting.  So while you don't loose everything
on powerdown.  About a minute after power down you do.  Not perfect
but it should be good enough to consider RAM self deleting in most
cases.  Except for the reset case which could prove very dangerous.  

For any of these attacks to prove workable you need to get a hold of
the machine while the power is still on.

So the attacker has two way to attack your machine.  Attempt to break
in while it is still running.  Put in a minimal boot cd and press
reset and see how much is recovered.  Generally breaking should prove
the more fruitful course, but the fact that reset preseves all of the
memory, means it simply is not safe for someone to have physical
access to your machine while the power is on.

Or do you read this differently?

Eric
