Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUHQMvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUHQMvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHQMvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:51:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18707 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268209AbUHQMvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:51:52 -0400
Date: Tue, 17 Aug 2004 13:51:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       jdike@addtoit.com, kai@germaschewski.name, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-ID: <20040817135139.E25385@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>, jdike@addtoit.com,
	kai@germaschewski.name, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org> <20040817050642.GK11200@holomorphy.com> <20040816221017.018b0ef9.akpm@osdl.org> <20040817144527.GA7286@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040817144527.GA7286@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Aug 17, 2004 at 04:45:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 04:45:27PM +0200, Sam Ravnborg wrote:
> On Mon, Aug 16, 2004 at 10:10:17PM -0700, Andrew Morton wrote:
> > William Lee Irwin III <wli@holomorphy.com> wrote:
> > >
> > > On Tue, Aug 17, 2004 at 02:02:21AM -0400, Jeff Dike wrote:
> > > > The undefined symbol checking is continuing to cause UML pain.  This time,
> > > > it picked up a bunch of 'w' symbols as undefined.  They were present in the
> > > > 2.6.8-rc4-mm1 vmlinux and caused no problems for the final link, so I added
> > > > them as a second special case to mksysmap (and I just noticed that I forgot
> > > > a comment there - I can submit a patch for that if there's demand for one).
> > > 
> > > Likewise for sparc64; the 'w' symbols are showing up as 'undefined'
> > > there too. Probably because [^w] isn't behaving as expected.
> > > 
> > 
> > Sigh.  That patch is causing a ton of grief.  But Russell's reasons for
> > needing it on ARM were solid, and it is a bit weird for any architecture to
> > have undefined symbols in vmlinux.  I guess we persist.
> Please note that the functionality is moved to scripts/mksysmap,
> so Russell's original ldchk needs to be backed out.

I'm hopeful that the next release of binutils (any ideas when that'll
be?) should resolve the various problems I've found.

At that point, I think we should consider whether to keep the check
(for possible problems in the future) and/or prevent older ARM
binutils building the kernel.  That depends whether forcing all ARM
people to use the latest and greatest binutils (which may have other
issues) is really the best plan...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
