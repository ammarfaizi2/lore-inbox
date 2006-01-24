Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAXVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAXVao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWAXVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:30:43 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:57999 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1750736AbWAXVan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:30:43 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Neil Brown <neilb@suse.de>
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
Date: Tue, 24 Jan 2006 22:29:06 +0100
User-Agent: KMail/1.8
Cc: Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org
References: <200601042108.04544.stefan@loplof.de> <17365.45558.820747.408425@cse.unsw.edu.au>
In-Reply-To: <17365.45558.820747.408425@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601242229.06995.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 24 Januar 2006 05:49 schrieb Neil Brown:

> >--- linux-2.6.14.4/drivers/md/dm-crypt.c.old	2005-12-16 18:27:05.000000000
> > +0100 +++ linux-2.6.14.4/drivers/md/dm-crypt.c	2005-12-28
> > 12:49:13.000000000 +0100 @@ -694,6 +694,7 @@ bad3:
> > bad2:
> > 	crypto_free_tfm(tfm);
> > bad1:
> >+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
> > 	kfree(cc);
> > 	return -EINVAL;
> > }
>
> There is a small problem with this patch.
> If the 'goto bad1' branch is taken, then 'cc->key_size' will not be
> defined.
> I think you need the following patch on top.

Why? This is from today's git, just before the first goto bad1

 559         cc->key_size = key_size;
 560         if ((!key_size && strcmp(argv[1], "-") != 0) ||
 561             (key_size && crypt_decode_key(cc->key, argv[1], key_size) < 
0)) {
 562                 ti->error = PFX "Error decoding key";
 563                 goto bad1;
 564         }

Stefan
