Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVCDM0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVCDM0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVCDMWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:22:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35854 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262844AbVCDLyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:54:46 -0500
Date: Fri, 4 Mar 2005 11:54:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304115439.F3932@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
	torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050304034410.2ccfba74.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050304034410.2ccfba74.akpm@osdl.org>; from akpm@osdl.org on Fri, Mar 04, 2005 at 03:44:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:44:10AM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Fri, Mar 04, 2005 at 03:26:32AM -0800, Andrew Morton wrote:
> > > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > >
> > > > On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
> > > >  > Grump.  Have all these regressions received the appropriate level of
> > > >  > visibility on this mailing list?
> > > > 
> > > >  Looking at the http://l4x.org/k/ site, it appears that all -mm versions
> > > >  have broken ARM support with the defconfig, while Linus kernels at least
> > > >  build fine.
> > > 
> > > It's very much in an arch maintainer's interest to make sure that
> > > cross-compilers are easily obtainable.  Any hints?
> > 
> > Been trying to achieve that since it's a FAQ on ARM lists.  Even gone to
> > the extent of setting up a separate mailing list, getting a volunteer to
> > track what people want and do the hard work to build them.  That was
> > about 6 months ago, and I haven't seen any results.
> 
> hm.  That's strange.  I'd have thought that 99% of the arm embedded
> developers cross-build.

Yes - I think Dan Kegel's cross-tool gets used a fair bit...

> > Anyway, going back to why -mm doesn't work:
> > 
> >  arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
> >  : undefined reference to `rd_size'
> >  make[1]: *** [.tmp_vmlinux1] Error 1

Actually, this highlights another problem - it's ARM binutils again.
Jan's cross-binutils for ARM doesn't contain the patches to make the
linker resolve addresses to the _correct_ symbol.  Don't ask me
where they are, but I'm lead to believe that cross-tool knows.

This also means that Jan's compile test is rather worthless for ARM -
it might be linking a kernel with undefined symbols due to the other
assembler bug.

> Ah.  Fixed, thanks.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
