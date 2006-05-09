Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWEIXgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWEIXgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEIXgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:36:08 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:7907 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932209AbWEIXgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:36:07 -0400
In-Reply-To: <adalktbcgl1.fsf@cisco.com>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com> <445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com> <44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75CCC04D-06EF-48B6-BE76-8BFAA541A764@kernel.crashing.org>
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
Date: Wed, 10 May 2006 01:35:57 +0200
To: Roland Dreier <rdreier@cisco.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Heiko> Yes, I agree. It would not be an optimal solution, because
>     Heiko> other upper level protocols (e.g. SDP, SRP, etc.) or
>     Heiko> userspace verbs would not be affected by this
>     Heiko> changes. Nevertheless, how can an improved "scaling" or
>     Heiko> "SMP" version of IPoIB look like. How could it be
>     Heiko> implemented?
>
> The trivial way to do it would be to use the same idea as the current
> ehca driver: just create a thread for receive CQ events and a thread
> for send CQ events, and defer CQ polling into those two threads.
>
> Something even better may be possible by specializing to IPoIB of  
> course.

The hardware IRQ should go to some CPU close to the hardware itself.   
The
softirq (or whatever else) should go to the same CPU that is handling  
the
user-level task for that message.  Or a CPU close to it, at least.


Segher

