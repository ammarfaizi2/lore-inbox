Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135871AbRD2S4T>; Sun, 29 Apr 2001 14:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135885AbRD2S4K>; Sun, 29 Apr 2001 14:56:10 -0400
Received: from [63.95.87.168] ([63.95.87.168]:46343 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135943AbRD2Sz7>;
	Sun, 29 Apr 2001 14:55:59 -0400
Date: Sun, 29 Apr 2001 14:55:53 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010429145552.A17155@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429153229.L679@nightmaster.csn.tu-chemnitz.de> <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Apr 29, 2001 at 12:48:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 12:48:06PM -0600, Richard Gooch wrote:
> Ingo Oeser writes:
> > On Sun, Apr 29, 2001 at 04:27:48AM -0700, David S. Miller wrote:
> > > The idea is that the one thing one tends to optimize for new cpus
> > > is the memcpy/memset implementation.  What better way to shield
> > > libc from having to be updated for new cpus but to put it into
> > > the kernel in this magic page?
> > 
> > Hehe, you have read this MXT patch on linux-mm, too? ;-)
> > 
> > There we have 10x faster memmove/memcpy/bzero for 1K blocks
> > granularity (== alignment is 1K and size is multiple of 1K), that
> > is done by the memory controller.
> 
> This sounds different to me. Using the memory controller is (should
> be!) a privileged operation, thus it requires a system call. This is
> quite different from code in a magic page, which is excuted entirely
> in user-space. The point of the magic page is to avoid the syscall
> overhead.

Too bad this is a performance hack, otherwise we could place the privlaged
code in the read-only page, allow it to get execute from user space, catch
the exception, notice the EIP and let it continue on.
