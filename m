Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBOWmZ>; Sat, 15 Feb 2003 17:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTBOWmZ>; Sat, 15 Feb 2003 17:42:25 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:4328 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id <S265339AbTBOWmY>;
	Sat, 15 Feb 2003 17:42:24 -0500
Date: Sat, 15 Feb 2003 23:52:04 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
Message-ID: <20030215225204.GA6887@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <20030215111705.GA11127@k3.hellgate.ch> <3E4E9028.3090601@pobox.com> <20030215205302.GB4627@k3.hellgate.ch> <3E4EB5E4.9070508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4EB5E4.9070508@pobox.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.61 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003 16:49:24 -0500, Jeff Garzik wrote:
> I applied the patch, but I meant more that wait_for_reset seems 
> questionable.  There is generally a PIO or MMIO write preceding 
> wait_for_reset function call, and then the function delays.  If the PCI 
> write is posted, for example, which at least my own Via EPIA does, then 
> you cannot be guaranteed the timing of
> 	write[bwl]()
> 	udelay(5)
> 
> PCI writes must be flushed, by doing a read[bwl]().

Thanks for raising that issue. It is my understanding that PIO ops are
synchronous (on IA-32). If that is correct, problems should only occur if
the driver is built with MMIO support, no?

I have been building the driver without MMIO for quite a while to eliminate
one source of problems for now.

> what the exact handling is... and randomly placed udelay() calls are, 
> unfortunately, sometimes a sign of driver bugs instead of necessary 
> hardware delays.

You won't see me rule out driver bugs as a likely explanation for anything
anytime soon ;-).

> I would prefer both user and developer docs go in 
> Documentation/networking/via-rhine.txt.  It is easy enough to note 
> separate sections of the document...

ACK.

Roger
