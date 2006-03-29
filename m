Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWC2IXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWC2IXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWC2IXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 03:23:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45403 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750783AbWC2IXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 03:23:39 -0500
Date: Wed, 29 Mar 2006 10:23:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org
Cc: agk@redhat.com
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060329082343.GV8186@suse.de>
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org> <20060327061021.GT1173973@melbourne.sgi.com> <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr> <20060328213845.GO25288@asteria.noreply.org> <20060329074214.D871924@wobbly.melbourne.sgi.com> <20060329005917.GR25288@asteria.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329005917.GR25288@asteria.noreply.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Peter Palfrader wrote:
> On Wed, 29 Mar 2006, Nathan Scott wrote:
> 
> > You'll be better off trying the bio_clone fix discussed in the
> > other (ext3-bio_clone-panic) thread than go down this route
> > (there is a fix in 2.6.16.1 apparently - start there).  Certainly
> > try that before attempting to revert these changes anyway.
> 
> The problem persists on 2.6.16.1.

The original oops showed the path into bio_clone() originating from
crypt_alloc_buffer() in dm-crypt.c - and blk_recount_segments() is
oopsinig in page_to_pfn(), meaning that the most likely cause of this is
dm-crypt passing in a bio with invalid ->bi_idx and/or ->bi_vcnt. At
least they are not matching what ->bi_io_vec[] holds.

-- 
Jens Axboe

