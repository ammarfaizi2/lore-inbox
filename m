Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWH1JA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWH1JA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWH1JA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:00:26 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:23539 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750969AbWH1JAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:00:25 -0400
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060825200359.GC13805@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com>
	 <20060825143842.GA27364@infradead.org>
	 <20060825200359.GC13805@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 28 Aug 2006 11:00:22 +0200
Message-Id: <1156755622.15093.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 15:03 -0500, Serge E. Hallyn wrote:
> Ok, the patch in -mm does kthread_stop() on module_exit, but still uses
> the timer and cmm_thread_wait.  

Yes, the timer and cmm_thread_wait are there to implement the timed page
pool.

> I'm not clear what the timer is actually trying to do, or why there is a
> separate cmm_pages_target and cmm_timed_pages_target.  So I'm sure the
> below patch on top of -mm2 is wrong (it compiles, but I just noticed
> 2.6.18-rc4-mm2 doesn't boot without this patch either) but hopefully
> Heiko or Martin can tell me what would be the right way, or implement
> it?

Yes, it is wrong. Trying to "fix" code without understanding it is waste
of time. The while loop in the cmm_thread is supposed to continue until
the target numbers for the standard page pool and the timed page pool
have been reached. Your patch adds a schedule_timeout between every call
to cmm_alloc_pages.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


