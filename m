Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVHLSCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVHLSCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVHLSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:02:39 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:46477 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750810AbVHLSCi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rhIzQGJs8ikGwhhhSTI8W1JHQ/FxqhVZxXzH3ANa5ZwE85hLxtB/AHuNLirmfJh85tMz6QqGZ3uB0fHYpLrlQQu7S4KKbWaXxMc9dYLJqNSZ0SdaAy4JNWOZq0nEv/TdxfZgmaGkmHafI1kpsbFg9WfY+pVNwUJ5xiXGiq4n/gw=
Message-ID: <86802c4405081211021e76349c@mail.gmail.com>
Date: Fri, 12 Aug 2005 11:02:37 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
Subject: Re: Atyfb questions and issues
Cc: Jim Ramsay <jim.ramsay@gmail.com>, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4789af9e050812101110d3642d@mail.gmail.com>
	 <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I played a while with atyfb in LinuxBIOS. move the xl_init.c into LinuxBIOS.

there is one patch call xlinit.c that can be used even ati fb is not
inited in BIOS to make kernel still can use atyfb.

I wonder if James put that in mainstream, he already sent one patch
for 2.6.5....

please refer to 
http://www.linuxbios.org/pipermail/linuxbios/2004-May/007734.html

I guess the mips fw already execute the ati option rom via x86 emulator...

YH

On 8/12/05, Daniël Mantione <daniel@deadlock.et.tudelft.nl> wrote:
> 
> 
> Op Fri, 12 Aug 2005, schreef Jim Ramsay:
> 
> > I have the following issue.  I am trying to get an ATI Rage XL chip
> > working on a MIPS-based processor, with a 2.6.11-based kernel from
> > linux-mips.org.  Now, I know that this was working with a 2.4.25-based
> > kernel previously.
> 
> Okay, the 2.4 driver is more intrusive, it programs the chip from start as
> much as possible, while the 2.6 driver tries to depend on Bios settings. I
> haven't checked out the 2.6 driver enough to see if it is still possible
> to program from scratch.
> 
> > I seem to get intermittent strange issues, such as the machine
> > freezing from time to time, but in general I get the following in my
> > dmesg when I load the atyfb module:
> >
> > atyfb: using auxiliary register aperture
> > atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
> > atyfb(aty_valid_pll_ct): pllvclk=50 MHz, vclk=25 MHz
> > atyfb(aty_dsp_gt): dsp_config 0x307c0001, dsp_on_off 0x14fffff0
> > < Sometimes it will hang here >
> > atyfb: 512K RESV, 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
> > atyfb: Unsupported xclk source:  7.
> 
> > I'm assuming that most of my issues are due to the "Unsupported xclk
> > source" message.  Any ideas what I can do about this, or where I can
> > go to learn more about how to make this thing work?
> 
> Yes, according to my register data sheet a 7 means the memory clock
> frequency is derived from DLLCLK. Unfortunately I don't know what this
> DLLCLK is. I think it means the chip isn't properly initialized yet and it
> clocks the memory from a safe clock source to allow the computer to start.
> 
> However, we most likely have no way to find out the speed of this DLLCLK.
> 
> The memory clock frequency is important for the driver to be able to set a
> display mode; it needs to program a memory reload frequency into the chip
> which depends on the memory frequency.
> 
> Daniël
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
