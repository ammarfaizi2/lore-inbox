Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTGMLRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270221AbTGMLRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:17:25 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:21431
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S270219AbTGMLRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:17:23 -0400
Subject: Re: Kernel 2.4 problem with 3C905B NIC
From: Edward Tandi <ed@efix.biz>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1057256675.8992.37.camel@wires.home.biz>
References: <1057256675.8992.37.camel@wires.home.biz>
Content-Type: text/plain
Message-Id: <1058095963.6144.47.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Jul 2003 12:32:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update for those interested (and for the archive).

After some further diagnostics and discussion with some net driver
experts/maintainers, it turns out that this problem can be triggered by
settings in the card's EEPROM settings. It is still unclear to me
whether these settings directly affect the hardware, or whether they are
for interpretation only by the driver software.

I was able to get the 3C90B working with the 3c59x driver by downloading
3com's card configuration utility, contained with a self-extracting
archive at:

ftp://ftp.3com.com/pub/nic/3c90x/3c90x2.exe

The utility is called '3c90xcfg.exe', which runs in DOS command mode.
All you need to do is hit the 'auto-configure' box and it sets the
EEPROM settings according to whatever you have the card connected to. In
my case, it changed only one parameter -it cleared the full-duplex bit.

These settings can be adjusted manually in Linux using vortex-diag, but
I did not find it to be an easy user-facing tool, for the purpose of
just getting your card configured right.

After re-boot, the 3c59x drivers _just_work_ without any module
parameters. Of course, one has to ask how the EEPROM got into an
unusable state in the first place. My current speculation is that in a
previous life, the card may have been tweaked from Windows using a 3com
tuning tool.

There is still the issue of why the 3c90x drivers worked in a situation
where the 3c59x drivers failed. I still think there is room for
improving the driver, although my gut feel judging from the feedback
given by various maintainers, is that it probably won't happen any time
soon.

I did also suggest updating the kernel documentation (vortex.txt)
suggesting that if people are having problems with the card, they should
run this 3com utility.

Ed-T.


On Thu, 2003-07-03 at 19:24, Edward Tandi wrote:
> I am currently using kernels 2.4.21-rc1 and 2.4.22-pre2.
> 
> I think there is a problem with the 3c59x module. Between two machines
> lies a D-Link 100Base-TX Fast Ethernet Hub and a Netgear DS104 switch. I
> think the D-Link has only half-duplex capability.
> 
> NICs at both ends initialise in 100Mbit mode.
> 
> What happens is that during large transfers, there are a very large
> number of collisions on the network. This results in the transfer rate
> slowing down to somewhere between 3KB-7KB per second.
> 
> Googling shows that there have been a number of problems in the past
> regarding Linux and the 3C905B. History indicates that card appears to
> work on Windows machines but have serious performance problems under
> Linux in certain circumstances.
> 
> I have tried the various duplex module options and nothing helps. In
> fact long transfers appear to trigger a Tulip lockup at the other end.
> 
> For those suffering, I have found a temporary work-around. Build the
> driver (3c90x-102.tar.gz) at:
> 
> http://support.3com.com/infodeli/tools/nic/linuxdownload.htm
> 
> Despite all the compilation warnings, all works well! Transfer speeds
> have increased to between 7MB-9MB per second, which is what I would
> expect it to be.
> 
> The 3com site says that the driver is unsupported. Pity. Is there a
> maintainer for the 3c59x module? The last entry in 3c59x.c was by akpm
> July 2001. I presume this issues has been around for a while.

