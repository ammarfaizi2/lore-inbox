Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRDJMcl>; Tue, 10 Apr 2001 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDJMcc>; Tue, 10 Apr 2001 08:32:32 -0400
Received: from ns.suse.de ([213.95.15.193]:16137 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131625AbRDJMcT>;
	Tue, 10 Apr 2001 08:32:19 -0400
Date: Tue, 10 Apr 2001 14:32:16 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410143216.A15880@gruyere.muc.suse.de>
In-Reply-To: <20010410140202.A15114@gruyere.muc.suse.de> <E14mx0K-00049P-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14mx0K-00049P-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 01:12:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 01:12:14PM +0100, Alan Cox wrote:
> Measure the number of clocks executing a timer interrupt. rdtsc is fast. Now
> consider the fact that out of this you get KHz or better scheduling 
> resolution required for games and midi. I'd say it looks good. I agree

And measure the number of cycles a gigahertz CPU can do between a 1ms timer.
And then check how often the typical application executes something like
gettimeofday.

> the accounting of user/system time needs care to avoid slowing down syscall
> paths

It's also all interrupts, not only syscalls, and also context switch if you
want to be accurate.

On modern PC hardware it might be possible to do user/system accounting using
performance MSRs. They have a bit in the performance counter that allows to
only account user or system. If you find a count that is near equivalent to
the cycles you have both: total = rdtsc, user = msr, system = rdtsc-msr.
At least PPro derived have event 0x16, number of instructions executed, which
might be good enough when multiplied with a factor if your instruction mix is not 
too unusual.

Still even with that the more complex checking in add_timer doesn't look too good.


-Andi
