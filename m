Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRIHNOC>; Sat, 8 Sep 2001 09:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRIHNNn>; Sat, 8 Sep 2001 09:13:43 -0400
Received: from [216.81.19.22] ([216.81.19.22]:272 "EHLO black.pepper")
	by vger.kernel.org with ESMTP id <S269421AbRIHNNi>;
	Sat, 8 Sep 2001 09:13:38 -0400
Date: Sat, 8 Sep 2001 08:14:51 -0500 (CST)
From: Daryl F <wyatt@escape.ca>
To: Raghav <f1997527@bits-pilani.ac.in>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Modules for IBM ISA EtherJet Cards for RH 7.1 (fwd)
In-Reply-To: <Pine.LNX.4.33.0109080952130.10745-100000@prithvi.bits-pilani.ac.in>
Message-ID: <Pine.LNX.4.32.0109080807130.406-100000@black.pepper>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that the cards are set up in PNP mode if they've been used
with Windows. You will need the DOS-based utility LANAIDC to change them
out of PNP mode to manual mode. You can find a link to the utility at
http://www.pc.ibm.com/qtechinfo/MIGR-4GJRG5.html. It is called a "LANAID
installation diskette".

The cs89x0 module defaults the I/O port and other configuration options
but you will have to look at the source to find the defaults. Or
optionally you can set the options the module uses. I use in my
/etc/alias.conf:

	alias eth1 cs89x0
	options eth1 io=0x300 irq=5

And I specifically set the port and irq on the card using LANAIDC after
booting DOS. This only needs to be done once, then the card remains that
way until you use LANAIDC again.

Of course you must ensure that whatever irq you use is available by
looking at /proc/interrupts. And eth1 may need to be eth0 if it is the
first or only ethernet card in the box.

HTH,
Daryl

On Sat, 8 Sep 2001, Raghav wrote:

> Hi,
> I run RH 7.1 and on installation Kudzu detected a IBM ISA ETHERJET as my
> NIC card. But couldnt locate module for it. I found cs89x0 as a match but
> on loading reported that the io or the irq was wrong and no device was
> found on that adrs.
>
> Now how do I rectify this and install this module. Its our intranet Server
> and has to networked ASAP. Reply me ASAP..
>
> Raghavan T V
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

