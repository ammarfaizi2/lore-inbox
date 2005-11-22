Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVKVR3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVKVR3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVKVR3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:29:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:41636 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965025AbVKVR3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:29:06 -0500
Date: Tue, 22 Nov 2005 12:26:23 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rfc/rft: use r10 as current on x86-64
Message-ID: <20051122172622.GI1127@kvack.org>
References: <20051122165204.GG1127@kvack.org> <20051122171040.GY20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122171040.GY20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:10:42PM +0100, Andi Kleen wrote:
> I think you could get most of the benefit by just dropping
> the volatile and "memory" from read_pda(). With that gcc would
> usually CSE current into a register and it would would work essentially
> the same way with only minor more .text overhead, but r10 would be still
> available.
> 
> Unfortunately when that's done then the kernel doesn't boot.
> It's probably something silly, but i never had time to track it down.
> Might want to look into that?

Without even fixing it, the difference in kernel code size is still 20K 
less than what using a register does.  The benefit of using a register is
that accessing a field in current can simply offset the register, compared 
to the pda usage that requires loading current into a register before the 
offset is performed.  Using 'size' on the resulting kernels shows:

   text    data     bss     dec     hex filename
4132289  819632  317256 5269177  5066b9 vmlinux.orig
4119951  819632  317256 5256839  503687 vmlinux.non-volatile
4097300  819560  317256 5234116  4fddc4 vmlinux.r10

I think that using a register makes more sense given the benefits.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
