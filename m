Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVEXBWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEXBWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXBWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:22:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:44189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261329AbVEXBRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:17:44 -0400
Date: Mon, 23 May 2005 18:17:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, p2@mind.be,
       vandrove@vc.cvut.cz, dsd@gentoo.org
Subject: Re: [patch 06/16] Fix matroxfb on big-endian hardware
Message-ID: <20050524011711.GD27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net> <20050523232207.GR27549@shell0.pdx.osdl.net> <20050523235052.GX29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523235052.GX29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro (viro@parcelfarce.linux.theplanet.co.uk) wrote:
> On Mon, May 23, 2005 at 04:22:07PM -0700, Chris Wright wrote:
> > -				mga_writel(mmio, 0, *chardata);
> > +#if defined(__BIG_ENDIAN)
> > +				fb_writel((*chardata) << 24, mmio.vaddr);
> > +#else
> > +				fb_writel(*chardata, mmio.vaddr);
> > +#endif
> 
> So basically you are passing it cpu_to_le32(*chardata)?
> 
> > +#if defined(__BIG_ENDIAN)
> > +				fb_writel((*(u_int16_t*)chardata) << 16, mmio.vaddr);
> > +#else
> > +				fb_writel(*(u_int16_t*)chardata, mmio.vaddr);
> > +#endif
> 
> *yuck*
> 
> cpu_to_le32(le16_to_cpu(*(__le16 *)chardata)?  Is that what you are doing
> here?

Petr, care to comment?  Best I can tell this is from you and is already
upstream.  Any reason not to use cpu_to_xx instead of what's done?
