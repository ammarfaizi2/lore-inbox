Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUIGLnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUIGLnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUIGLnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:43:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34991 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267828AbUIGLnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:43:41 -0400
Date: Tue, 7 Sep 2004 13:42:31 +0200
From: Jens Axboe <axboe@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Paul Mackerras <paulus@samba.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907114231.GS6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com> <20040907093437.GK6323@suse.de> <20040907102331.GS23987@parcelfarce.linux.theplanet.co.uk> <20040907103031.GP6323@suse.de> <20040907104514.GT23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907104514.GT23987@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2004, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Sep 07, 2004 at 12:30:31PM +0200, Jens Axboe wrote:
> > it boils down to access_ok() not being sufficient on its own, and in
> > which case yes we should just use copy_to_user() and kill the check
> > completely as per the patch sent out.
> 
> access_ok() is just "we can trust MMU to do the right thing when dealing
> with access to process address space at that address".  On platforms with
> secondary address spaces (e.g. sparc) it's always true.  On something like
> i386 we *could* use segments for the same purposes.  In fact, we used to
> do just that - access to userland memory went with %fs as segment (thus
> the names like extinct memcpy_fromfs() and surviving set_fs()).  However,
> it's cheaper to do that check explicitly instead of relying on MMU.  And
> that's what access_ok() does.

Alright, I'm wondering how the misconception of what access_ok() really
guarantees snuck into cdrom.c. At least the patch takes care of it.

-- 
Jens Axboe

