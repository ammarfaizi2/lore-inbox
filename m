Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129173AbRBAAry>; Wed, 31 Jan 2001 19:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbRBAAro>; Wed, 31 Jan 2001 19:47:44 -0500
Received: from winds.org ([207.48.83.9]:17676 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129173AbRBAArL>;
	Wed, 31 Jan 2001 19:47:11 -0500
Date: Wed, 31 Jan 2001 19:46:31 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: safemode <safemode@voicenet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <3A78945F.C82E7CAF@voicenet.com>
Message-ID: <Pine.LNX.4.21.0101311937380.21983-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, safemode wrote:

> yea i know. . same mode       i also had a big problem with DMA timeouts on
> 2.4 so  .. i dont know what's up with 2.4 and my motherboard ...    2.2
> hasn't shown a single irq or DMA error yet since going back to it.
> currently 2.2.19-pre7 is using UDMA4     i just flashed the bios today so ..
> hopefully that should have fixed any problems.  I get 24MB/s each according
> to hdparm -t   on my hdd's and both are on the same channel.   This is much
> better than i ever got with 2.4 even when only one drive was on a channel.
> Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.
> my nbench performance under 2.2 is comparable to results for 1Ghz t-bird's so
> i'm happy with 2.2.  The only thing that would make me want to upgrade would
> be latency patches.  I'm convinced 2.4 has performance issues so i guess i'll
> be using 2.2 until 2.5 begins.      Is it really only 1 or 2 people having
> this Via corruption problem?   i doubt it's a bios problem because wouldn't
> 2.2 be effected by a bios bug if 2.4 is?   In either case the changelogs dont
> show any  fixes for it.

If your FSB is running at 114 MHz, you should try the kernel parameter
idebus=37 to get DMA working correctly. Otherwise you'll see an ide-reset error
on bootup because the instructions are too fast. The VIA driver on 2.2 doesn't
correctly program the PCI card, so you don't see weird behavior running 2.2
with a faster PCI clock.

(Note: 1.14 * 33 = 37.6 PCI Clk)

It also matters what motherboard you're using, and if it can support speeds up
past 100. If you're serious about overclocking, buy one of the new KT133A
boards that support speeds up to 133 (or an average overclocked 145 limit).

For instance, my Epox KX133 board is unstable at anything above 110 FSB, but
I've seen the Abit KT7 go as high as 116. You should also have some good
memory that is rated for 150MHz, otherwise you're just asking for trouble.

As always, if you have problems with the kernel and want to submit a bug
report, please put all the settings back to normal and test thoroughly before
continuing. It's funny how many bug reports I've heard from people who've
overclocked their FSB and expected the IDE DMA to be set appropriately under
2.4... maybe this should be mentioned somewhere in ide.txt, even though
overclocking is frowned upon.

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
