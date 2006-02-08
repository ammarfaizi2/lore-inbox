Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWBHXgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWBHXgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWBHXgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:36:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422636AbWBHXgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:36:32 -0500
Date: Wed, 8 Feb 2006 15:35:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208153551.04ee0c67.akpm@osdl.org>
In-Reply-To: <200602082341.02243.ak@suse.de>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<20060208133909.183f19ea.akpm@osdl.org>
	<Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
	<200602082341.02243.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> 
> Unfortunately Andrew's point with the GFP_NOFS still applies :/
> But I would consider any caller of this not handling NULL be broken.

Sure.

> Andrew do you have any stronger evidence it's a real problem?

No.  About a million years ago I had a make-alloc_pages-fail-at-1%-rate
debug patch.  Doing that again would be an interesting exercise.

Another option is to only fail userspace allocations (__GFP_HIGHMEM is set,
or a new flag in GFP_HIGHUSER).  For the workloads which the NUMA guys care
about I expect this is a 99% solution and the amount of code which it puts
at risk is vastly less.

