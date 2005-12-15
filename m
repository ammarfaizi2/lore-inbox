Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbVLOM7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbVLOM7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbVLOM7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:59:34 -0500
Received: from smtpout.mac.com ([17.250.248.70]:23777 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422709AbVLOM7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:59:33 -0500
In-Reply-To: <200512152345.25375.kernel@kolivas.org>
References: <20051215033937.GC11856@waste.org> <20051215.002120.133621586.davem@davemloft.net> <9E6D85FF-E546-4057-80EF-7479021AFAA1@mac.com> <200512152345.25375.kernel@kolivas.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8803F1D1-E647-45A3-B2A4-E3C95AAC11C6@mac.com>
Cc: "David S. Miller" <davem@davemloft.net>, sri@us.ibm.com, mpm@selenic.com,
       ak@suse.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Fine-grained memory priorities and PI
Date: Thu, 15 Dec 2005 07:58:45 -0500
To: Con Kolivas <kernel@kolivas.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 15, 2005, at 07:45, Con Kolivas wrote:
> I have some basic process-that-called the memory allocator link in  
> the -ck tree already which alters how aggressively memory is  
> reclaimed according to priority. It does not affect out of memory  
> management but that could be added to said algorithm; however I  
> don't see much point at the moment since oom is still an uncommon  
> condition but regular memory allocation is routine.

My thought would be to generalize the two special cases of writeback  
of dirty pages or dropping of clean pages under memory pressure and  
OOM to be the same general case.  When you are trying to free up  
pages, it may be permissible to drop dirty mbox pages and kill the  
postfix process writing them in order to satisfy allocations for the  
mission-critical database server.  (Or maybe it's the other way  
around).  If a large chunk of the allocated pages have priorities and  
lossless/lossy free functions, then the kernel can be much more  
flexible and configurable about what to do when running low on RAM.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


