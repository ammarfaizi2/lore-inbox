Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291384AbSAaWxG>; Thu, 31 Jan 2002 17:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291385AbSAaWw4>; Thu, 31 Jan 2002 17:52:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31763 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291384AbSAaWwr>; Thu, 31 Jan 2002 17:52:47 -0500
Message-ID: <3C59CAB0.1020400@zytor.com>
Date: Thu, 31 Jan 2002 14:52:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <m1r8o7ayo3.fsf@frodo.biederman.org>	<3C58DD2E.10106@zytor.com> <m1n0yvaucy.fsf@frodo.biederman.org>	<3C598585.4090004@zytor.com> <m1it9itaiy.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> First it isn't an immediate problem because with an ELF image you
> don't need a multistage bootloader.  I can represent everything in one
> file.  Essentially a sparse coredump.
> 


For what definition of "everything"?  I'm not being facetious, I think
it's a fundamentally impossible statement to make, especially if the
bootloader is interactive.


> If you are writing an intermediate loader it is a problem.  An
> intermediate loader needs OS services, and if you don't have those
> services you are in trouble.  For this purpose it is fair to call the
> x86 BIOS,  EFI, the SRM, and open firmware OS's. 
> 
> Personally when I want an OS I would like to use Linux.  So I have
> written a patch that allows me too load another OS from Linux, so in
> those cases when I am writing an intermediate boot loader I can use
> Linux.  I admit I haven't gracefully solved all of the bootstrapping
> cases but that is just a matter of time.


Your intermediate Linux still needs to have all its devices.  I was
working for a while on a project to create an "intermediate Linux" which
wouldn't claim to own the world but instead callback to the firmware; this
would be a port of Linux to a sort of pseudo-architecture.  I got a bit
too busy, but I think it's a valid program.


>>That's the thing with PXE and the BIOS too, for that matter: they might be specs
>>done by monkeys, but when it really counts, what you need is really there
>>(modulo bugs, but that applies to everything.)
> 
> Except PXE isn't always there.  In fact PXE is usually absent.  If it
> was always there on x86 this would be a good argument.  For those
> cases when I can't get firmware to do my network booting I put the
> Linux kernel on a floppy or a cd or whatever the firmware can boot off
> of and network boot with that.  


PXE is there on the vast majority of all modern (1999 or later) network
cards.  Those that aren't either have a socket or don't have any
provisions for network firmware whatsoever, as a rule.


> I do agree that having specs even when done by monkeys are good when
> they are widely implemented.  
> 
> But I see no reason why the open source community shouldn't drive the
> specs.


We could have, but we didn't.  I DO NOT want to launch a competing spec.

> We have as much right as Intel or any other self appointed
> commitie.  And open source is a great tool for providing defacto
> implementations. 


Yes, but we're several years too late.  PXE is the accepted spec, for as
much as it sucks (to its defense, the latest version of the PXE spec
actually does most of what you want it to be able to do, although few if
any commercial PXE specs implement these correctly to my experience.

I would *LOVE* to see a high-quality Open Source PXE implementation, for
several reasons:

a) To support older, socket-carrying network cards;
b) To put on a floppy or flash into your network ROM if your commercial
PXE firmware is too broken to live.


> And I have been doing this for over a year in production on thousands
> of machines so I do know that PXE is by no means necessary.  


There are a lot of things that are "by no means necessary" if you look at
any one individual user.

It's fundamentally about creating pervasive interfaces.  My problem with
several of your proposals is that they make well-established interfaces
*less* pervasisve, which is a huge step in the wrong direction.

	-hpa



