Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUF1BOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUF1BOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUF1BOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:14:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57349 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264585AbUF1BOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:14:47 -0400
Date: Mon, 28 Jun 2004 02:14:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628021439.A17654@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com> <20040628003311.GA23017@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628003311.GA23017@taniwha.stupidest.org>; from cw@f00f.org on Sun, Jun 27, 2004 at 05:33:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 05:33:11PM -0700, Chris Wedgwood wrote:
> On Sun, Jun 27, 2004 at 07:24:34PM -0500, Erik Jacobson wrote:
> > Maybe you can help me clear it up then.  When I feed serial core the
> > name ttyS with TTY_MAJOR and minor 64, the registration fails.  If I
> > disable 8250 in the kernel config, the registration works for us.
> 
> I'm not sure why the 8250 code reserves/registers ttyS0 on Altix when
> do such hardware exists.  I vaguely recall patching it to prevent this
> in a hacky way.
> 
> I would like to know why the 8250 code is registering a driver for
> hardware that doesn't exist and see that fixed.

It's the way its always been done, and the way the tty layer works.
You register a range of ttys that you're going to be driving, and
you own those ttys whether or not you actually have hardware for
them.

You can't say "ok, I have ttyS1 and ttyS3, I'll leave ttyS0 and ttyS2
available for someone else to use" because the tty layer just doesn't
work like that.  It has the notion of a single driver for a range of
non-overlapping ttys.

Yes, it would be nice to get rid of that limitation, but we're in a
stable kernel series and the tty layer doesn't have a maintainer to
do the work...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
