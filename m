Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVHRGie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVHRGie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVHRGid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:38:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62730 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750841AbVHRGi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:38:29 -0400
Date: Thu, 18 Aug 2005 07:38:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-ID: <20050818073824.C2365@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050817224805.17f29cfb.akpm@osdl.org>; from akpm@osdl.org on Wed, Aug 17, 2005 at 10:48:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 10:48:05PM -0700, Andrew Morton wrote:
> Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> >
> > >I'm thinking that it would be better to not have the config option there
> >  >and then re-add it late in the 2.6.14 cycle if someone reports problems
> >  >which cannot be fixed.  Or at least make it default to 'y' so we get more
> >  >testing coverage, then remove the config option later.  Or something.
> >  >
> >  >Thoughts?
> >  >  
> >  >
> > 
> >  Removing it would be preferable by me. All that #ifdef tends to clutter
> >  up the code. After som initial problem with a buggy card everything has
> >  worked flawlesly.
> 
> OK..  Please send an additional patch for that sometime?

I'd rather not.  The problem is that we have a host (thanks Intel)
which is unable to report how many bytes were transferred before an
error occurs.  My fear is that doing anything other than sector by
sector write will lead to corruption should an error occur.

However, I've no way to induce such an error, so I can only base
this on theory.

It may work perfectly for the case when everything's operating
correctly, but I suspect if you're going to do multi-sector writes,
it'll all fall apart on the first error, especially on this host.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
