Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWF1UFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWF1UFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWF1UFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:05:48 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:56981 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751222AbWF1UFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:05:46 -0400
Date: Thu, 29 Jun 2006 01:32:47 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060628200247.GA7932@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628193256.GA4392@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 09:32:56PM +0200, Ingo Molnar wrote:
> 
> * Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > Turns out that kprobe_flush_task() is called from finish_task_switch() 
> > with preemption disabled and it uses a converted spin lock. The 
> > following patch fixed the problem for me and I was able to boot my 
> > x86_64 box.
> 
> ah, subtle problem and nice fix! We are using an RCU trick to delay task 
> freeing in finish_task_switch(), but kprobe_flush_task() isnt done in 

Yes, otherwise it would have been hell to do __put_task_struct()
with preemption disabled.

> put_task_struct(). [neither would it be right to flush kprobes there.] 
> I've released -rt4 with this included.

OK, I need to catch up, but I see a lot of oops while running rcutorture
in my box (rt1). I am investigating this atm.

Thanks
Dipankar
