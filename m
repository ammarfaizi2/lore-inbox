Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288402AbSANAQ4>; Sun, 13 Jan 2002 19:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSANAQr>; Sun, 13 Jan 2002 19:16:47 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:14498 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288402AbSANAQc>; Sun, 13 Jan 2002 19:16:32 -0500
Date: Mon, 14 Jan 2002 01:23:03 +0100
From: Till Doerges <nospamplease@doerges.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: System locks up after "spurious 8259A interrupt: IRQ7"
Message-ID: <20020114012303.B2710@atlan.wanderer.none>
In-Reply-To: <20020114010019.A2710@atlan.wanderer.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114010019.A2710@atlan.wanderer.none>; from nospamplease@doerges.net on Mon, Jan 14, 2002 at 01:00:19AM +0100
Organization: <none>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 01:00:19AM +0100, Till Doerges wrote:

> sporadically my machine hangs (no response to keyboard, can't connect
> via network, no interaction via remote-control) and the last thing I
> see (if I see anything at all) is something like
> 
> --- snip ---
> [...]
> Jan 13 21:30:00 atlan CROND[2876]: (till) CMD (fetchmail&> /dev/null)
> Jan 13 21:30:09 atlan kernel: spurious 8259A interrupt: IRQ7.
> Jan 13 21:36:12 atlan syslogd 1.3-3: restart (remote reception).
> Jan 13 21:36:12 atlan kernel: klogd 1.3-3, log source = /proc/kmsg started.
> [...]
> --- snap ---

Sorry, for not having done this in the first mail already: I've found
another occurence of the problem in a logfile, which I had forgotten
about:

--- snip ---
[...]
Nov 20 14:30:00 atlan CROND[4109]: (root) CMD (   /sbin/rmmod -as)
Nov 20 14:30:00 atlan CROND[4110]: (till) CMD (fetchmail&> /dev/null)
Nov 20 14:34:45 atlan kernel: spurious 8259A interrupt: IRQ7.
Nov 20 14:34:55 atlan kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Nov 20 14:34:55 atlan kernel: hdc: lost interrupt
Nov 20 14:35:05 atlan kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Nov 20 14:35:05 atlan kernel: hdc: lost interrupt
Nov 20 14:35:15 atlan kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Nov 20 14:35:15 atlan kernel: hdc: lost interrupt
^@^@^@^@^@^@Nov 20 19:17:25 atlan syslogd 1.3-3: restart (remote reception).
Nov 20 19:17:25 atlan kernel: klogd 1.3-3, log source = /proc/kmsg started.
Nov 20 19:17:25 atlan kernel: Inspecting /boot/System.map-2.4.7-int-ac3
[...]
Nov 20 19:17:26 atlan kernel: Linux version 2.4.7-int-ac3 (root@atlan.doerges.net) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 Wed Aug 1 01:54:15 CEST 2001
[...]
--- snap ---

This was 2.4.7-ac3 compiled w/ an earlier version of gcc
(2.96-85). And in deed, my problem was sometimes accompanied by a
'kernel: hdc: lost interrupt'. But this seems to have gone, because I
removed one disk from the system and moved hdc -> hda.

That there's such a long period between these two occurences, doesn't
mean, that my machine did not hang in the meantime, but I did not find
anything in the logs. Perhaps the messages didn't make it through?

Bye -- Till
