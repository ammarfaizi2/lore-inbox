Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293503AbSBZLN4>; Tue, 26 Feb 2002 06:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293574AbSBZLNr>; Tue, 26 Feb 2002 06:13:47 -0500
Received: from [195.63.194.11] ([195.63.194.11]:51471 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292178AbSBZLN2>; Tue, 26 Feb 2002 06:13:28 -0500
Message-ID: <3C7B6DAE.1090809@evision-ventures.com>
Date: Tue, 26 Feb 2002 12:12:46 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
In-Reply-To: <20020226032629.A930@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> There wasn't a specific MAINTAINER for this stuff, other than perhaps
> Andre Hedrick by proxy, so I decided it might be best to post this
> directly.
> 
> I have a lot of ServerWorks OSB4 IDE hardware, which has the annoyingly
> suboptimal behavior of corrupting filesystems when DMA is active.
> Unfortunately, serverworks.c (in recent 2.4, at least) does not honor
> the CONFIG_IDEDMA_AUTO config option -- it turns dma on only unless
> "ide=nodma" is set on the kernel command line.
> 
> Personally, I think the correct behavior is for the subdrivers to honor
> this config value.  However, only VIA behaves in this way, and PIIX only
> because of its funky CONFIG_PIIX_TUNING config.  This obviates having to
> modify lilo.conf (or similar) on all machines, and having to remember
> to do so, etc etc.
> 
> The alternative is that, somewhat unintuitively, the correct behavior is
> for the subdrivers to make their own non-CONFIGurable decisions on DMA.
> In this case, VIA and PIIX should be corrected, I would think.
> 
> In any case, I've appended the patch I'm using to be able to turn off
> auto-DMA at config-time rather than run-time for ServerWorks.  One
> alternative is to shed this code altogether, since ide-pci.c seems to
> set a rational default.

I think (not 100% becouse not re-checked against the code),
you could just have removed the lines

if (!noautodma)
	hwif->autodma = 1;

and all should be well ;-).


