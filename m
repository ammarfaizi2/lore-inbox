Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWERIDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWERIDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWERIDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:03:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52454 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751170AbWERIDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:03:08 -0400
Date: Thu, 18 May 2006 10:03:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] free_pgtables deadlock
Message-ID: <20060518080308.GC30387@elte.hu>
References: <200605141604.k4EG4oQ1005635@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605141604.k4EG4oQ1005635@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Following is a fix for this deadlock .
> 
> What's happening is task 2 holds the i_mmap_lock from unmap_region(), 
> then it enters zap_page_range() where it tried to acquire the locked 
> mmu_gathers percpu .
> 
> While task 1) holds the mmu_gathers percpu lock from unmap_region() 
> and then tried to aquire i_mmap_lock inside unlink_file_vma() .
> 
> It looks like it's possible to drop the mmu_gathers prior to calling 
> unlink_file_vma() , but it's only done if there's more than one vma .
> 
> This deadlock was seen by Deepak Saxena on an ARM Versatile board.

thanks, applied.

	Ingo
