Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbULBNsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbULBNsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULBNsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:48:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23239 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261622AbULBNs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:48:29 -0500
Date: Thu, 2 Dec 2004 14:48:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041202134801.GE10458@suse.de>
References: <20041202130457.GC10458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202130457.GC10458@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One more test case, while the box is booted... This just demonstrates a
process doing a file write (bs=64k) with a competing process doing a
file read (bs=64k) at the same time, again capped at 30sec.

deadline:
Reader:  2520KiB/sec (max_lat=45msec)
Writer:  1258KiB/sec (max_lat=85msec)

as:
Reader: 27985KiB/sec (max_lat=34msec)
Writer:    64KiB/sec (max_lat=1042msec)

cfq:
Reader: 12703KiB/sec (max_lat=108msec)
Writer:  9743KiB/sec (max_lat=89msec)

If you look at vmstat while running these tests, cfq and deadline give
equal bandwidth for the reader and writer all the time, while as
basically doesn't give anything to the writer (a single block per second
only). Nick, is the write batching broken or something?

-- 
Jens Axboe

