Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUHDWgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUHDWgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267485AbUHDWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:36:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10182 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267482AbUHDWfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:35:16 -0400
Date: Wed, 4 Aug 2004 15:33:10 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] subset zonelists and big numa friendly mempolicy
 MPOL_MBIND
Message-Id: <20040804153310.618413cb.pj@sgi.com>
In-Reply-To: <20040803020805.060620fa.ak@suse.de>
References: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
	<20040803020805.060620fa.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of days ago, Andi wrote:
> My first reaction that if you really want to do that, just pass
> the policy node bitmap to alloc_pages and try_to_free_pages
> and use the normal per node zone list with the bitmap as filter. 

I have coded your suggestion up, and indeed, it is much simpler

I added an optional (#ifdef CONFIG_CPUSET) "mems_allowed" field to the
task_struct, and filter zones on this mask (if not in_interrupt()) in
the page allocation and free'ing code.

Thank-you.  I think you're right, and it's the way to go.

I will be posting a full cpuset patch that includes this change on
lse-tech and lkml, hopefully in a few hours.  I will be most grateful
for any further feedback.

Providing support for dividing very large systems into subsets of
nodes (cpu and memory), in order to obtain good memory locality and
good isolation of big jobs from each other, is essential to the success
of certain high end Linux users.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
