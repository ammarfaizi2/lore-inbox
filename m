Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIGJfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIGJfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIGJfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:35:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31466 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267767AbUIGJfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:35:45 -0400
Date: Tue, 7 Sep 2004 11:34:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907093437.GK6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16701.32784.10441.884090@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2004, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > __copy_to_user is the unchecking version of copy_to_user.
> 
> It doesn't range-check the address, but it does return non-zero
> (number of bytes not copied) if it encounters a fault writing to the
> user buffer.

but it doesn't matter, if it returns non-zero then something happened
between the access_ok() and the actual copy because the user app did
something silly. so I don't care much really, I think the major point is
the kernel will cope.

you could remove the access_ok() and change it to a copy_to_user()
instead, I don't care either way. it's the old and slow interface which
really never is used unless things have gone wrong anyways.

-- 
Jens Axboe

