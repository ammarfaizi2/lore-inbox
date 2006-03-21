Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWCUHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWCUHOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCUHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:14:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20696 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932283AbWCUHOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:14:02 -0500
Date: Tue, 21 Mar 2006 09:13:49 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Balbir Singh <balbir@in.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
In-Reply-To: <661de9470603200845r6c06ae46tc49be9559c5bfc77@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603210912250.14023@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI> 
 <20060320160500.GA25415@in.ibm.com>  <1142871263.11694.4.camel@localhost>
 <661de9470603200845r6c06ae46tc49be9559c5bfc77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Balbir Singh wrote:
> When I allocate the structure - I would like to do
> 
> kmem_cache_alloc_set(&resp, GFP_XXXXX, 0xEE)
> 
> The device should ideally fill all fields of resp. Fields that look
> 0xEE after receiving the response -- would indicate that they were not
> filled by the device. This would be extremely useful in debugging.
> With kmem_cache_zalloc() - 0 is usually almost always a valid value.
> It is useful in some cases and no so much in other cases.
> 
> I could easily achieve the same thing by doing a
> 
> memset(&resp, 0xEE, size)
> 
> after the kmem_cache_alloc(). But since there is an API to zero out
> allocated memory, I thought we could make it more generic and more
> useful.

Yeah, but if it's a debugging thing, I don't see much point in adding yet 
another API call. The main point in introducing kmem_cache_zalloc() is to 
move existing API into slab proper.

				Pekka
