Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313654AbSDPJVc>; Tue, 16 Apr 2002 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313657AbSDPJVb>; Tue, 16 Apr 2002 05:21:31 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:34286 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313654AbSDPJV3>; Tue, 16 Apr 2002 05:21:29 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 16 Apr 2002 02:19:26 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <3CBBD3AC.2080301@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0204160215570.389-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The common thing I use byteswap for is to mount my tivo (kernel 2.1.x)
drives on my PC (2.4/5.x).  those drives are byteswapped throughout the
entire drive, including the partition table.

It sounds as if you are removing this capability, am I misunderstaning you
or is there some other way to do this? (and duplicating the drive to use
dd to byteswap is not practical for 100G+)

David Lang

 On Tue, 16 Apr 2002, Martin Dalecki wrote:

> Vojtech Pavlik wrote:
> > On Tue, Apr 16, 2002 at 09:05:21AM +0200, Martin Dalecki wrote:
> >
> >>Tue Apr 16 01:02:47 CEST 2002 ide-clean-36
> >>
> >>- Consolidate ide_choose_drive() and choose_drive() in to one function.
> >>
> >>- Remove sector data byteswpapping support. Byte-swapping the data is supported
> >>   on the file-system level where applicable.  Byte-swapped interfaces are
> >>   supported on a lower level anyway. And finally it was used inconsistently.
> >
> >
> > Are you sure about this? I think file systems support LE/BE, but not
> > byteswapping because of IDE being LE on a BE system.
>
> I'm sure about this. For the following reasons:
>
> 1. The removed functionality affected only sector data transfers.
>
> 2. The following code for interfaces with byte swapped BUS setups
>     still remains intact:
>
> #if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
> 	if (MACH_IS_ATARI || MACH_IS_Q40) {
> 		/* Atari has a byte-swapped IDE interface */
> 		insw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
> 		return;
> 	}
> #endif
>
> And indeed as you show - there was confusion about this issue
> throughout the whole driver, since the taskfile_in(out)
> functions where basically just the byteswapped variants and
> where not uses consistently.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
