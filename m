Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVJ1H1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVJ1H1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVJ1H1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:27:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65053 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965169AbVJ1H1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:27:48 -0400
Date: Fri, 28 Oct 2005 09:28:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051028072833.GE11441@suse.de>
References: <5455.1130484079@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5455.1130484079@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28 2005, Keith Owens wrote:
> fs/bio.c: In function 'bio_alloc_bioset':
> fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

This is bogus. bio_alloc_bioset() passes in a pointer to a long which
bvec_alloc_bs() always fills, _unless_ it returns NULL. In the NULL case
we never use 'idx' (quite obvious, we bail immediately).

I didn't check the other warnings, but there may be similar cases in
other paths.

-- 
Jens Axboe

