Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315842AbSEGOnk>; Tue, 7 May 2002 10:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315845AbSEGOnj>; Tue, 7 May 2002 10:43:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16653 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315842AbSEGOni>; Tue, 7 May 2002 10:43:38 -0400
Message-ID: <3CD7D95C.6070207@evision-ventures.com>
Date: Tue, 07 May 2002 15:40:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.13 IDE 54
In-Reply-To: <3CD7C360.6050002@evision-ventures.com> <20020507144027.11544@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik benh@kernel.crashing.org napisa?:
>>OK I see I have "forced" you to take care of this.
>>My problem previously was the simple fact that in esp.
>>the pmac code was sidestepping the generic code and providing his
>>own mechanisms for handling chipset specific dma transfer methods.
>>
>>As you can see now it's possible to have overloaded most
>>of the "virtuaized" udma_xxx channel methods.
>>
>>Now you request me to virtualize the udma_enable stuff.
>>Nothing easier then this.
> 
> 
> I haven't looked closely at your new stuff yet, but here's what
> we need for ide-pmac (and similarily, on a whole bunch of embedded
> IDE controllers that do not behave like a legacy controller).
> 
>  - hook on enabling/disabling DMA & setting up timing stuffs. Due to
>    some weird HW, we must be in control of the actual sending of the
>    feature setting command to the drive
>  - hook on creating/disposing the DMA related data structures (lists
>    etc...)
>  - hook on setting up the DMA SG list as PRDs are really only
>    specific to the legacy PCI controllers, we deal with all sort
>    of different DMA controllers here in the outside world ;)
>  - hook on starting the DMA transfer
>  - hook on stopping the DMA transfer
>  - hook on knowing if the DMA is done and/or letting it drain
>    completely upon reception of the last interrupt.

Alomst all of them done ;-). Please take a look at the end of
ide-dma.c

> 
> Ideally, in order to properly deal with some HW details, the hook on
> starting the DMA transfer should also be the one ultimately issuing
> the command to the taskfile register, as depending on the HW, it may
> have to be done either prior or after starting the DMA channel.
> 
> So instead of having a ton of hook, I'd rather see all of this be
> properly abstracted by default, the legacy IDE beeing only one
> of the possible set of callbacks, instead of having the default code
> in ide.c with hooks for different chipsets.

This is presisely where the "default" code from the
"virtualizations" found in ide-dma.c is going to go, after
some restabilizing of the interface.

So I think we are at least "mentally" in sync.

