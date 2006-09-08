Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWIHPoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWIHPoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWIHPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:44:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62123 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750866AbWIHPoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:44:00 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: sekharan@us.ibm.com, balbir@in.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org
In-Reply-To: <45011CAC.2040502@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>  <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>  <45011CAC.2040502@openvz.org>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 08:43:41 -0700
Message-Id: <1157730221.26324.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:33 +0400, Pavel Emelianov wrote:
> I'm afraid we have different understandings of what a "guarantee" is.

It appears so.

> Don't we?
> Guarantee may be one of
> 
>   1. container will be able to touch that number of pages
>   2. container will be able to sys_mmap() that number of pages
>   3. container will not be killed unless it touches that number of pages

A "death sentence" guarantee?  I like it. :)

>   4. anything else
> 
> Let's decide what kind of a guarantee we want.

I think of it as: "I will be allowed to use this many total pages, and
they are guaranteed not to fail."  (1), I think.  The sum of all of the
system's guarantees must be less than or equal to the amount of free
memory on the machine.  

If we knew to which NUMA node the memory was going to go, we might as
well take the pages out of the allocator.

-- Dave

