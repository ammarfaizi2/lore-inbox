Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136178AbRD2UMW>; Sun, 29 Apr 2001 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136189AbRD2UMM>; Sun, 29 Apr 2001 16:12:12 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:12537 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136178AbRD2UMB>; Sun, 29 Apr 2001 16:12:01 -0400
Date: Sun, 29 Apr 2001 22:11:59 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429153229.L679@nightmaster.csn.tu-chemnitz.de> <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Apr 29, 2001 at 12:48:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 12:48:06PM -0600, Richard Gooch wrote:
> Ingo Oeser writes:
> > There we have 10x faster memmove/memcpy/bzero for 1K blocks
> > granularity (== alignment is 1K and size is multiple of 1K), that
> > is done by the memory controller.
> This sounds different to me. Using the memory controller is (should
> be!) a privileged operation, thus it requires a system call. This is
> quite different from code in a magic page, which is excuted entirely
> in user-space. The point of the magic page is to avoid the syscall
> overhead.

Yes, but we currently have more than 10K cycles for doing
memset of a page. If we do an syscall, we have around 600-900
(don't know exactly), which is still less.

The point is: The code in that "magic page" that considers the
tradeoff is KERNEL code, which is designed to care about such
trade-offs for that machine. Glibc never knows this stuff and
shouldn't, because it is already bloated.

We get the full win here, for our "compile the kernel for THIS
machine to get maximum performance"-strategy.

People tend to compile the kernel, but not the glibc.

Just let the benchmarks, Linus and Ulrich decide ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
