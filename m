Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTILJ6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTILJ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:58:43 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:16031 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261350AbTILJ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:58:41 -0400
Date: Fri, 12 Sep 2003 11:58:26 +0200
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Jens Axboe <axboe@suse.de>
Cc: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Impossible to read files from a CD-Rom
Message-ID: <20030912095825.GB568@bouh.residence.ens-lyon.fr>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Jens Axboe <axboe@suse.de>,
	=?iso-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@libertysurf.fr>,
	linux-kernel@vger.kernel.org
References: <20030818163520.GA413@galois> <20030908152800.GA5224@bouh.famille.thibault.fr> <20030912065116.GA16813@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030912065116.GA16813@suse.de>
User-Agent: Mutt/1.4i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 12 sep 2003 08:51:16 GMT, Jens Axboe a tapoté sur son clavier :
> On Mon, Sep 08 2003, Samuel Thibault wrote:
> > The solution would be to return an error if 
> > cgc.buflen != sizeof(track_information) after the truncation to
> > sizeof(track_information), so that cdrom_get_last_written() will
> > correctly fail, and make cdrom_read_toc() use cdrom_read_capacity()
> > instead, which gives the correct answer.
> 
> It isn't that easy, if that were the case there would be no need for the
> above code would there?
> 
> This basically boils down to a typical problem with CDROM/DVD drives -
> some specific structure may vary a little in size depending on when in
> the spec cycle they were implemented. Some drives barf if you try and
> read to much, some when you read too little. So the approach that
> typically works the best is to just read the very first of the
> structure, check the length, and issue a read for the complete data.

This is fine. Another solution would be that cdrom_get_track_info returns
the actual amount of data that was read, so that the caller may check
that the field it needs was really filled up.

> I'd be more interested in fixing the real bug: why does your drive
> return zero length, and only sporadically?

This we don't know, and I don't think we may do much about it. The cdrom
drive is a Dell one, connected to a dell laptop. They don't come from
the same laptop package at first, but it should still work (or linux may
try to work it around).

The very funny thing about it is that with 2.4 there was no problem
merely because it happened that the not filled up track_size field
already had a very big value, so that linux would think the cd is
actually very big and let i/o go...

Regards,
Samuel Thibault
