Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWCAT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWCAT2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWCAT2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:28:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:24726 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750936AbWCAT2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:28:03 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Wed, 1 Mar 2006 20:27:54 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200602282033.48570.ak@suse.de> <1141240823.2899.84.camel@localhost.localdomain>
In-Reply-To: <1141240823.2899.84.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012027.55494.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 20:20, Bryan O'Sullivan wrote:

> 
>         [...] the processor completely empties the write buffer by
>         writing the contents to memory as a result of performing any of
>         the following operations:
>         
>         SFENCE Instruction
>         Executing a store-fence (SFENCE) instruction forces all memory
>         writes before the SFENCE (in program order) to be written into
>         memory before memory writes that follow the SFENCE instruction.
>         The memory-fence (MFENCE) instruction has a similar effect, but
>         it forces the ordering of loads in addition to stores.
>         [...]
> 
> So in fact SFENCE is the appropriate, architecturally guaranteed, thing
> for us to be doing on x86_64.

I don't interpret it as being a full synchronous write. It's just a barrier
preventing reordering.  So the writes before could be in theory stuck
forever in some buffer - it just means they won't be later than the writes
after the fence.

Implementing the fences in the way your're suggesting would be very costly
because it could make them potentially stall for thousands of cycles.

I don't have a quote handy right now but volume 3 of the Intel/AMD manuals
have own chapters on the memory ordering rules elaborating on this in much more
detail.

-Andi
