Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWATBrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWATBrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWATBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:47:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422727AbWATBrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:47:41 -0500
Date: Thu, 19 Jan 2006 17:49:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: AChittenden@bluearc.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Jens Axboe <axboe@suse.de>
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060119174920.4a842f03.akpm@osdl.org>
In-Reply-To: <20060120012844.GE3798@redhat.com>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
	<20060119194836.GM21663@redhat.com>
	<20060119170305.2e8ae353.akpm@osdl.org>
	<20060120012844.GE3798@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> The Fedora user in the bug report
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
> who on x86-64 with 5GB saw zone_dma exhausted saw a similar result,
> delays the kill, but it does still happen.

Again, that person's ZONE_DMA has *zero* pages on the LRU.  Something has
consumed all of the piddling little zone for kernel data structures.  It is
a true oom.

We need to work out who is using all this ZONE_DMA memory and make them
stop it.

