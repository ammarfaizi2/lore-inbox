Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVKPSjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVKPSjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKPSjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:39:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41642 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030434AbVKPSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:39:01 -0500
Date: Sun, 13 Nov 2005 15:22:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051113152214.GC2193@spitz.ucw.cz>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115055107.GB3252@IBM-BWN8ZTBWAO1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115055107.GB3252@IBM-BWN8ZTBWAO1>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Have you crosstool'd built this for most arch's?  I could imagine
> > some piece of code having a local or other struct variable named 'pid'
> > that would be broken by a mistake in this change.  This could be so
> > whether the change was done by a script, or by hand.  Probably need
> > to test 'allyesconfig' too.
> 
> Argh - in fact it appears I compiled and booted my 2.6.14 version,
> not this 2.6.15-rc1 version.  Another patch is needed for this to
> compile and boot (on a power5 system, in addition to a patch pending
> for -mm to make rpaphp_pci compile).  Sorry.

> @@ -2925,7 +2925,7 @@ void submit_bio(int rw, struct bio *bio)
>  	if (unlikely(block_dump)) {
>  		char b[BDEVNAME_SIZE];
>  		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
> -			current->comm, current->pid,
> +			current->comm, task_pid(current),
>  			(rw & WRITE) ? "WRITE" : "READ",
>  			(unsigned long long)bio->bi_sector,
>  			bdevname(bio->bi_bdev,b));

...and now printk is close to useless, because uer can't know to which
pidspace that pid belongs. Oops.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

