Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280700AbRKUCVP>; Tue, 20 Nov 2001 21:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280810AbRKUCVF>; Tue, 20 Nov 2001 21:21:05 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:23826 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280700AbRKUCUq>;
	Tue, 20 Nov 2001 21:20:46 -0500
Date: Wed, 21 Nov 2001 13:19:01 +1100
From: Anton Blanchard <anton@samba.org>
To: G?rard Roudier <groudier@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
Message-ID: <20011121131900.B13279@krispykreme>
In-Reply-To: <20011120170219.A10454@krispykreme> <20011120181131.F1961-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120181131.F1961-100000@gerard>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Linux/ppc64 looks strange invention to me. As you know IO base addresses
> are limited to 32 bit in PCI. And, btw, 32 bits seems to work just fine
> here as PPC is defined from the driver as using normal IO. But, IIRC, the
> strange Linux/PPC invention only supports MMIO. :-)

Since all PCI IO is memory mapped on ppc64, IO addresses end up > 32 bits.
Until recently we used to have an IO offset that we added to all accesses
which kept the driver visible IO addresses < 32 bits. (This is still the
case with ppc32)

The change was made to support error handling, the 64 bit token has the
pci bus,dev,fn embedded in it so that the low level IO routines can do
error recovery if in{b,w,l} fails.

I didnt make these changes and it would seem we can link IO address <->
pci bus,dev,fn in other ways, if it turns out many drivers cannot use u64
for IO ports then we will have to investigate them.

> If you want to play with _explicit_ MMIO, you just have to remove a couple
> of line from sym53c8xx.h. Here they are:

Yes MMIO works fine. Is there a reason we force PCI IO on __powerpc__?

Anton
