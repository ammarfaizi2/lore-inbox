Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWJJJaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWJJJaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWJJJaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:30:07 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:38870 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965114AbWJJJaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:30:03 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 05:28:40 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] apparent typo in ixgb.h, "_DEBUG_DRIVER_" looks wrong
In-Reply-To: <20061010091501.GA5369@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0610100522240.6146@localhost.localdomain>
References: <Pine.LNX.4.64.0610100219590.3442@localhost.localdomain>
 <20061010091501.GA5369@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Alexey Dobriyan wrote:

> On Tue, Oct 10, 2006 at 02:27:34AM -0400, Robert P. J. Day wrote:
> > I'm *guessing* that "_DEBUG_DRIVER_" should really be
> > "DEBUG_DRIVER" here, since there is no other occurrence of the
> > former anywhere in the source tree.
>
> Since it's debugging guard, underscored or not... doesn't matter.
> Convert to pr_debug or dev_dbg of you want to deal with it.
>
> > --- a/drivers/net/ixgb/ixgb.h
> > +++ b/drivers/net/ixgb/ixgb.h
> > @@ -77,7 +77,7 @@ #include "ixgb_hw.h"
> >  #include "ixgb_ee.h"
> >  #include "ixgb_ids.h"
> >
> > -#ifdef _DEBUG_DRIVER_
> > +#ifdef DEBUG_DRIVER
> >  #define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> >  #else
> >  #define IXGB_DBG(args...)

but what you're suggesting is not equivalent.  i submitted that patch
to fix what *seems* to be an obvious, innocuous typo, to bring that
one header file into sync with the rest of the source tree, nothing
more.

if all debugging should now use either of pr_debug() or dev_dbg(),
that's fine but i notice that both of those macros will be defined
only if "DEBUG" is defined, not "DEBUG_DRIVER".  so making the change
you suggest would *not* be a trivial change.

what's the current standard for debugging directives in the kernel?

rday
