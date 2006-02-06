Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWBFJD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWBFJD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWBFJDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:03:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28878 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750807AbWBFJDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:03:23 -0500
Date: Mon, 6 Feb 2006 01:03:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206010304.e79ca2e5.pj@sgi.com>
In-Reply-To: <20060206084001.GA5600@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
	<20060206001959.394b33bc.pj@sgi.com>
	<20060206082258.GA1991@elte.hu>
	<20060206084001.GA5600@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> I.e. the 
> spreading out, as it is used today, is rather a global fairness setting 
> for the kernel, and not really a workload-specific access-pattern thing.  
> Right?

I'm not quite sure where you're going with this, but I doubt I agree.
It's job specific, and cache specific.

If the job has a number of threads hitting the same data set and:
 1) the data set is faulted in non-uniformly (perhaps some
    job init task reads it in), and
 2) the data set is accessed with little thread locality
    (one thread is as likely as the next to read or write
    a particular page),
then for that job spreading makes sense.

If the cache is one that goes with a data set, such as file system
buffers (page cache) and inode and dentry slab caches, then for that
cache spreading makes sense.  (Yes Andrew, your xfs query is still in my
queue.)

But for many (most?) other jobs and other caches, the default node-local
policy is better.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
