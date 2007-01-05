Return-Path: <linux-kernel-owner+w=401wt.eu-S965144AbXAEMmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXAEMmI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbXAEMmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:42:07 -0500
Received: from mail.screens.ru ([213.234.233.54]:41104 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965144AbXAEMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:42:06 -0500
Date: Fri, 5 Jan 2007 15:42:46 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070105124246.GA83@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070105085634.GB18088@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105085634.GB18088@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05, Srivatsa Vaddagiri wrote:
>
> On Thu, Jan 04, 2007 at 09:18:50AM -0800, Andrew Morton wrote:
> > This?
> 
> This can still lead to the problem spotted by Oleg here:
> 
> 	http://lkml.org/lkml/2006/12/30/37
> 
> and you would need a similar patch he posted there.

preempt_disable() can't prevent cpu_up, but flush_workqueue() doesn't care
_unless_ cpu_down also happened meantime (and hence a fresh CPU may have
pending work_structs which were moved from a dead CPU).

So you are right, we still need the patch above, but I think we don't have
new problems with preempt_disable().

I might have missed your point though.

Oleg.

