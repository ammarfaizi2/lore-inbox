Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314615AbSD0VPn>; Sat, 27 Apr 2002 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314618AbSD0VPm>; Sat, 27 Apr 2002 17:15:42 -0400
Received: from bstnma1-ar1-4-64-205-250.bstnma1.elnk.dsl.genuity.net ([4.64.205.250]:6363
	"EHLO mail.spoofed.org") by vger.kernel.org with ESMTP
	id <S314617AbSD0VPl>; Sat, 27 Apr 2002 17:15:41 -0400
Date: Sat, 27 Apr 2002 17:19:02 -0400
From: Warchild <warchild@spoofed.org>
To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
Message-ID: <20020427211902.GD6240@spoofed.org>
In-Reply-To: <20020427202756.GC6240@spoofed.org> <3CCB0EAB.9050602@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 01:48:43PM -0700, Bryan Rittmeyer wrote:

> > [oh my god, i see userspace text strings in ARP packets]

*sigh*


> It's not the ARP layer that's causing the padding... Ethernet has a
> minimum transmit size of 64 bytes (everything below that is disgarded
> by hardware as a fragment), so the network device driver or
> the hardware itself will pad any Linux skb smaller than 60 bytes up to
> that size (so that it's 64 bytes after appending CRC32). Apparently, in
> some cases that's done by just transmitting whatever uninitialized
> memory follows skb->data, which, after the system has been running
> for a while, may be inside a page previously used by userspace.

That makes perfect sense.  Thanks for the explanation.

> This is NOT a "remote memory reading" exploit, since there is no way to
> remotely control what address in memory gets used as padding. I guess
> you could packet blast a machine and hope to find something
> interesting, but that'd be a denial of service attack long before you
> got a complete view of system memory. In any case, it's arguably
> userspace's responsibility to clear any sensitive memory contents
> before exiting. I would be more concerned if you can find data
> from currently in use, userspace-allocated pages flying out as packet
> padding (i.e. if reading past skb->data pushes you into somebody else's
> page, which seems unlikely since new skb's tend to get allocated near
> the beginning of a page).

Correct.  It'd take far too long and I'd go cross-eyed long before I got
anything other than useless garbage.  Isn't this similar to the bug within
the last year that dealt with userland memory disclosure via tcp/icmp?  What
was the "verdict" with that?

Please note that nowhere in my email did I use the word exploit.
 

> If you are really concerned you could probably patch the network driver
> to zero out memory that will be used as padding, though I don't think
> the security risk justifies that performance hit.

Agreed.  It doesn't bother me much at all.  I was just curious what was
going on.

thanks, and keep up the good work,

-warchild
