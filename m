Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313634AbSDPIfM>; Tue, 16 Apr 2002 04:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313635AbSDPIfL>; Tue, 16 Apr 2002 04:35:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17159 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313634AbSDPIfL>; Tue, 16 Apr 2002 04:35:11 -0400
Message-ID: <3CBBD3AC.2080301@evision-ventures.com>
Date: Tue, 16 Apr 2002 09:33:00 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBCD31.4090105@evision-ventures.com> <20020416103001.A32435@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Apr 16, 2002 at 09:05:21AM +0200, Martin Dalecki wrote:
> 
>>Tue Apr 16 01:02:47 CEST 2002 ide-clean-36
>>
>>- Consolidate ide_choose_drive() and choose_drive() in to one function.
>>
>>- Remove sector data byteswpapping support. Byte-swapping the data is supported
>>   on the file-system level where applicable.  Byte-swapped interfaces are
>>   supported on a lower level anyway. And finally it was used inconsistently.
> 
> 
> Are you sure about this? I think file systems support LE/BE, but not
> byteswapping because of IDE being LE on a BE system.

I'm sure about this. For the following reasons:

1. The removed functionality affected only sector data transfers.

2. The following code for interfaces with byte swapped BUS setups
    still remains intact:

#if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
	if (MACH_IS_ATARI || MACH_IS_Q40) {
		/* Atari has a byte-swapped IDE interface */
		insw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
		return;
	}
#endif

And indeed as you show - there was confusion about this issue
throughout the whole driver, since the taskfile_in(out)
functions where basically just the byteswapped variants and
where not uses consistently.

