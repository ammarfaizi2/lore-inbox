Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292358AbSBBTVN>; Sat, 2 Feb 2002 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292356AbSBBTVF>; Sat, 2 Feb 2002 14:21:05 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:13492 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S292355AbSBBTVA>;
	Sat, 2 Feb 2002 14:21:00 -0500
Date: Sat, 2 Feb 2002 14:20:58 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202142058.A1767@nevyn.them.org>
Mail-Followup-To: Jeff Garzik <garzik@havoc.gtf.org>,
	Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	paulus@samba.org, davidm@hpl.hp.com, ralf@gnu.org
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org> <3C5B56A4.B762948F@zip.com.au> <20020202073020.GA7014@tapu.f00f.org> <20020202024236.B17031@nevyn.them.org> <20020202030847.D20865@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020202030847.D20865@havoc.gtf.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 03:08:47AM -0500, Jeff Garzik wrote:
> On Sat, Feb 02, 2002 at 02:42:36AM -0500, Daniel Jacobowitz wrote:
> > One piece of the necessary compiler help would be -ffunction-sections. 
> > If they are in the same section in the same object file, they simply
> > can not be removed safely.
> 
> Such as the patch that was mentioned earlier in this thread :)

Yes, the patch that he was objecting to :)

> > Relocation information for calls to local
> > functions is not reliably available at link time.
> 
> With a smarter toolchain it could be.
> 
> One will need a smarter toolchain in order to re-order functions
> anyway, which is an area where benchmarks on other compilers are
> showing benefits.  (ie. moving "cold" functions to the end of the
> module, given profiling feedback)

No, the linker simply can not assume that this information is present. 
That's a limitation of ELF.  The right way to do this sort of
optimization is to compile every function into its own section and then
handle the (very small) performance cost of doing so by a relaxation
pass in the linker.  You can't safely remove any part of an input
section, no matter what relocation information you think you have.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
