Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUH3Ve5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUH3Ve5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUH3Ve5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 17:34:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:23985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262837AbUH3Vez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:34:55 -0400
X-Authenticated: #20450766
Date: Mon, 30 Aug 2004 23:34:04 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: NUMA for abstract bus-masters (was Re: sched_domains + NUMA issue)
In-Reply-To: <20040829164825.GI5492@holomorphy.com>
Message-ID: <Pine.LNX.4.60.0408302153570.4164@poirot.grange>
References: <20040829111855.GB26072@krispykreme> <20040829164825.GI5492@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I recently raised a discussion on the ARM-kernel ml, so, I just want to 
check if it would raise any interest here.

I was thinking about architectures, where multiple memory (RAM) pools 
exist on different buses, and various bus-masters on the system have 
different distances to various RAMs. Say, distance can be defined as the 
number of bridges to cross, if that RAM is at all accessible, or infinity 
otherwise.

The API would on one hand allow to register such RAM pools at different 
locations, and on the other hand, requests for RAM with a device pointer 
([dma|pci]_alloc_*) would try to find the nearest RAM available.

And one would have to optimise those allocated buffers for n (typically 2) 
bus-masters (e.g., CPU and a device) with various weights...

And the idea would be to re-use (some of) the NUMA framework.

This would be another approach to tackle problems, addressed by the James' 
dma_declare_coherent_memory patch.

So, does this at all sound reasonable? Anybody finds it useful?

Thanks
Guennadi
---
Guennadi Liakhovetski

