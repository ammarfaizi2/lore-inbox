Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFTJ4R>; Thu, 20 Jun 2002 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSFTJ4Q>; Thu, 20 Jun 2002 05:56:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1546 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313125AbSFTJ4O> convert rfc822-to-8bit;
	Thu, 20 Jun 2002 05:56:14 -0400
Message-ID: <3D11A6BB.8030705@evision-ventures.com>
Date: Thu, 20 Jun 2002 11:56:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE booting problems with 2.5.23
References: <16471.1024566396@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik David Howells napisa³:
> Hi Martin,
> 
> I'm having problems booting a 2.5.23 kernel on my test box (SMP). It hangs on
> trying to recalibrate the IDE interface. I've attached the output captured
> from the serial console. I've also attached the config file.
> 
> Note that trying the following doesn't help:
> 
> 	(*) Turning on and off "Use PCI DMA by default when available".
> 	(*) Specifying "hda=dma" on the kernel command line
> 	(*) Specifying "hda=935,128,63" on the kernel command line
> 
> Can you suggest a fix please?

Well... IDE 92 falls in to the "brown paper bag" cathegory.
Even the supposedly better error recovery code
there is wrong, since it can schedule from IRQ context.
So please reverse apply it. It should help.

I have a theory that I schould in no case write code above
25 deg Celsius and this is just confirming it... :-).

Sorry for the inconvenience, but I thry now to slow a bit
down on the amount of changes and to focus on stabilizing again.

BTW> Jens did you notice that the IDE_DMA flag is a "read only"
flag? I see basically only TQC code checking it. I would
like to replace the drive->waiting_for_dma flag field by the
proper usage of the IDE_DMA bit. Any way this could bite TCQ code?
The checks there appear to be only sanity checks anyway.

