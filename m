Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVBRO0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVBRO0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVBRO0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:26:47 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:61315 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S261208AbVBRO0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:26:42 -0500
Date: Fri, 18 Feb 2005 09:26:07 -0500
From: Philip R Auld <pauld@egenera.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio refcount problem
Message-ID: <20050218142607.GB14362@vienna.egenera.com>
References: <20050218125414.GA14362@vienna.egenera.com> <20050218135931.GG4056@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218135931.GG4056@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rumor has it that on Fri, Feb 18, 2005 at 02:59:32PM +0100 Jens Axboe said:
> On Fri, Feb 18 2005, Philip R Auld wrote:

...
> > Or make all users of submit_bio take and release and extra reference
> > like submit_bh.
> 
> The queue lock is still held at that point, so the driver hasn't had a
> chance to process the request yet.

Interesting. This is not a theoretical problem though. I've got traces of 
the oops showing the bio getting freed before the bio_sync(bio) test. 
When you say driver here what level do you mean? scsi_request_fn at 
least drops the queue lock. 

What if it's merged instead of added directly? That could also get to
the same place.

The end_io callback _is_ getting called before __make_request 
does its "if(bio_sync(bio))" test. 


Cheers,

Phil


> 
> -- 
> Jens Axboe

-- 
Philip R. Auld, Ph.D.  	        	       Egenera, Inc.    
Software Architect                            165 Forest St.
(508) 858-2628                            Marlboro, MA 01752
