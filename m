Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVKUKEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVKUKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVKUKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:04:09 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:29849 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932209AbVKUKEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:04:08 -0500
In-Reply-To: <437DFBB3.mailLJC11TKEB@suse.de>
References: <437DFBB3.mailLJC11TKEB@suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <31100cb5abcb16617981e6923dd165d0@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: (no subject)
Date: Mon, 21 Nov 2005 10:06:03 +0000
To: "Andi Kleen" <ak@suse.de>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Nov 2005, at 16:05, Andi Kleen wrote:

> I don't think you can do that. We still need these functions in low
> level architecture code at least.
>
> Using __pa/__va doesn't cut it because it won't work on Xen guests
> which have different views on bus vs physical addresses. The Xen
> code is (hopefully) in the process of being merged, so intentionally
> breaking them isn't a good idea.
>
> So if anything there would need to be replacement functions for it
> first that do the same thing. But why not just keep the old ones?

We could make use of virt_to_machine/machine_to_virt instead, which 
arguably better describe the intent of those functions. Currently we 
only use virt_to_bus/bus_to_virt in our swiotlb implementation, and our 
modified dma_map code. In those files I think the existing function 
names make some sense, but we can easily change if that's preferred.

  -- Keir

