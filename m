Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRKMQWc>; Tue, 13 Nov 2001 11:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRKMQWW>; Tue, 13 Nov 2001 11:22:22 -0500
Received: from [212.18.232.186] ([212.18.232.186]:18706 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S274681AbRKMQWL>; Tue, 13 Nov 2001 11:22:11 -0500
Date: Tue, 13 Nov 2001 16:21:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: dalecki@evision.ag
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge BUG in 2.4.15-pre4 serial.c
Message-ID: <20011113162111.B21298@flint.arm.linux.org.uk>
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu> <3BF14F14.21D66343@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF14F14.21D66343@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Nov 13, 2001 at 05:49:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 05:49:24PM +0100, Martin Dalecki wrote:
> I have found the following code in serial.c aorund line 5565
> 
> #ifdef __i386__
> 	if (i == NR_PORTS) {
> 		for (i = 4; i < NR_PORTS; i++)
> 			if ((rs_table[i].type == PORT_UNKNOWN) &&
> 			    (rs_table[i].count == 0))
> 				break;
> 	}
> #endif
> 	if (i == NR_PORTS) {
> 		for (i = 0; i < NR_PORTS; i++)
> 			if ((rs_table[i].type == PORT_UNKNOWN) &&
> 			    (rs_table[i].count == 0))
> 				break;
> 	}
> 
> This is supposedly the result of applying some patch twice.
> Let me guess the first 8 lines of this can be deleted.

Look at it closer, in particular the for() loops.

It's basically there so that on x86, we don't normally use ttyS0-3
for pcmcia and other similar ports, unless we run out of other ports
to use.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

