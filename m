Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUJIUvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUJIUvf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUJIUsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:48:22 -0400
Received: from opersys.com ([64.40.108.71]:27918 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S267396AbUJIUpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:45:31 -0400
Message-ID: <41684FC6.1070803@opersys.com>
Date: Sat, 09 Oct 2004 16:53:26 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: stefan.eletzhofer@eletztrick.de,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>	 <1097346628.1428.11.camel@krustophenia.net>	 <20041009212614.GA25441@tier.local>	 <1097350227.1428.41.camel@krustophenia.net>	 <20041009213817.GB25441@tier.local>	 <1097351221.1428.46.camel@krustophenia.net>  <416845E4.206@opersys.com> <1097352885.1428.60.camel@krustophenia.net>
In-Reply-To: <1097352885.1428.60.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> In theory, I think yes, if all IRQs on the system run in threads except
> the saw interrupt, and the RT task that controls the saw runs at a
> higher priority than all the IRQ threads.  You can guarantee that other
> interrupts won't delay the saw, because the saw irq is the only thing on
> the system that runs in interrupt context.  With the current VP
> implementation you are still bounded by the longest non-preemptible code
> path in the kernel AKA the longest time that a spinlock is held. 
> Replacing most spinlocks with mutexes reduces this to less than 20 code
> paths according to Mvista, which then can be individually audited for
> RT-safeness. 
> 
> That being said, no way would I put my hand under the saw with the
> current implementation.  But, unless I am missing something, it seems
> like this kind of determinism is possible with the Mvista design.

It may be a question of taste, but even if that did work, which I am
not convinced of, it seems to me that it's awfully convoluted.
With the current interrupt pipeline mechanism part of Adeos, on
which RTAI and RTAI fusion are built, I can give you absolute hard-rt
deterministic guarantees while keeping the spinlocks intact, and not
having to check for the rt-safeness of any part of the kernel. You
just write the time-sensitive saw driver int handler in front of
Linux in the ipipe and you're done: 100% deterministic hard-rt,
regardless of the application load and the driver set.

> I will check that out, I have not looked at RTAI in over a year.

Here are some interesting links:

RTAI/fusion presentation by Philipppe Gerum last July (see slide 25
for some interesting numbers):
http://www.enseirb.fr/~kadionik/rmll2004/presentation/philippe_gerum.pdf
Here's a thread that explains the details about RTAI/fusion:
https://mail.rtai.org/pipermail/rtai/2004-June/thread.html#7909
Here's the ipipe core API:
http://home.gna.org/adeos/doc/api/interface_8h.html

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


