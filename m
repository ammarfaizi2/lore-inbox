Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSHXIh1>; Sat, 24 Aug 2002 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSHXIh1>; Sat, 24 Aug 2002 04:37:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6664 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315416AbSHXIh0>; Sat, 24 Aug 2002 04:37:26 -0400
Date: Sat, 24 Aug 2002 09:41:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andre Hedrick <andre@linux-ide.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
        "'Padraig Brady'" <padraig.brady@corvil.com>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020824094125.A30109@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.10.10208222014450.13077-100000@master.linux-ide.org> <20020823114433.10784@192.168.4.1> <3D66E944.9080507@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 10:02:44PM -0400, Jeff Garzik wrote:
> Basically think about the consequences of trying to handle a completely 
> unknown state -- if you are going to attempt to handle this you would 
> need to check for data, not just the BSY bit.  And read the data into a 
> throwaway buffer, if there is data to be read, or write the data it's 
> expecting.
> 
> So it's not just the busy bit :)

I notice everyone decided to miss replying to my mail about PCMCIA
IDE devices, which will trip you up here.  Could it be because I've
identified a real problem here?

- You plug the IDE device in.
- Power gets applied.
- cardmgr loads ide_cs.
- cardmgr binds ide_cs, which registers with the IDE layer.

The above happens in 10s of milliseconds, well before the hard drive
platters have been spun up.  Meanwhile, as defined by the T13 specs,
the BSY bit can be set for up to 31 seconds.

You're saying "completely unknown state".  I say "T13 defines this
state extremely well, and defines what happens from the drives point
of view at the end of the power on reset sequence extremely well."

I also say that your implementation above is, in andrespeak, a "bad
host" because it doesn't follow the T13 power on reset sequence
properly.

And yes, people _do_ use PCMCIA IDE drives with Linux.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

