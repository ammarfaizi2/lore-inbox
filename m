Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313704AbSDHRGX>; Mon, 8 Apr 2002 13:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313705AbSDHRGW>; Mon, 8 Apr 2002 13:06:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19874 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313704AbSDHRGV>; Mon, 8 Apr 2002 13:06:21 -0400
Date: Mon, 8 Apr 2002 11:06:02 -0600
Message-Id: <200204081706.g38H62N14879@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Oliver Neukum <oliver@neukum.org>
Cc: nahshon@actcom.co.il, Pavel Machek <pavel@suse.cz>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <16uSEQ-1XziYCC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum writes:
> 
> > > and spin-up on any operation that writes to the disk (and block that
> > > operation).
> >
> > Absolutely not! I don't want my writes to spin up the drive.
> 
> Even if you sync ?

I'm undecided. I think it's good to have a way to let the user force a
flush, but I don't like the same mechanism being used by applications
which think they know better. So flushing on sync(2) or f*sync(2) is
perhaps undesirable. Maybe the way to deal with this is to have:

- tunable flush time (i.e. how long to wait after a write(2) before
  flushing, if the drive is currently unspun)

- tunable dirty pages limit (i.e. how many dirty pages allowed before
  flushing)

- tunable "ignore *sync(2)" option. Default value is 0 (don't
  ignore). When set to 1, ignore all calls to *sync(2).

So then on my 256 MiB laptop, I'd probably set the flush time to 3
hours, the dirty page limit to 64 MiB, and ignore *sync(2). I'd write
a suid-root programme which did:
	enable_sync ();
	sync ();
	disable_sync ();

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
