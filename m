Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUIGKBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUIGKBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUIGKBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:01:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:27336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267796AbUIGKB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:01:26 -0400
Date: Tue, 7 Sep 2004 02:59:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: paulus@samba.org, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in
 cdrom_read_cdda_old()
Message-Id: <20040907025921.7f6a4139.akpm@osdl.org>
In-Reply-To: <20040907093437.GK6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost>
	<20040907080223.GF6323@suse.de>
	<16701.32784.10441.884090@cargo.ozlabs.ibm.com>
	<20040907093437.GK6323@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Tue, Sep 07 2004, Paul Mackerras wrote:
> > Jens Axboe writes:
> > 
> > > __copy_to_user is the unchecking version of copy_to_user.
> > 
> > It doesn't range-check the address, but it does return non-zero
> > (number of bytes not copied) if it encounters a fault writing to the
> > user buffer.
> 
> but it doesn't matter, if it returns non-zero then something happened
> between the access_ok() and the actual copy because the user app did
> something silly. so I don't care much really, I think the major point is
> the kernel will cope.
> 
> you could remove the access_ok() and change it to a copy_to_user()
> instead, I don't care either way. it's the old and slow interface which
> really never is used unless things have gone wrong anyways.
> 

Sure, but at present if an application tries to read cdrom data to address
0x00000000 (say), the kernel will return "success".  It should return an
error code.  (Actually, it should return a short read if any data was
transferred, but whatever).

Plus the patch will fix a __must_check warning.
