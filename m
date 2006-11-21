Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030731AbWKUIiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030731AbWKUIiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030737AbWKUIiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:38:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030731AbWKUIiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:38:12 -0500
Date: Tue, 21 Nov 2006 00:37:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Raskin <a1d23ab4@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
Message-Id: <20061121003745.aeda4f7c.akpm@osdl.org>
In-Reply-To: <45614A95.6090102@mail.ru>
References: <45614A95.6090102@mail.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 09:26:29 +0300
Michael Raskin <a1d23ab4@mail.ru> wrote:

> Short description: when X is loaded (maybe any heavy application is 
> sufficient, but I don't use anything heavy in console), 'free' says used 
> memory is growing.
> 
> Keywords: memory.
> 
> Kernel: built locally, gcc 4.0.3
> 
> I have a strange problem with 2.6.19-rc-mm kernels. After I load X, I 
> notice that memory is marked used at rate of tens of KB/s. Then it 
> starts to swap very heavily, when physical memory is all used. I tried 
> to verify it - it is so with all -mm kernels after 2.6.19-rc1-mm1, 
> including 2.6.19-rc5-mm2. At the meantime everything works OK with 
> kernels 2.6.18-mm3 and 2.6.19-rc1 through 2.6.19-rc6. I do not see any 
> options that should be memory eating in my .config . Module list is 
> short enough to include inline.
> 
> When I just run some things like periodical suck, oops proxy server etc 
> with X shut down, I do not notice "leak" from console because of small 
> fluctuations of memory use. When I run X and shut it down, used memory 
> count goes up a few megs (consistent with speed of eating it by X).
> 
> I didn't find exactly this problem in lkml or www, though the problem 
> with OOM on 2.6.19-rc-mm seems similar.
> 
> What should I check to fix problem or produce a useful bug report?

Monitor /proc/meminfo

If the leak is slab, monitor /proc/slabinfo and /proc/slab_allocators.
/proc/slab_allocators needs CONFIG_DEBUG_SLAB_LEAK.

Thanks.
