Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267252AbUG1PzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267252AbUG1PzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUG1PxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:53:10 -0400
Received: from opersys.com ([64.40.108.71]:16654 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S267252AbUG1PwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:52:04 -0400
Message-ID: <4107CA18.4060204@opersys.com>
Date: Wed, 28 Jul 2004 11:45:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Scott Wood <scott@timesys.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [patch] IRQ threads
References: <20040727225040.GA4370@yoda.timesys>
In-Reply-To: <20040727225040.GA4370@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Scott Wood wrote:
> I have attached a patch for implementing IRQ handlers in threads, for
> latency-reduction purposes.  It requires that softirqs must be run in
> threads (or else they could end up running inside the IRQ threads,
> which will at the very least trigger bugs due to in_irq() being set). 
> I've tested it with Ingo's voluntary-preempt J7 patch, and it should
> work with the TimeSys softirq thread patch as well (though you might
> get a conflict with the PF_IRQHANDLER definition; just merge them
> into one).

My experience with clients who have been using TimeSys' stuff has been
abysmal. The fact of the of the matter is that most people who used
this were practically locked-in to TimeSys' services, unable to download
anything "standard" off the net and using it with their kernel. In one
example, we had to ditch the kernel the client got from TimeSys because
we had spent 10+ hours trying to get LTT to work on it without any
success whatsoever.

As I had said on other lists before, I don't see the point of creating
that much complexity in the kernel in order to try to shave-off a little
bit more off of the kernel's interrupt response time. The fact of the
matter is that neither this patch nor most of the other patches suggested
makes the kernel truely hard-rt. These patches only make the kernel
respond "faster". If you really need hard-rt, then you should be using
the Adeos nanokernel. With Adeos, you can even get a hard-rt driver
without using RTAI or any of the other rt derivatives.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

