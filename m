Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUHWLpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUHWLpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUHWLpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:45:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12436 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263540AbUHWLpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 07:45:36 -0400
Date: Mon, 23 Aug 2004 13:43:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-ID: <20040823114329.GI2301@suse.de>
References: <m33c2py1m1.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c2py1m1.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14 2004, Peter Osterlund wrote:
> Hi!
> 
> This patch replaces the pd->bio_queue linked list with an rbtree.  The
> list can get very long (>200000 entries on a 1GB machine), so keeping
> it sorted with a naive algorithm is far too expensive.

It looks like you are assuming that bio->bi_sector is unique which isn't
necessarily true. In that respect, list -> rbtree conversion isn't
trivial (or, at least it requires extra code to handle this).

-- 
Jens Axboe

