Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbULBToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbULBToW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULBToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:44:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:20449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261736AbULBToT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:44:19 -0500
Date: Thu, 2 Dec 2004 11:48:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041202114836.6b2e8d3f.akpm@osdl.org>
In-Reply-To: <20041202134801.GE10458@suse.de>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> as:
> Reader: 27985KiB/sec (max_lat=34msec)
> Writer:    64KiB/sec (max_lat=1042msec)
> 
> cfq:
> Reader: 12703KiB/sec (max_lat=108msec)
> Writer:  9743KiB/sec (max_lat=89msec)
> 
> If you look at vmstat while running these tests, cfq and deadline give
> equal bandwidth for the reader and writer all the time, while as
> basically doesn't give anything to the writer (a single block per second
> only). Nick, is the write batching broken or something?

Looks like it.  We used to do 2/3rds-read, 1/3rd-write in that testcase.
