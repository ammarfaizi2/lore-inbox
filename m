Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbRETMFz>; Sun, 20 May 2001 08:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbRETMFq>; Sun, 20 May 2001 08:05:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:6406 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261866AbRETMFi>; Sun, 20 May 2001 08:05:38 -0400
Date: Sun, 20 May 2001 16:05:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520160518.A8223@jurassic.park.msu.ru>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519181127.A14645@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519181127.A14645@twiddle.net>; from rth@twiddle.net on Sat, May 19, 2001 at 06:11:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 06:11:27PM -0700, Richard Henderson wrote:
> I'd rather keep this around.  It should be possible to use on CIA2.

Ok. What do you think about reorg like this:
basically leave the old code as is, and add
        if (is_pyxis)
                alpha_mv.mv_pci_tbi = cia_pci_tbi_try2;
        else
                tbia test
                ...

> Uggg.  How did you discover this?

21174 docs confirm that (though in a very low voice ;-) :
 "The 21174 may hang with TBIA=3."
It hangs with TBIA=2 as well. I was able to reproduce it reliably
on sx164 with direct windows disabled just by copying 10-20 Mb via 3c905b
card -- this driver allocates/frees pci buffers at a very high
rate, so "tbia" occurs pretty often.
The fix itself took 2 days of hacking and 50+ reboots...

> Just delete it, don't comment it out.  You might mention in the
> function header comment that we're called with interrupts disabled.

Ok.

> > -	*(vip)CIA_IOC_CIA_CTRL;
> > -	mb();
> 
> I'm pretty sure you don't want to do this.

Right... I noticed these deleted lines only after posting the patch.

Ivan.
