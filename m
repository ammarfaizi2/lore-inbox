Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVDEL2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVDEL2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVDEL2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:28:37 -0400
Received: from smtpout.mac.com ([17.250.248.44]:52458 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261691AbVDEL2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:28:32 -0400
In-Reply-To: <d5803044b1c7dcc631eda71863d44fa2@xs4all.nl>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com> <62f8215dd556d5a50b307f5b6d4f578b@mac.com> <d5803044b1c7dcc631eda71863d44fa2@xs4all.nl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2a171644af3ab214c5bc612eecc9167@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
       Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-os@analogic.com,
       Dag Arne Osvik <da@osvik.no>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Use of C99 int types
Date: Tue, 5 Apr 2005 07:27:49 -0400
To: Renate Meijer <kleuske@xs4all.nl>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 05, 2005, at 05:23, Renate Meijer wrote:
>> uint8/16/32/64, on the other hand, are specific bit-sizes, which
>> may not be as fast or correct as a simple size_t.
>
> Using specific widths may yield benefits on one platform, whilst
> proving a real bottleneck when porting something to another. A
> potential of problems easily avoided by using plain-vanilla
> integers.

The point of specific-width integers is to preserve a specific
binary format, such as a filesystem on-disk data structure, or a
kernel-userspace ABI, etc.  If you just need a number, use a
different type.

> Strictly speaking, a definition starting with a double
> underscore is reserved for use by the compiler and associated
> libs

Well, _strictly_speaking_, it's "implementation defined", where the
"implementation" includes the kernel (due to the syscall interface).

> this such a declaration would invade implementation namespace.
> The compilers implementation, that is.

But the C library is implicitly dependent on the kernel headers for
a wide variety of datatypes.

> In this case, the boundary is a bit vague, i see that, since a lot
> of header definitions also reside in the /usr/include hierarchy.

Some of which are produced by kernel sources: /usr/include/linux,
/usr/include/asm, etc.

> I think it would be usefull to at least *agree* on a standard type
> for 8/16/32/64-bit integer types. What I see now as a result of
> grepping for 'uint32' is a lot more confusing than stdint.h

Well, Linus has supported that there is no standard, except where
ABI is concerned, there we must use __u32 so that it does not clash
with libc or user programs.

> Especially the types with leading underscores look cool, but in
> reality may cause a conflict with compiler internals and should only
> be used when defining compiler libraries.

It's "implementation" (kernel+libc+gcc) defined.  It just means that
gcc, the kernel, and libc have to be much more careful not to tread
on each others toes.

> The '__' have explicitly been put in by ISO in order to avoid
> conflicts between user-code and the standard libraries,

The "standard libraries" includes the syscall interface here.  If
the kernel types could not be prefixed with __, then what _should_
we prefix them with?

> Furthermore, I think it's wise to convince the community that if
> not needed, integers should not be specified by any specific width.

That doesn't work for an ABI.  If you switch compilers (or from 32-bit
to 64-bit like from x86 to x86-64, you _must_ be able to specify
certain widths for all the ABI numbers to preserve compatibility.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


