Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTELNAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTELNAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:00:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22798 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262102AbTELNAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:00:43 -0400
Date: Mon, 12 May 2003 15:13:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512131326.GB15227@atrey.karlin.mff.cuni.cz>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz> <20030512134353.A28931@infradead.org> <20030512130518.GA15227@atrey.karlin.mff.cuni.cz> <20030512140834.A29260@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512140834.A29260@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I don't have a sparc64, but there's certainly no <asm/mtrr.h> for
> > > > that arch..
> > 
> > I thought I killed that one?
> 
> The patch you attached added it..

There are probably more such mistake. It should be easy for anyone
with sparc64 to kill them all at once.

> > > Also #including c files is ugly as hell.  What's the #ifdef INCLUDES
> > > supposed to help?
> > 
> > Yes, but do you have better proposal how to kill 4000+ lines of code
> > from each 64-bit architecture?
> 
> What's the reason you can't build fs/compat_ioctl.c normally and pull
> in the arch magic through a magic asm/ header?  

Some architectures need special stuff (mtrr's), so I'd have to include
.c files, too (the other way). [Look at how the table of ioctls is
generated, its asm magic].

> You still haven't answered
> the second question, btw.. 

Are you asking why are there #includes in compat_ioctl.c? Its because
there is so many of them, and having to update all archs when you
tuoch fs/compat_ioctl.c would be bad.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
