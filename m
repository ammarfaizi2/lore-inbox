Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVDEJUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVDEJUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDEJUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:20:45 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:42000 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S261646AbVDEJR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:17:28 -0400
In-Reply-To: <62f8215dd556d5a50b307f5b6d4f578b@mac.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com> <62f8215dd556d5a50b307f5b6d4f578b@mac.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d5803044b1c7dcc631eda71863d44fa2@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
       Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-os@analogic.com,
       Dag Arne Osvik <da@osvik.no>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: Use of C99 int types
Date: Tue, 5 Apr 2005 11:23:07 +0200
To: Kyle Moffett <mrmacman_g4@mac.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2005, at 11:49 PM, Kyle Moffett wrote:

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
> guaranteed to be at least as big as the pointer size.

IIRC, It is guaranteed that size_t can correctly represent the largest 
object which
can be malloced. This usually coincides with the width of a pointer, 
but not
neccesarily.

> uint8/16/32/64,
> on the other hand, are specific bit-sizes, which may not be as fast or
> correct as a simple size_t.

Using specific widths may yield benefits on one platform, whilst 
proving a real
bottleneck when porting something to another. A potential of problems 
easily
avoided by using plain-vanilla integers.

> Linus has pointed out that while it
> doesn't matter which of __u32, u32, uint32_t, etc you use for kernel
> private interfaces, you *cannot* use anything other than __u32 in the
> parts of headers that userspace will see, because __u32 is defined
> only by the kernel and so there is no risk for conflicts, as opposed
> to uint32_t, which is also defined by libc, resulting in collisions
> in naming.

Strictly speaking, a definition starting with a double underscore is 
reserved for use
by the compiler and associated libs, this such a declaration would 
invade implementation
namespace. The compilers implementation, that is.

In this case, the boundary is a bit vague, i see that, since a lot of 
header definitions also reside
in the /usr/include hierarchy.

I think it would be usefull to at least *agree* on a standard type for 
8/16/32/64-bit integer types. What
I see now as a result of grepping for 'uint32' is a lot more confusing 
than stdint.h

There is u32, __u32, uint32, uint32_t, __uint32_t...

Especially the types with leading underscores look cool, but in reality 
may cause a conflict with compiler
internals and should only be used when defining compiler libraries. The 
'__' have explicitly been put in by
ISO in order to avoid conflicts between user-code and the standard 
libraries, so if non-compiler-library code also starts using '__', just 
coz it looks cool, that cunning plan is undone.

Furthermore, I think it's wise to convince the community that if not 
needed, integers should not be specified
by any specific width.

Regards,

Renate Meijer.

