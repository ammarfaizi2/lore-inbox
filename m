Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268906AbRHLBVb>; Sat, 11 Aug 2001 21:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268909AbRHLBVV>; Sat, 11 Aug 2001 21:21:21 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19727 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268908AbRHLBVP>;
	Sat, 11 Aug 2001 21:21:15 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sat, 11 Aug 2001 15:02:55 MST."
             <20010811150255.G4657@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 11:21:22 +1000
Message-ID: <4736.997579282@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 15:02:55 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:
>
>> Changes from Release 1.
>[snip]
>>   Document kbuild targets and C to assembler conversions.  As always,
>>   Documentation/kbuild/kbuild-2.5.txt is your friend.
>
>Okay, I've played with this a bit on PPC, and got it working to boot :)
>Now here's what I see as the slight problems with it.  At least on PPC
>what we do is generate the offset bits, and then have another file,
>arch/ppc/kernel/ppc_asm.h include that file and have some other useful
>macros for .S files.  So any of the .S files which include ppc_asm.h
>would need an additional
>extra_aflags(foo.o $(src_includelist /arch/$(ARCH)))

That will be required for all asm code that includes offsets.h, on all
architectures, I doubt there will be more than 10 on any arch.

The alternative of having code in some arch directory updating
include/asm-$(ARCH)/offsets.h is worse.  It is a terrible design to
have code in one makefile updating files in another directory.  It is a
layer violation which is always a bad idea.

