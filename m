Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVKPUYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVKPUYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVKPUYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:24:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:14736 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030471AbVKPUYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:24:46 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
In-Reply-To: <20051113152214.GC2193@spitz.ucw.cz>
References: <20051114212341.724084000@sergelap>
	 <20051114153649.75e265e7.pj@sgi.com>
	 <20051115055107.GB3252@IBM-BWN8ZTBWAO1>
	 <20051113152214.GC2193@spitz.ucw.cz>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 21:24:39 +0100
Message-Id: <1132172679.5937.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 15:22 +0000, Pavel Machek wrote:
> > @@ -2925,7 +2925,7 @@ void submit_bio(int rw, struct bio *bio)
> >  	if (unlikely(block_dump)) {
> >  		char b[BDEVNAME_SIZE];
> >  		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
> > -			current->comm, current->pid,
> > +			current->comm, task_pid(current),
> >  			(rw & WRITE) ? "WRITE" : "READ",
> >  			(unsigned long long)bio->bi_sector,
> >  			bdevname(bio->bi_bdev,b));
> 
> ...and now printk is close to useless, because uer can't know to which
> pidspace that pid belongs. Oops.

That is true, but only if we print the virtualized pid.  Before we go
and actually implement the pid virtualization, we probably need a
thorough audit of this kind of stuff to see what we really want.

There will always be a "real pid" (the real thing in tsk->__pid) backing
whatever is virtualized and presented to getpid().  I would imagine that
this is the same that needs to go into dmesg.  

-- Dave

