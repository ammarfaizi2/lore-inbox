Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWEHL2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWEHL2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEHL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:28:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38927 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751262AbWEHL2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:28:42 -0400
Date: Mon, 8 May 2006 12:28:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060508112831.GA14206@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Andrew Morton <akpm@osdl.org>,
	Jason Schoonover <jasons@pioneer-pra.com>,
	linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <20060508111345.GA1875@harddisk-recovery.com> <1147087356.2888.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147087356.2888.9.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 01:22:36PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-05-08 at 13:13 +0200, Erik Mouw wrote:
> > On Sun, May 07, 2006 at 09:50:39AM -0700, Andrew Morton wrote:
> > > This is probably because the number of pdflush threads slowly grows to its
> > > maximum.  This is bogus, and we seem to have broken it sometime in the past
> > > few releases.  I need to find a few quality hours to get in there and fix
> > > it, but they're rare :(
> > > 
> > > It's pretty harmless though.  The "load average" thing just means that the
> > > extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> > > they'll later exit and clean themselves up.  They won't be consuming
> > > significant resources.
> > 
> > Not completely harmless. Some daemons (sendmail, exim) use the load
> > average to decide if they will allow more work.
> 
> and those need to be fixed most likely ;)

Why do you think that?  exim uses the load average to work out whether
it's a good idea to spawn more copies of itself, and increase the load
on the machine.

Unfortunately though, under 2.6 kernels, the load average seems to be
a meaningless indication of how busy the system is from that point of
view.

Having a single CPU machine with a load average of 150 and still feel
very interactive at the shell is extremely counter-intuitive.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
