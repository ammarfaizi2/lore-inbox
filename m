Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVBVKO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVBVKO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 05:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVBVKO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 05:14:58 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:3559 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262263AbVBVKOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 05:14:34 -0500
Message-ID: <421B0606.9010000@ribosome.natur.cuni.cz>
Date: Tue, 22 Feb 2005 11:14:30 +0100
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050221
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: memory management weirdness
References: <4219E62D.7000009@ribosome.natur.cuni.cz> <m14qg5mq5v.fsf@muc.de> <20050222080431.GB778@elte.hu>
In-Reply-To: <20050222080431.GB778@elte.hu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andi Kleen <ak@muc.de> wrote:
> 
> 
>>>  Although I've not re-tested this today again, it used to help a bit to specify
>>>mem=3548M to decrease memory used by linux (tested with AGP card plugged in, when
>>>bios reported 3556MB RAM only).
>>>
>>>  I found that removing the AGP based videoc card and using an old PCI based
>>>video card results in bios detecting 4072MB of RAM. But still, the machine was
>>>slow. I've tried to "cat >| /proc/mtrr" to alter the memory settings, but the
>>>result was only a partial speedup.
>>>
>>>  I'm not sure how to convince linux kernel to run fast again.
>>
>>It's most likely a MTRR problem. Play more with them.
> 
> 
> in particular, try to create two small tables in the same format: one
> showing the e820 memory map as reported in your kernel log, and one
> showing the mtrr areas. If there is any e820 area that is not write-back
> cached via the mtrr mappings then that's the problem. You can also use
> "mem=exactmap,..." to fix up the memory map that the BIOS provides to
> Linux. Slowdowns are very often such MTRR problems. (perhaps the kernel
> should report RAM areas that are not covered by MTRR write-back?)

I've just extracted the requested info from the files I've put on web.
Here it is:

                                               2.4.30-pre1-bk5    2.6.11-rc4-bk7
0000000000000000 - 000000000009fc00 (usable)       +                    +
000000000009fc00 - 00000000000a0000 (reserved)     +                    +
00000000000e8000 - 0000000000100000 (reserved)     +                    +
0000000000100000 - 00000000de330000 (usable)       +                    +
00000000de330000 - 00000000de340000 (ACPI data)    +                    +
00000000de340000 - 00000000de3f0000 (ACPI NVS)     +                    +
00000000de3f0000 - 00000000de400000 (reserved)     +                    +
00000000ffb80000 - 0000000100000000 (reserved)     +                    +
found SMP MP-table at 000ff780                     +                    +
hm, page 000ff000 reserved twice.                  +                    - ???
hm, page 00100000 reserved twice.                  +                    - ???
hm, page 000f1000 reserved twice.                  +                    - ???
hm, page 000f2000 reserved twice.                  +                    - ???




                                                                    2.4.30-pre1-bk5    2.6.11-rc4-bk7
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1       +                      +
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1       +                      +
reg02: base=0xc0000000 (3072MB), size= 256MB: write-back, count=1       +                      +
reg03: base=0xd0000000 (3328MB), size= 128MB: write-back, count=1       +                      +
reg04: base=0xd8000000 (3456MB), size=  64MB: write-back, count=1       +                      +
reg05: base=0xdc000000 (3520MB), size=  32MB: write-back, count=1       +                      +
reg06: base=0xfe800000 (4072MB), size=   4MB: write-combining, count=1  +                      - !!!
reg06: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1  +                      +
The 4MB area should be AGP aperture, as it was set in BIOS to 4MB only

The files on web contain concatened infor from dmes, iomem, interrupts, mtrr, lspci:
http://www.natur.cuni.cz/~mmokrejs/tmp/4MB/2.4.30-pre1-bk5
http://www.natur.cuni.cz/~mmokrejs/tmp/4MB/2.6.11-rc4-bk7


So, 2.6 kernel does not see AGP aperture area. What to do next? ;)
Martin
