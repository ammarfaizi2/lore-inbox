Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbULHAzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbULHAzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbULHAzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:55:09 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:53888 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261977AbULHAzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:55:03 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208003736.GD16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de>
	 <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org>
	 <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 11:54:13 +1100
Message-Id: <1102467253.8095.10.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 01:37 +0100, Andrea Arcangeli wrote:
> On Thu, Dec 02, 2004 at 08:52:36PM +0100, Jens Axboe wrote:
> > with its default io scheduler has basically zero write performance in
> 
> IMHO the default io scheduler should be changed to cfq. as is all but
> general purpose so it's a mistake to leave it the default (plus as Jens

I think it is actually pretty good at general purpose stuff. For
example, the old writes starve reads thing. It is especially bad
when doing small dependent reads like `find | xargs grep`. (Although
CFQ is probably better at this than deadline too).

It also tends to degrade more gracefully under memory load because
it doesn't require much readahead.

> found the write bandwidth is not existent during reads, no surprise it
> falls apart in any database load). We had to make the cfq the default
> for the enterprise release already. The first thing I do is to add
> elevator=cfq on a new install. I really like how well cfq has been
> designed, implemented and turned, Jens's results with his last patch are
> quite impressive.
> 

That is synch write bandwidth. Yes that seems to be a problem.



