Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWDYU00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWDYU00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDYU00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:26:26 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:11 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932286AbWDYU0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:26:25 -0400
Message-ID: <444E85E9.70300@argo.co.il>
Date: Tue, 25 Apr 2006 23:26:17 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bongani Hlope <bhlope@mweb.co.za>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <200604252211.52474.bhlope@mweb.co.za>
In-Reply-To: <200604252211.52474.bhlope@mweb.co.za>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 20:26:24.0197 (UTC) FILETIME=[859A2750:01C668A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope wrote:
> On Tuesday 25 April 2006 18:46, Avi Kivity wrote:
>   
>> Should you want to allocate from the heap, try this:
>>
>> {
>>     spinlock_t::guard g(some_lock);
>>     auto_ptr<Foo> item(new (gfp_mask) Foo);   /* or pass a kmem_cache_t */
>>     item->do_something();
>>     item->do_something_else();
>>     return item.release();
>> }
>>
>>     
>
> I love C++, but you have to stop it now. Imagine how many auto_ptr<Foo> will 
> you use inside your kernel. The compiler will need to create a separete class 
> for each. Using templates in the kernel will be plain silly.
>   
auto_ptr<>'s are fully inlined so their impact is nil.

(And actually I dislike C++, it only looks good next to C)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

