Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRD2Xxo>; Sun, 29 Apr 2001 19:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136415AbRD2Xxg>; Sun, 29 Apr 2001 19:53:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23124 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132993AbRD2Xx3>; Sun, 29 Apr 2001 19:53:29 -0400
Date: Mon, 30 Apr 2001 01:53:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010430015301.D923@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429213804.D8512@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010429213804.D8512@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sun, Apr 29, 2001 at 09:38:04PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 09:38:04PM +0200, Jamie Lokier wrote:
> Fwiw, modern x86 has global TLB entries too.

my x86-64 implementation is marking the tlb entry global of course (so
it's not flushed during context switch):

#define __PAGE_KERNEL_VSYSCALL \
	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
#define MAKE_GLOBAL(x) __pgprot((x) | _PAGE_GLOBAL)
#define PAGE_KERNEL_VSYSCALL MAKE_GLOBAL(__PAGE_KERNEL_VSYSCALL)

static void __init map_vsyscall(void)
{
	extern char __vsyscall_0;
	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - __START_KERNEL_map;

	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
}

Andrea
