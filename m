Return-Path: <linux-kernel-owner+w=401wt.eu-S1161036AbXAEKYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbXAEKYc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbXAEKYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:24:32 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58476 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161036AbXAEKYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:24:32 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 5 Jan 2007 05:18:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
In-Reply-To: <20070105100610.GA382@Ahmed>
Message-ID: <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de>
 <20070105100610.GA382@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Ahmed S. Darwish wrote:

> On Fri, Jan 05, 2007 at 09:10:01AM +0100, Rolf Eike Beer wrote:
> > Ahmed S. Darwish wrote:
> > > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> > >
> > > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> >
> >   	if (!*ltp_loc) {
> >  -		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
> >  -						 GFP_KERNEL);
> >  +		ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >                       ^^^^^^^
> >   		if (!ltp)
> >   			goto free_mem_out;
> >   		memset(ltp, 0, sizeof(struct ktermios));
> >                 ^^^^^^
> > kzalloc
> >
> >   		if (!*o_ltp_loc) {
> >  -			o_ltp = (struct ktermios *)
> >  -				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >  +			o_ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >                                 ^^^^^^^
> >   			if (!o_ltp)
> >   				goto free_mem_out;
> >   			memset(o_ltp, 0, sizeof(struct ktermios));
> >                         ^^^^^^
> > kzalloc
>
> Currently I'm dropping this patch and writing a big patch to remove
> all the k[mzc]alloc castings in the 20-rc3 tree as suggested by Mr.
> Robert Day. I think this will be better done in another patch to let
> every patch do one single thing. right ?

almost.  as i've learned (the hard way), while each patch should
logically accomplish one thing, while you're there, you might as well
clean up other issues *at the same locations*.

in this case, as mr. beer suggests, you should also check if this
represents a kmalloc->kzalloc cleanup (there's lots of those), and
also see if you can replace one of these:

  sizeof(struct blah)

with one of these:

  sizeof(*blahptr)

according to the CodingStyle guide.

rday

p.s.  just FYI, i have a patch that does most of this, but i was going
to hold off submitting it until 2.6.20 had arrived.  but if you want
to take a shot at it, it's all yours.
