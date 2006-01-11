Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWAKJ3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWAKJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWAKJ3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:29:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10055 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751394AbWAKJ3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:29:10 -0500
Date: Wed, 11 Jan 2006 10:29:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
Message-ID: <20060111092937.GS3389@suse.de>
References: <200601110327_MC3-1-B5A3-6E0F@compuserve.com> <E1EwcCV-00013E-00.arvidjaar-mail-ru@f48.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EwcCV-00013E-00.arvidjaar-mail-ru@f48.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Andrey Borzenkov wrote:
> 
> 
> > drive name:             sr0
> > drive speed:            1
> > drive # of slots:       1
> > Can close tray:         1
> > Can open tray:          1
> > Can lock tray:          1
> > Can change speed:       0
> > Can select disk:        0
> > Can read multisession:  1
> > Can read MCN:           1
> > Reports media changed:  1
> > Can play audio:         1
> > Can write CD-R:         0
> > Can write CD-RW:        0
> > Can read DVD:           0
> > Can write DVD-R:        0
> > Can write DVD-RAM:      0
> > Can read MRW:           1
> > Can write MRW:          1
> > Can write RAM:          1
> > 
> > There's no way this drive knows anything about MRW or random-access writing:
> > 
> ...
> > And an ATAPI DVD-ROM also reports (before the above patch):
> > 
> > Can read MRW:           1
> > Can write MRW:          1
> > Can write RAM:          1
> > 
> 
> I know. There were patches from Jens for both 2.4 and 2.6 that add MRW
> support to ide-cd for sure; may be for sr too, am not sure. Jens, any
> reasons for them not in mainstream? Otherwise probably ide-cd and sr should
> not announce MRW capabiliies at all, it is too confusing; I'll send a patch
> when I am at home.

MRW support is in 2.6 since ages. The MRW flag is only detected on open,
so it should disappear from the proc file once you have opened the
drive. It has to be done that way, I'm afraid.

Other than that, it's not uncommon for the cap probe to fail somewhat on
older drives. So the 'info' file isn't always 100% reliable.

-- 
Jens Axboe

