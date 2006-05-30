Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWE3HWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWE3HWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 03:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWE3HWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 03:22:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:4070 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932148AbWE3HWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 03:22:07 -0400
Subject: Re: [PATCH] powerpc vdso updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060530062447.GD19870@elte.hu>
References: <1148961097.15722.11.camel@localhost.localdomain>
	 <20060530062447.GD19870@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 17:21:40 +1000
Message-Id: <1148973700.15722.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> get_unmapped_area() without holding the mmap semaphore seems dangerous. 
> The VDSO setup itself should be 'private' to the process, but i'm not 
> totally sure that no other kernel code could get access to this mm. For 
> example the swapout code? Am i missing something?

Well, all of this happens so early, I doubt anything will cause actual
harm, for get_unmapped_area to be a problem, something would have to
concurrently allocate a VMA (or dispose of) I think that can't happen at
this point before we even run the binary but yes, better safe than
sorry... I supose the whole patch could get in 2.6.17 even without the
arch_vma_name (that is it can be there, it wont be used though until
your patch gets in).

Ben.


