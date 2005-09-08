Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVIHNBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVIHNBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVIHNBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:01:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2805 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932509AbVIHNBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:01:17 -0400
Date: Thu, 8 Sep 2005 18:44:27 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using CPUSETS
Message-ID: <20050908131427.GA5994@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050908053912.1352770031@sv1.valinux.co.jp> <20050908002323.181fd7d5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908002323.181fd7d5.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Interesting implementation of resource controls. Cross posting this 
to ckrm-tech as well. I am sure CKRM folks have something to say...

Any thoughts about how you want to add more resource control features
on top of/in addition to this setup. (Such as memory etc)


On Thu, Sep 08, 2005 at 12:23:23AM -0700, Paul Jackson wrote:
> I'm guessing you do not want such cpusets (the parents of subcpusets)
> to overlap, because if they did, it would seem to confuse the meaning
> of getting a fixed proportion of available cpu and memory resources.  I
> was a little surprised not to see any additional checks that
> cpu_exclusive and mem_exclusive must be set true in these cpusets, to
> insure non- overlapping cpusets.

I agree with Paul here. You would want to build your controllers
on top of exclusive cpusets to keep things sane.

> On the other hand, Dinakar had more work to do than you might, because
> he needed a complete covering (so had to round up cpus in non exclusive
> cpusets to form more covering elements).  From what I can tell, you
> don't need a complete covering - it seems fine if some cpus are not
> managed by this resource control function.


I think it makes more sense to add this functionality directly as part
of the existing cpusets instead of creating further leaf cpusets (or subcpusets
as you call it) where we can specify resource control parameters. I think that 
approach would be much more intuitive and simple to work with rather than 
what you have currently. 

	-Dinakar
