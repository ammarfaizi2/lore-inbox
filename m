Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313637AbSDPIn7>; Tue, 16 Apr 2002 04:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313639AbSDPIn6>; Tue, 16 Apr 2002 04:43:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:47488 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313637AbSDPIn5>;
	Tue, 16 Apr 2002 04:43:57 -0400
Date: Tue, 16 Apr 2002 10:43:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416104350.A32517@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBCD31.4090105@evision-ventures.com> <20020416103001.A32435@ucw.cz> <3CBBD3AC.2080301@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:33:00AM +0200, Martin Dalecki wrote:
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

If this is kept, then OK.

> 
> And indeed as you show - there was confusion about this issue
> throughout the whole driver, since the taskfile_in(out)
> functions where basically just the byteswapped variants and
> where not uses consistently.

-- 
Vojtech Pavlik
SuSE Labs
