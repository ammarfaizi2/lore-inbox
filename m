Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHSR05>; Sun, 19 Aug 2001 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbRHSR0r>; Sun, 19 Aug 2001 13:26:47 -0400
Received: from [65.10.228.207] ([65.10.228.207]:13042 "HELO whatever.local")
	by vger.kernel.org with SMTP id <S266488AbRHSR0h>;
	Sun, 19 Aug 2001 13:26:37 -0400
From: chuckw@ieee.org
Date: Sun, 19 Aug 2001 01:35:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
Message-ID: <20010819013508.B2388@ieee.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010818231704.A2388@ieee.org> <3B7FF06A.4090606@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7FF06A.4090606@fugmann.dhs.org>; from afu@fugmann.dhs.org on Sun, Aug 19, 2001 at 06:59:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

	So, Bottom halves don't need to be re-entrant as do tasklets.  SoftIRQ's
need to be re-entrant.  The advantage of tasklets is that each tasklet can
be farmed out to different CPU's AND they don't need to be re-entrant 
because only one instance is allowed at a time.  I think I got it.

	Could you direct me to some code in the kernel which uses tasklets
so I can see the inner workings?

Thanks much,
Chuck

On Sun, Aug 19, 2001 at 06:59:22PM +0200, Anders Peter Fugmann wrote:
> 
> chuckw@ieee.org wrote:
> > Greetings,
> > 	I was reading the unreliable guide to kernel hacking and was looking for
> > a little clarification on something.  2 Bottom halves cannot run at the same
> > time, why? 
> 
> Per linux definition of bottom halves, there can only run one buttom 
> half at one system wide. But dont use those - They are old and waists 
> resources. Try tasklets instead. Multible tasklets can run in parrallel 
> (but not the same tasklet)
> 
> > 	Also, could someone give me an example of a service which is a bottom half/
> > tasklet/SoftIRQ?
> Simple.
> 
> Imagine some hardware that generates interrupts.
> Now we want to write a driver that keeps the hardware busy, so we 
> implement a top half handler (IRQ-handler), and let it retrieve som data 
> from the hardware. Instead of processing it right away, we shedule a 
> tasklet to do that job. This way we can handle more interrupts/sec from 
> the card, and the hardware is kept busy.
> 
> 
> To summerize.
> Buttom halves are the strictest (only one at a time.)
> Takslets can run in parralel, but still no need to worry about reentrant 
> code.
> SoftIrq give no guarrentee at all, and should be used with great care
> (code need to be reentrant).
> 
> Also try to readLinux device drivers by  A. Rubini:
> http://www.xml.com/ldd/chapter/book/index.html
> 
> Hope it helps.
> Anders Fugmann
> 
> > 
> > Thanks in advance,
> > Chuck
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
