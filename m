Return-Path: <linux-kernel-owner+w=401wt.eu-S1750932AbWLVQnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWLVQnW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWLVQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 11:43:22 -0500
Received: from mail.screens.ru ([213.234.233.54]:55073 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbWLVQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 11:43:21 -0500
Date: Fri, 22 Dec 2006 19:42:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>, kiran@scalex86.org,
       venkatesh.pallipadi@intel.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-ID: <20061222164243.GA86@tv-sign.ru>
References: <20061221003101.GA28643@Krystal> <20061220232350.eb4b6a46.akpm@osdl.org> <20061222103724.GA29348@in.ibm.com> <20061222024458.322adffd.akpm@osdl.org> <20061222162044.GA279@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222162044.GA279@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22, Oleg Nesterov wrote:
>
> 	void flush_work(struct workqueue_struct *wq, struct work_struct *work)
> 	{
> 		struct cpu_workqueue_struct *cwq;
> 
> 		cwq = get_wq_data(work);
> 		if (!cwq)
> 			return;
> 
> 		spin_lock_irq(&cwq->lock);
> 		list_del_init(&work->entry);
> 		work_release(work);
> 		spin_unlock_irq(&cwq->lock);

Err, forgot to mention, this should be done under workqueue_mutex
or we should re-check cwq == get_wq_data(), I didn't decide yet.

Sorry for extra noise.

Oleg.

