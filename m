Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRDJMCS>; Tue, 10 Apr 2001 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRDJMCI>; Tue, 10 Apr 2001 08:02:08 -0400
Received: from ns.suse.de ([213.95.15.193]:38150 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131508AbRDJMCF>;
	Tue, 10 Apr 2001 08:02:05 -0400
Date: Tue, 10 Apr 2001 14:02:02 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410140202.A15114@gruyere.muc.suse.de>
In-Reply-To: <20010410075109.A9549@gruyere.muc.suse.de> <E14mw9t-00041m-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14mw9t-00041m-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 12:18:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 12:18:03PM +0100, Alan Cox wrote:
> > > interrupting decrementer.  (i.e just about any modern chip)
> > 
> > Just how would you do kernel/user CPU time accounting then ?  It's currently done 
> > on every timer tick, and doing it less often would make it useless.
> 
> On the contrary doing it less often but at the right time massively improves
> its accuracy. You do it on reschedule. An rdtsc instruction is cheap and all
> of a sudden you have nearly cycle accurate accounting

Does not sound very attractive all at all on non virtual machines (I see the point on
UML/VM):
making system entry/context switch/interrupts slower, making add_timer slower, just to 
process a few less timer interrupts. That's like robbing the fast paths for a slow path.

-Andi
