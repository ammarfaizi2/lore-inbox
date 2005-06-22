Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVFVUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVFVUhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFVUhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:37:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62988 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262030AbVFVUdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:33:05 -0400
Date: Wed, 22 Jun 2005 22:32:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Pekka Enberg <penberg@gmail.com>
Cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Message-ID: <20050622203211.GI8907@alpha.home.local>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <84144f020506221243163d06a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020506221243163d06a2@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 22, 2005 at 10:43:40PM +0300, Pekka Enberg wrote:
> On 6/22/05, Bouchard, Sebastien <Sebastien.Bouchard@ca.kontron.com> wrote:
> > --- 2.4.31-ori/drivers/char/tlclk.c     Wed Dec 31 19:00:00 1969
> > +++ 2.4.31-mod/drivers/char/tlclk.c     Wed Jun 22 09:43:10 2005
> > +/* Telecom clock I/O register definition */
> > +#define TLCLK_BASE 0xa08
> > +#define TLCLK_REG0 TLCLK_BASE
> > +#define TLCLK_REG1 TLCLK_BASE+1
> > +#define TLCLK_REG2 TLCLK_BASE+2
> > +#define TLCLK_REG3 TLCLK_BASE+3
> > +#define TLCLK_REG4 TLCLK_BASE+4
> > +#define TLCLK_REG5 TLCLK_BASE+5
> > +#define TLCLK_REG6 TLCLK_BASE+6
> > +#define TLCLK_REG7 TLCLK_BASE+7
> 
> Please use enums instead.

I dont agree with you here : enums are good to simply specify an ordering.
But they must not be used to specify static mapping. Eg: if REG4 *must* be
equal to BASE+4, you should not use enums, otherwise it will render the
code unreadable. I personnaly don't want to count the position of REG7 in
the enum to discover that it's at BASE+7.

> > +#define RESET_ON 0x00
> > +#define RESET_OFF 0x01
> 
> Please use enums instead (applies to other parts of this file too).

Same comment here : if writing the *bit* 0 asserts the reset line, and
writing the *bit* 1 deasserts it, enum is not adequate at all. Enums are
adequate when you don't care about the values themselves, eg the sysctl
entries, etc... (eventhough most of them are statically assigned). But
if you need something more verbose to say exactly "write 7 to port 123",
it's better to use defines (or even variables sometimes) than enums.

Regards,
Willy

