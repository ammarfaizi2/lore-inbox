Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVDDVw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVDDVw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVDDVvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:51:45 -0400
Received: from smtpout.mac.com ([17.250.248.87]:3571 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261400AbVDDVuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:50:09 -0400
In-Reply-To: <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <62f8215dd556d5a50b307f5b6d4f578b@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Renate Meijer <kleuske@xs4all.nl>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
       Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, Dag Arne Osvik <da@osvik.no>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Use of C99 int types
Date: Mon, 4 Apr 2005 17:49:26 -0400
To: linux-os@analogic.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 04, 2005, at 17:25, Richard B. Johnson wrote:
> I don't find stdint.h in the kernel source (up to 2.6.11). Is this
> going to be a new addition?

Uhh, no.  stdint.h is part of glibc, not the kernel.

> It would be very helpful to start using the uint(8,16,32,64)_t types
> because they are self-evident, a lot more than size_t or, my favorite
> wchar_t.

You miss the point of size_t and ssize_t/ptrdiff_t.  They are types
guaranteed to be at least as big as the pointer size.  uint8/16/32/64,
on the other hand, are specific bit-sizes, which may not be as fast or
correct as a simple size_t.  Linus has pointed out that while it
doesn't matter which of __u32, u32, uint32_t, etc you use for kernel
private interfaces, you *cannot* use anything other than __u32 in the
parts of headers that userspace will see, because __u32 is defined
only by the kernel and so there is no risk for conflicts, as opposed
to uint32_t, which is also defined by libc, resulting in collisions
in naming.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


