Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWAXVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAXVoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWAXVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:44:32 -0500
Received: from cantor.suse.de ([195.135.220.2]:41640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750754AbWAXVob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:44:31 -0500
From: Neil Brown <neilb@suse.de>
To: Stefan Rompf <stefan@loplof.de>
Date: Wed, 25 Jan 2006 08:44:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.40888.91278.606360@cse.unsw.edu.au>
Cc: Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
In-Reply-To: message from Stefan Rompf on Tuesday January 24
References: <200601042108.04544.stefan@loplof.de>
	<17365.45558.820747.408425@cse.unsw.edu.au>
	<200601242229.06995.stefan@loplof.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 24, stefan@loplof.de wrote:
> Am Dienstag 24 Januar 2006 05:49 schrieb Neil Brown:
> 
> > >--- linux-2.6.14.4/drivers/md/dm-crypt.c.old	2005-12-16 18:27:05.000000000
> > > +0100 +++ linux-2.6.14.4/drivers/md/dm-crypt.c	2005-12-28
> > > 12:49:13.000000000 +0100 @@ -694,6 +694,7 @@ bad3:
> > > bad2:
> > > 	crypto_free_tfm(tfm);
> > > bad1:
> > >+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
> > > 	kfree(cc);
> > > 	return -EINVAL;
> > > }
> >
> > There is a small problem with this patch.
> > If the 'goto bad1' branch is taken, then 'cc->key_size' will not be
> > defined.
> > I think you need the following patch on top.
> 
> Why? This is from today's git, just before the first goto bad1
> 
>  559         cc->key_size = key_size;
>  560         if ((!key_size && strcmp(argv[1], "-") != 0) ||
>  561             (key_size && crypt_decode_key(cc->key, argv[1], key_size) < 
> 0)) {
>  562                 ti->error = PFX "Error decoding key";
>  563                 goto bad1;
>  564         }
> 
> Stefan


Ahhh.... sorry, 'bout that.  You are right.  I was looking at an
older kernel and assumed that bit of code hadn't been re-arrange...
My bad.  Pardon the noise.

NeilBrown
