Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSH0WnW>; Tue, 27 Aug 2002 18:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSH0WnW>; Tue, 27 Aug 2002 18:43:22 -0400
Received: from users.linvision.com ([62.58.92.114]:39835 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S315721AbSH0WnV>; Tue, 27 Aug 2002 18:43:21 -0400
Date: Wed, 28 Aug 2002 00:47:06 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: yodaiken@fsmlabs.com
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
Message-ID: <20020828004705.A24712@bitwizard.nl>
References: <20020827135400.A31990@hq.fsmlabs.com> <Pine.LNX.3.95.1020827160243.11549A-100000@chaos.analogic.com> <20020827145631.B877@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827145631.B877@hq.fsmlabs.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:56:31PM -0600, yodaiken@fsmlabs.com wrote:
> > No. You can easily read into memory 75,000 bytes per second from the
> > parallel port, hell RS-232C will do 22,400++ bytes per second (224,000
> > baud) on a Windows machine, done all the while to feed a PROM burner. I
> 
> You can do it in a tight loop. But you cannot do it otherwise.  RS232 works
> because most UARTs have fifo buffers.  Old Windows did pretty well, because
> you could grab the machine and let nothing else happen.
> 
> What makes me dubious about your claim is that it is easy to test
> and see that a single ISA operation can take 18 microseconds
> on most PC hardware.
> 
> try:
> 	cli
> 	loop:
> 		read tsc
> 		inb 
> 		read tsc
> 		compute difference
> 		print worst case every 1000000 times.
> 
> 	sti
> 
> run for an hour on a busy machine.

That machine won't be busy if you disable interrupts for an hour... :-)

I have benchmarked a Linux system (probably 2.0 era!) to handle
about 140k interrupts per second. I was NOT worried about  missing
one interrupt. We would  see userspace significantly slowing down 
around 120k interrupts per second, and at around 140k interrupts
per second, the machine would grind to a halt. Until you turned
the interrupt generator back down below the limit. 

This was with a 120MHz Pentium. 

I wouldn't be surprised if you could handle around 75k interrrupts
per second without missing one if all other interrupts are behaving. 
(i.e. don't disable interrupts for more than 7 us). 

(Of course pulling in 163 Mb per second over an ordinary 33MHz 32bit 
PCI bus is impossible, and quite difficult on 33MHz/64bit or 66MHz/32bit
and doable on 66MHz/64bit).

					Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
