Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265997AbUFOWOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbUFOWOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUFOWOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:14:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265998AbUFOWOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:14:38 -0400
Message-ID: <40CF74C0.1040409@pobox.com>
Date: Tue, 15 Jun 2004 18:14:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>, Dean Nelson <dcn@sgi.com>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com> <20040615180525.GA17145@sgi.com> <200406151414.20565.jbarnes@engr.sgi.com>
In-Reply-To: <200406151414.20565.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Tuesday, June 15, 2004 2:05 pm, Dean Nelson wrote:
> 
>>As mentioned above, it is possible for this "simple" function to
>>sleep/block for an indefinite period of time. I was under the impression
>>that one couldn't block a work queue thread for an indefinite period of
>>time. Am I mistaken?
> 
> 
> For tasklets and softirqs you're not allowed to sleep, but I think it's ok for 
> work queues.


Dean is correct and incorrect ;-)

If you are using schedule_work() or schedule_task(), blocking for 
extended periods of time would be very undesirable.  We see this on 
occasion in 2.6 uniprocessor, where a long-running keventd task may 
block a console or tty update.

In 2.6, the solution is easy... create your own private workqueue.  No 
such solution in 2.4 (though I would argue that workqueues would help 
drivers, if accepted into 2.4 at this late stage).

	Jeff


