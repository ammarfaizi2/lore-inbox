Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTJHUcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTJHUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:32:43 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:11755 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261774AbTJHUcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:32:15 -0400
Date: Wed, 8 Oct 2003 22:32:10 +0200
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Jens Axboe <axboe@suse.de>,
       =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Impossible to read files from a CD-Rom
Message-ID: <20031008203210.GC779@bouh.residence.ens-lyon.fr>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Jens Axboe <axboe@suse.de>,
	=?iso-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@libertysurf.fr>,
	linux-kernel@vger.kernel.org
References: <20030818163520.GA413@galois> <20030908152800.GA5224@bouh.famille.thibault.fr> <20030912065116.GA16813@suse.de> <20030912095825.GB568@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030912095825.GB568@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.4i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven 12 sep 2003 11:58:25 GMT, Samuel Thibault a tapoté sur son clavier :
> Le ven 12 sep 2003 08:51:16 GMT, Jens Axboe a tapoté sur son clavier :
>
> > This basically boils down to a typical problem with CDROM/DVD drives -
> > some specific structure may vary a little in size depending on when in
> > the spec cycle they were implemented. Some drives barf if you try and
> > read to much, some when you read too little. So the approach that
> > typically works the best is to just read the very first of the
> > structure, check the length, and issue a read for the complete data.
> 
> This is fine. Another solution would be that cdrom_get_track_info returns
> the actual amount of data that was read, so that the caller may check
> that the field it needs was really filled up.

I tested this and it worked fine.

> > I'd be more interested in fixing the real bug: why does your drive
> > return zero length, and only sporadically?

Not sporadically, it always returns the same amount of data, but this
amount is not sufficient to give the size, so that an arbitrary size is
taken. The function should see that and report an error instead, which
will fix the problem we had by trigging another size discovery mean.

Regards,
Samuel Thibault
