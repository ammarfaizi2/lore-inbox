Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTFVIjY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTFVIjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:39:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40162 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264027AbTFVIjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:39:23 -0400
Date: Sun, 22 Jun 2003 10:50:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@digeo.com>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd driver 2.5+: fix for incorrect struct bio usage
Message-ID: <20030622085006.GH608@suse.de>
References: <3EF4D2C8.6060608@aros.net> <20030621151818.081139fc.akpm@digeo.com> <3EF4E5A9.5010802@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF4E5A9.5010802@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21 2003, Lou Langholtz wrote:
> Here's a possible patch #2... I believe the address pointed to by 
> bio_data(bio) is not always contiguous over the length of bio->bi_size 
> and was responsible for locking my machine up sometimes. My biggest 
> reason for apprehension on believeing that I'm 100% correct on this is 
> that there's still what appears to be a source of memory corruption in 
> the patchlet modified nbd driver even after this patch. I know the 
> driver is still not correctly notifying processes of the bytesize on 
> open but the size reported appears to be big enough. Anyway, thanks for 
> all of the feedback so far!!!!

You are correct, the current code breaks down for multi-page bio's. It
looks like you are missing a kmap still though, bvec->bv_page could be a
highmem page.

-- 
Jens Axboe

