Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVDEMWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDEMWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVDEMWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:22:52 -0400
Received: from alog0251.analogic.com ([208.224.222.27]:49866 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261711AbVDEMWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:22:38 -0400
Date: Tue, 5 Apr 2005 08:18:50 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Renate Meijer <kleuske@xs4all.nl>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>, Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, Dag Arne Osvik <da@osvik.no>
Subject: Re: Use of C99 int types
In-Reply-To: <62f8215dd556d5a50b307f5b6d4f578b@mac.com>
Message-ID: <Pine.LNX.4.61.0504050803590.15387@chaos.analogic.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au>
 <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl>
 <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com>
 <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no>
 <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com>
 <62f8215dd556d5a50b307f5b6d4f578b@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Kyle Moffett wrote:

> On Apr 04, 2005, at 17:25, Richard B. Johnson wrote:
>> I don't find stdint.h in the kernel source (up to 2.6.11). Is this
>> going to be a new addition?
>
> Uhh, no.  stdint.h is part of glibc, not the kernel.
>
>> It would be very helpful to start using the uint(8,16,32,64)_t types
>> because they are self-evident, a lot more than size_t or, my favorite
>> wchar_t.
>
> You miss the point of size_t and ssize_t/ptrdiff_t.  They are types
> guaranteed to be at least as big as the pointer size.  uint8/16/32/64,
> on the other hand, are specific bit-sizes, which may not be as fast or
> correct as a simple size_t.  Linus has pointed out that while it
> doesn't matter which of __u32, u32, uint32_t, etc you use for kernel
> private interfaces, you *cannot* use anything other than __u32 in the
> parts of headers that userspace will see, because __u32 is defined
> only by the kernel and so there is no risk for conflicts, as opposed
> to uint32_t, which is also defined by libc, resulting in collisions
> in naming.
>
> Cheers,
> Kyle Moffett
>

Actually not. I think the whole point of the C99 (POSIX integer)
types is to avoid problems like you cite. Nobody should be using
types that begin with an underscore in user-code anyway. That
name-space is reserved.

One cannot just use 'int' or 'long', in particular when interfacing
with an operating system. For example, look at the socket interface
code. Parameters are put into an array of longs and a pointer to
this array is passed to the socket interface. It's a mess when
converting this code to 64-bit world. If originally one used a
structure of the correct POSIX integer types, and a pointer to
the structure was passed, then absolutely nothing in the source-
code would have to be changed at all when compiling that interface
for a 64-bit machine. The continual short-cuts, with the continual
"special-case" hacks is what makes porting difficult. That's what
the POSIX types was supposed to help prevent.

That's why I think if there was a stdint.h file in the kernel, when
people were performing maintenance or porting their code, they
could start using those types.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
