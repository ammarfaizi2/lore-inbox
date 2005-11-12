Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVKLBng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVKLBng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKLBng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:43:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbVKLBnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:43:35 -0500
Date: Fri, 11 Nov 2005 17:43:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, hugh@veritas.com,
       dvhltc@us.ibm.com, linux-mm@kvack.org, blaisorblade@yahoo.it,
       jdike@addtoit.com
Subject: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_REMOVE)
Message-Id: <20051111174309.5d544de4.akpm@osdl.org>
In-Reply-To: <1131755660.25354.81.camel@localhost.localdomain>
References: <1130366995.23729.38.camel@localhost.localdomain>
	<20051028034616.GA14511@ccure.user-mode-linux.org>
	<43624F82.6080003@us.ibm.com>
	<20051028184235.GC8514@ccure.user-mode-linux.org>
	<1130544201.23729.167.camel@localhost.localdomain>
	<20051029025119.GA14998@ccure.user-mode-linux.org>
	<1130788176.24503.19.camel@localhost.localdomain>
	<20051101000509.GA11847@ccure.user-mode-linux.org>
	<1130894101.24503.64.camel@localhost.localdomain>
	<20051102014321.GG24051@opteron.random>
	<1130947957.24503.70.camel@localhost.localdomain>
	<20051111162511.57ee1af3.akpm@osdl.org>
	<1131755660.25354.81.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > Why does madvise_remove() have an explicit check for swapper_space?
> 
> I really don't remember (I yanked code from some other kernel routine
> vmtruncate()).

I don't see such a thing anywhere.  vmtruncate() has the IS_SWAPFILE()
test, which I guess vmtruncate_range() ought to have too, for
future-safety.

Logically, vmtruncate() should just be a special case of vmtruncate_range().
But it's not - ugly, but hard to do anything about (need to implement
->truncate_range in all filesystems, but "know" which ones only support
->truncate_range() at eof).

> 
> > In your testing, how are you determining that the code is successfully
> > removing the correct number of pages, from the correct file offset?
> 
> I verified with test programs, added debug printk + looked through live
> "crash" session + verified with UML testcases.

OK, well please be sure to test it on 32-bit and 64-bit, operating in three
ranges of the file: <2G, 2G-4G amd >4G.

