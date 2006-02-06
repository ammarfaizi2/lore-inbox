Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWBFEiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWBFEiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWBFEiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:38:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750977AbWBFEiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:38:09 -0500
Date: Sun, 5 Feb 2006 20:37:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205203711.2c855971.akpm@osdl.org>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> This policy can provide substantial improvements for jobs that
>  need to place thread local data on the corresponding node, but
>  that need to access large file system data sets that need to
>  be spread across the several nodes in the jobs cpuset in order
>  to fit.  Without this patch, especially for jobs that might
>  have one thread reading in the data set, the memory allocation
>  across the nodes in the jobs cpuset can become very uneven.


It all seems rather ironic.  We do vast amounts of development to make
certain microbenchmarks look good, then run a real workload on the thing,
find that all those microbenchmark-inspired tweaks actually deoptimised the
real workload?  So now we need to add per-task knobs to turn off the
previously-added microbenchmark-tweaks.

What happens if one process does lots of filesystem activity and another
one (concurrent or subsequent) wants lots of thread-local storage?  Won't
the same thing happen?

IOW: this patch seems to be a highly specific bandaid which is repairing an
ill-advised problem of our own making, does it not?
