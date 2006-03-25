Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWCYQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWCYQVg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCYQVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:21:36 -0500
Received: from cantor.suse.de ([195.135.220.2]:65244 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750861AbWCYQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:21:35 -0500
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: linux-kernel@vger.kernel.org, rgetz@blackfin.uclinux.org
Subject: Re: RFC: Non Power of 2 memory allocator
References: <6.1.1.1.0.20060325090152.01ec63f0@ptg1.spd.analog.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Mar 2006 17:21:30 +0100
In-Reply-To: <6.1.1.1.0.20060325090152.01ec63f0@ptg1.spd.analog.com>
Message-ID: <p73mzfepkad.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Getz <rgetz@blackfin.uclinux.org> writes:

> The  buddy system allocates things in power of 2 pages sizes (4k, 8k,
> 16k, 32k, 64k, 128k, 256k, 512k, 1024k), which works fine on most
> systems, but an embedded system, which is running without a MMU (
> Memory Management Unit) - RAM is precious, and when you only need
> 129k for an application, you don't want to allocate a power of 2,
> which gives you 256k -  an extra 127k, which can't be used by
> anything else.

In 2.4 I solved this problem at some point by just returning
the excess pages to the buddy allocator. There was even
a nice function to do this (alloc_exact)

That won't work for slab, but does for __get_free_pages() which
is better for large allocations anyways. slab imho doesn't make
sense for allocation anywhere bigger PAGE_SIZE/2. At some
point in 2.6 there was trouble with "compound pages" but I think
that has been resolved. 

Just implementing alloc_exact again would be the simplest solution
for your problem.

-Andi
