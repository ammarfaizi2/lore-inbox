Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDJMcb>; Tue, 10 Apr 2001 08:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDJMcW>; Tue, 10 Apr 2001 08:32:22 -0400
Received: from stm.lbl.gov ([131.243.16.51]:40965 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S131590AbRDJMcE>;
	Tue, 10 Apr 2001 08:32:04 -0400
Date: Tue, 10 Apr 2001 05:31:05 -0700
From: David Schleef <ds@schleef.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410053105.B4144@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <20010410044336.A1934@stm.lbl.gov> <Pine.LNX.3.96.1010410135540.17123B-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010410135540.17123B-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Tue, Apr 10, 2001 at 02:04:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 02:04:17PM +0200, Mikulas Patocka wrote:
> 
> Adding and removing timers happens much more frequently than PIT tick, so
> comparing these times is pointless.
> 
> If you have some device and timer protecting it from lockup on buggy
> hardware, you actually
> 
> send request to device
> add timer
> 
> receive interrupt and read reply
> remove timer
> 
> With the curent timer semantics, the cost of add timer and del timer is
> nearly zero. If you had to reprogram the PIT on each request and reply, it
> would slow things down. 
> 
> Note that you call mod_timer also on each packet received - and in worst
> case (which may happen), you end up reprogramming the PIT on each packet.

This just indicates that the interface needs to be richer -- i.e.,
such as having a "lazy timer" that means: "wake me up when _at least_
N ns have elapsed, but there's no hurry."  If waking you up at N ns
is expensive, then the wakeup is delayed until something else
interesting happens.

This is effectively what we have now anyway.  Perhaps the
current add_timer() should be mapped to lazy timers.




dave...

