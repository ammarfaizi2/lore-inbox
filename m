Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUIGKXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUIGKXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUIGKXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:23:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27572 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267796AbUIGKXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:23:33 -0400
Date: Tue, 7 Sep 2004 11:23:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jens Axboe <axboe@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907102331.GS23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com> <20040907093437.GK6323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907093437.GK6323@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:34:37AM +0200, Jens Axboe wrote:
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

access_ok() is far from being the only reason for error here.  If area
is unmapped, we shouldn't silently lose data without any indication of
error.
