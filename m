Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUKJG5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUKJG5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 01:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKJG5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 01:57:04 -0500
Received: from peabody.ximian.com ([130.57.169.10]:3036 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261283AbUKJG5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 01:57:01 -0500
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc
	and	vmalloc)
From: Robert Love <rml@novell.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4191B5D8.3090700@gmx.net>
References: <4191A4E2.7040502@gmx.net>
	 <1100066597.18601.124.camel@localhost>  <4191B5D8.3090700@gmx.net>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 01:57:44 -0500
Message-Id: <1100069864.18601.128.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 07:31 +0100, Carl-Daniel Hailfinger wrote:

> Yes, but what do you suggest for the following problem:
> alloc(max_loop*sizeof(struct loop_device))
> 
> where sizeof(struct loop_device)==304 and 1<=max_loop<=16384
> 
> For the smallest allocation (304 bytes) vmalloc is clearly wasteful
> and for the largest allocation (~ 5 MBytes) kmalloc doesn't work.

Stab in the dark: Break it into two separate loops?

Two loops would be faster than the branch on each alloc, too.

Even better: Re-architect so as not to need that mess at all?

	Robert Love


