Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319233AbSHUWmG>; Wed, 21 Aug 2002 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319234AbSHUWmF>; Wed, 21 Aug 2002 18:42:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319233AbSHUWmF>; Wed, 21 Aug 2002 18:42:05 -0400
Date: Wed, 21 Aug 2002 15:50:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move BKL down a little in setfl
In-Reply-To: <20020821234241.R29958@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0208211549100.1280-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Aug 2002, Matthew Wilcox wrote:
> 
> Nothing spectacular here, just push the BKL down a little.

This exits with the BKL held, as far as I can tell:

> +	lock_kernel();
> +	if ((arg ^ filp->f_flags) & FASYNC) {
> +		if (filp->f_op && filp->f_op->fasync) {
> +			int error;
> +			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
> +			if (error < 0)
> +				return error;
				^^^^^^^^^^^^
Here.

		Linus

