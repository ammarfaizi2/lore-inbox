Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUI0J4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUI0J4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUI0J4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:56:55 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:17839 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266603AbUI0J4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:56:53 -0400
Message-ID: <4157CDFD.5030001@yahoo.com.au>
Date: Mon, 27 Sep 2004 18:23:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
In-Reply-To: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:
> Since upgrading from -mm3 to -mm4, I'm now getting messages like this 
> logged every second or so:
> 
> Sep 27 18:28:06 tornado kernel: using smp_processor_id() in preemptible 
> 

snip

> 
> Is there a fix to shut this all up or a suggested patch to revert?
> 
> Box is a P4 Intel 2.8Ghz single processor, SMP/HT with PREEMPT on..
> 

Looks like disk_stat_add in the sw-raid code. The proper fix is probably
to disable preempt around those regions - but just doing it the dumb
way (ie. in the driver code) looks like an unfortunate layering violation.

Maybe something like disk_stat_update_start / disk_stat_update_end that
gives you the per-cpu stat pointer as a "token" to be used by
disk_stat_inc/add/etc. Anyone?

Named slightly differently, so you keep backward compatibility, of course.
