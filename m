Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWGXRIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWGXRIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWGXRIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:08:07 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:43214 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932221AbWGXRIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:08:06 -0400
Date: Mon, 24 Jul 2006 07:55:15 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: yunfeng zhang <zyf.zeroos@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
In-Reply-To: <4df04b840607240201l19f95f8cu12dca42de71dba69@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0607240752050.8221@qynat.qvtvafvgr.pbz>
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
 <4df04b840607240201l19f95f8cu12dca42de71dba69@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, yunfeng zhang wrote:

> How to let memory subsystem allocate bigger consecutive memory pages? In 
> current
> Linux, to driver programmer it's always failed to issue a request to 
> alloc_pages
> with a enough larger order parameter, or it's diffult to allocate a bigger
> consecutive physical memory block.
>
> The reason causing the problem, I think, are the items listed below
> 1) Core space has a static mapping relationship with physical memory pages. 
> So
> once a core page is allocated, its core address is also fixed, it prevents 
> the
> physical pages around it to conglomerate together.
> 2) Current physical page management arithmetic is buddy arithmetic. The main
> advantage of its is that pages managed by it is always aligned by 2 power. 
> But,
> is it necessary or there is any hardware which need physical memory pages
> aligned by 2 or more power?
>
> The solution is
> 1) Using dynamic page mapping on core space. So we can move all core pages
> freely anytime to conglomerate bigger consecutive memory pages, a new 
> background
> daemon thread -- RemapDaemon can do conglomeration periodly.

this gets discussed periodicly, however the performance hit of doing the mapping 
for all core memory accesses is something that the developers have not been 
willing to accept.

> 2) Using another page management arithmetic instead of buddy, the minimum 
> unit
> of new arithmetic should be page. In fact, I think dlmalloc arithmetic is a 
> good
> candidate, it's also page conglomeration-affinity.

experiment, if it's as good as you think it will be post the numbers an you will 
get a lot of attention. quite a few people are working on the memory allocation 
for various things, therea re a lot of useage patterns to balance (and avaid 
pathalogical problems with).

David Lang
