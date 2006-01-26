Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWAZEec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAZEec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWAZEec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:34:32 -0500
Received: from mail.gmx.de ([213.165.64.21]:55210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750784AbWAZEea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:34:30 -0500
X-Authenticated: #271361
Date: Thu, 26 Jan 2006 05:34:12 +0100
From: Edgar Toernig <froese@gmx.de>
To: Richard Henderson <rth@twiddle.net>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-Id: <20060126053412.0da7f505.froese@gmx.de>
In-Reply-To: <20060126000618.GA5592@twiddle.net>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
>
> On Wed, Jan 25, 2006 at 08:02:50PM +0000, Russell King wrote:
> > > +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> > > +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> > > +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
> ...
> > Basically, shifts which depend on a variable are more expensive than
> > constant-based shifts.
> 
> Actually, they're all constant shifts.  Just written stupidly.

Why shift at all?

int ffs(u32 word)
{
    int bit = 0;

    word &= -word; // only keep the lsb.

    if (word & 0xffff0000) bit |= 16;
    if (word & 0xff00ff00) bit |=  8;
    if (word & 0xf0f0f0f0) bit |=  4;
    if (word & 0xcccccccc) bit |=  2;
    if (word & 0xaaaaaaaa) bit |=  1;

    return bit;
}

Ciao, ET.
