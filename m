Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWCUHFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWCUHFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCUHFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:05:21 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61399 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932258AbWCUHFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:05:20 -0500
Date: Tue, 21 Mar 2006 09:05:14 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Nathan Scott <nathans@sgi.com>
cc: xfs-masters@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: kill kmem_zone init
In-Reply-To: <20060321082037.A653275@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0603210859450.14023@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI>
 <20060321082037.A653275@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Nathan Scott wrote:
> Sorry, but thats just silly.  Did you even look at the code
> around what you're changing (it has to do more than just wrap
> up slab calls)?  So, NACK on this patch - it leaves the code
> very confused (half zoney, half slaby), and is just unhelpful
> code churn at the end of the day.

You're already using kmem_cache_destroy() mixed with the zone stuff so I 
don't see your point. I would really prefer to feed small bits at a time 
so is there any way I can sweet-talk you into merging the patch?

On Tue, 21 Mar 2006, Nathan Scott wrote:
> For your zalloc patch, you will need to duplicate the logic
> in kmem_zone_alloc into kmem_zone_zalloc in order to use that
> new zalloc interface you're introducing - which should be fine.

I am planning to kill the slab wrappers completely. The logic you're 
referring to looks awful lot like GFP_NOFAIL with limiter. Any 
reason we can't just use GFP_NOFAIL for those cases?

				Pekka 
