Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUJOASj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUJOASj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJNS0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:26:20 -0400
Received: from mail6.iserv.net ([204.177.184.156]:50832 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S266793AbUJNRa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:30:26 -0400
Message-ID: <416EB7AD.4040302@didntduck.org>
Date: Thu, 14 Oct 2004 13:30:21 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin K. Petersen" <mkp@wildopensource.com>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
References: <yq1oej5s0po.fsf@wilson.mkp.net>
In-Reply-To: <yq1oej5s0po.fsf@wilson.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin K. Petersen wrote:
> A while back Bill Irwin converted the page table code on ppc64 to use
> a zeroed page slab.  I recently did the same on ia64 and got a
> significant performance improvement in terms of fault time (4 usec ->
> 700 nsec).
> 
> This cache needs to be initialized fairly early on and so far we've
> called it from pgtable_cache_init() on both archs.  However, Tony Luck
> thought it might be useful to have a general purpose slab cache with
> zeroed pages.  And other architectures might decide to use it for
> their page tables too.
> 
> Consequently here's a patch that puts this functionality in slab.c.
> 
> Signed-off-by: Martin K. Petersen <mkp@wildopensource.com>
> 

This doesn't work as you expect it does.  The constructor is only called 
when a new slab is created, for each new object on the slab.  It is 
_not_ run again when an object is freed.  So if a page is freed then 
immediately reallocated it will contain garbage.

--
				Brian Gerst
