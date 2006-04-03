Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWDCVTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWDCVTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWDCVTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:19:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751016AbWDCVTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:19:30 -0400
Date: Mon, 3 Apr 2006 14:21:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: neilb@suse.de, nathans@sgi.com, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060403142130.1868c0e3.akpm@osdl.org>
In-Reply-To: <20060403143100.GH4647@suse.de>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060331071736.K921158@wobbly.melbourne.sgi.com>
	<17456.31028.173800.615259@cse.unsw.edu.au>
	<20060403074959.GG3770@suse.de>
	<20060403012753.218db397.akpm@osdl.org>
	<20060403143100.GH4647@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > > I don't think any disagrees with you, the sync-write process flag is
> > > indeed an atrocious beast...
> > 
> > Yeah.  PF_SYNCWRITE was a performance tweak for the anticipatory scheduler.
> > As cfq is using it as well now (hopefully to good effect) I guess it could
> > be formalised more.
> 
> Yup, both 'as' and 'cfq' would prefer to just look at a SYNC bio flag
> instead. But the logic itself is definitely needed.

hm.  I actually thought we were already doing that.  We should at least
tranfer PF_SYNCWRITE into bi_flags at the point where we start to construct
the BIO.

That might well fix RAID, too.  If it's handing work off to another thread
via BIOs.

