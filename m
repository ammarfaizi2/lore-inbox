Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTIDWEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbTIDWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:04:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6797 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264835AbTIDWEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:04:44 -0400
Date: Thu, 4 Sep 2003 23:04:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop mprotect() changing MAP_SHARED and other cleanup
Message-ID: <20030904220435.GI31590@mail.jlokier.co.uk>
References: <20030904193454.GA31590@mail.jlokier.co.uk> <20030904201851.GK13947@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904201851.GK13947@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> > +/* Optimisation macro. */
> > +#define _calc_vm_trans(x,bit1,bit2) \
> > +  ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
> > +   : ((x) & (bit1)) / ((bit1) / (bit2))
> 
> Why is this necessary? the original version of the macro was much
> simpler. If this isn't just for shaving a couple of optimization,
> please document it. If it is, I urge you to reconsider ;-) 

When the bits don't match, mine reduces to a mask-and-shift.  The
original reduces to a mask-and-conditional, which is usually slower.

Hopefully GCC optimises the latter to the former these days, but there
is no harm in helping.

I vaguely recall GCC being able to optimise (x&mask1) | (x&mask2) to
x&(mask1|mask2), not 100% sure though.  If so, the PROT_ bits
translation will reduce to prot & 7.

-- Jamie
