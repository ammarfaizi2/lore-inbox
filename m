Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270088AbUJVOWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270088AbUJVOWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUJVOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:22:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:27569 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269980AbUJVOUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:20:46 -0400
X-Envelope-From: kraxel@bytesex.org
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: Luc Saillard <luc@saillard.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<20041022092102.GA16963@sd291.sivit.org>
	<20041022143036.462742ca.luca.risolia@studio.unibo.it>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 22 Oct 2004 16:10:04 +0200
In-Reply-To: <20041022143036.462742ca.luca.risolia@studio.unibo.it>
Message-ID: <878y9y269v.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Risolia <luca.risolia@studio.unibo.it> writes:

> If it ever happens that this driver is accepted, be also prepared to
> accept patches adding decompression and colorspace conversions for
> every video driver I am aware of, starting from the ones I have already
> written to the ones I'll submit in the future.

Uhm, colorspace conversions and decompression are two different
problems.  Drivers should support at least one of the v4l2 standard
formats.  They might have to do decompression in kernel space to to
that.

colorspace conversion should be the job of the userspace app, I think
everyone agrees on that.  Same goes for any *standard* compression
formats, i.e. webcams which simply use jpeg for example (where the
driver can say "Hey, I'll give you V4L2_PIX_FMT_JPEG" and the decoding
can easily be done using libjpeg.

The corner case are the vendor-specific compressions.  IMHO it doesn't
make much sense to attempt to implement every strange format some
engineer invented in every v4l2 application.  Especially if there is
no free implementation of it (which is the reason the non-gpl pwcx
module was created IIRC).

  Gerd

-- 
return -ENOSIG;
