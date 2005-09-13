Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVIMSCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVIMSCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVIMSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:02:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61448 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964898AbVIMSCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:02:51 -0400
Date: Tue, 13 Sep 2005 19:02:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, J?rn Engel <joern@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Missing #include <config.h>
Message-ID: <20050913190244.A26494@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@infradead.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913141246.GA3234@infradead.org> <Pine.LNX.4.62.0509131956030.24748@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.62.0509131956030.24748@numbat.sonytel.be>; from geert@linux-m68k.org on Tue, Sep 13, 2005 at 07:57:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 07:57:30PM +0200, Geert Uytterhoeven wrote:
> On Tue, 13 Sep 2005, Christoph Hellwig wrote:
> > On Tue, Sep 13, 2005 at 03:08:26PM +0100, Russell King wrote:
> > > On Tue, Sep 13, 2005 at 02:56:23PM +0100, J?rn Engel wrote:
> > > > After spending some hours last night and this morning hunting a bug,
> > > > I've found that a different include order made a difference.  Some
> > > > files don't work correctly, unless config.h is included before.
> > > 
> > > I'm still of the opinion that we should add
> > > 
> > > 	-imacros include/linux/config.h
> > > 
> > > to the gcc command line and stop bothering with trying to get
> > > linux/config.h included into the right files and not in others.
> > > (which then means we can eliminate linux/config.h from all files.)
> > 
> > Yes, absolutely.  That would help fixing lots of mess.
> 
> What about dependencies? Would it cause a recompile of everything if config.h
> is changed?

-imacros include/linux/autoconf.h doesn't leak into the dependencies so
it's fine.

> Ah, I guess not, since config.h is filtered out of the deps anyway and
> replaced by a smarter dependency on the correct CONFIG_*, right?

According to my .*.cmd files, apparantly so.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
