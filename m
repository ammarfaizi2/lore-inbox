Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313815AbSDQJl7>; Wed, 17 Apr 2002 05:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313819AbSDQJl6>; Wed, 17 Apr 2002 05:41:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:27396 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313815AbSDQJl5>; Wed, 17 Apr 2002 05:41:57 -0400
Message-ID: <3CBD34C1.8080904@evision-ventures.com>
Date: Wed, 17 Apr 2002 10:39:29 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
        vojtech@suse.cz, rgooch@ras.ucalgary.ca,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.GSO.4.21.0204171029040.1258-100000@vervain.sonytel.be> <20020417015550.11501@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> We tweak on pmac by feeding the IDE layer with our controller virtual address
> minus _IO_BASE (for non-PPC people, _IO_BASE is the virtual address of the
> main PCI IO space, all inx/outx are relative to this). The pointer arithmetic
> does the magic. It sucks, but works without redefining everything around.
> I haven't looked at the new IN_BYTE stuff, though if it is IDE specific,
> I'd rather see it called IDE_IN_BYTE. The current scheme sucks also because
> inx/outx, at least on PPC, are a lot slower than normal MMIO access (one
> reason beeing their ability to recovert from machine checks). It would be
> nice for IDE to use it's own accessors on MMIO platforms. This has to be
> a per-controller things though. A global macro is no good. You can (and on
> some configs, you do have on the motherboard) both MMIO mapped controllers
> and old-style IO mapped ones. One example is the B&W mac G3 which has both
> the Apple MMIO mapped mac-io IDE controller and the CMD646 on the PCI bus.
> 
> Also, when applying the taskfile, I suspect we don't need strong barriers as
> we do currently have, only on IO write barrier before actually writing the
> command byte. But I would gladly leave the whole issue of redefining barriers
> especially regarding IOs to Anton Blanchard ;)
> 
> Maybe the entire function for writing a taskfile register state to the
> controller should be made a hwif indirect call. (On Darwin, they more or
> less do that, along with a bitmask indicating which register has to be
> applied, though I suspect the tests against this bitmask would eats pretty
> much all of the benefit of removing the useless barriers).

Thank you for the elaborated explanation. I think that some
of your ideas presented here could be well pursued becouse they are
indeed good. :-).

