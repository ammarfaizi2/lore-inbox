Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135885AbRD2TCt>; Sun, 29 Apr 2001 15:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135891AbRD2TCj>; Sun, 29 Apr 2001 15:02:39 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60134 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135885AbRD2TCU>; Sun, 29 Apr 2001 15:02:20 -0400
Date: Sun, 29 Apr 2001 13:02:13 -0600
Message-Id: <200104291902.f3TJ2Dd21232@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010429145552.A17155@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
	<15083.64180.314190.500961@pizda.ninka.net>
	<20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
	<200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
	<20010429145552.A17155@xi.linuxpower.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell writes:
> On Sun, Apr 29, 2001 at 12:48:06PM -0600, Richard Gooch wrote:
> > Ingo Oeser writes:
> > > On Sun, Apr 29, 2001 at 04:27:48AM -0700, David S. Miller wrote:
> > > > The idea is that the one thing one tends to optimize for new cpus
> > > > is the memcpy/memset implementation.  What better way to shield
> > > > libc from having to be updated for new cpus but to put it into
> > > > the kernel in this magic page?
> > > 
> > > Hehe, you have read this MXT patch on linux-mm, too? ;-)
> > > 
> > > There we have 10x faster memmove/memcpy/bzero for 1K blocks
> > > granularity (== alignment is 1K and size is multiple of 1K), that
> > > is done by the memory controller.
> > 
> > This sounds different to me. Using the memory controller is (should
> > be!) a privileged operation, thus it requires a system call. This is
> > quite different from code in a magic page, which is excuted entirely
> > in user-space. The point of the magic page is to avoid the syscall
> > overhead.
> 
> Too bad this is a performance hack, otherwise we could place the
> privlaged code in the read-only page, allow it to get execute from
> user space, catch the exception, notice the EIP and let it continue
> on.

No need for anything that complicated. We can merge David's user-space
memcpy code with the memory controller scheme. We need a new syscall
anyway to access the memory controller, so we may as well just make it
a simple interface. Then the user-space code may, on some machines,
contain a test (for alignment) and call to the new syscall.

The two schemes are independent, and should be treated as such. Just
as the magic page code can call the new syscall, so could libc.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
