Return-Path: <linux-kernel-owner+w=401wt.eu-S964909AbXADQ56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbXADQ56 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXADQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:57:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54324 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964909AbXADQ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:57:57 -0500
Date: Thu, 4 Jan 2007 22:27:27 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070104165727.GA18088@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104155649.GB27603@in.ibm.com> <20070104163139.GA312@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104163139.GA312@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 07:31:39PM +0300, Oleg Nesterov wrote:
> > AFAIK this deadlock originated from Andrew's patch here:
> >
> > 	http://lkml.org/lkml/2006/12/7/231
> 
> I don't think so. The core problem is not that we are doing unlock/sleep/lock
> with this patch. The thing is: work->func() can't take wq_mutex (and thus use
> flush_work/workqueue) because it is possible that CPU_DEAD holds this mutex
> and waits for us to complete(kthread_stop_info). I believe this bug is old.

Yes, this bug is quite old looks like. Thanks for correcting me.

-- 
Regards,
vatsa
