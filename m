Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTIAPDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTIAPDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:03:45 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:8154 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262971AbTIAPDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:03:43 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Robert Love <rml@tech9.net>, Ian Kumlien <pomac@vapor.com>
Subject: Re: [SHED] Questions.
Date: Mon, 1 Sep 2003 17:07:19 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1062324435.9959.56.camel@big.pomac.com> <1062369684.9959.166.camel@big.pomac.com> <1062373274.1313.28.camel@boobies.awol.org>
In-Reply-To: <1062373274.1313.28.camel@boobies.awol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011707.20135.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 September 2003 01:41, Robert Love wrote:
> Once a task "expires" (exhausts its timeslice), it will not run again
> until all other tasks, even those of a lower priority, exhaust their
> timeslice.
>
> ...
>
> Priority inversion is bad, but the priority inversion in this case is
> intended.  Higher priority tasks cannot starve lower ones.  It is a
> classic Unix philosophy that 'all tasks make some forward progress'

So if I have 1000 low priority tasks and one high priority task, all CPU 
bound, the high priority task gets 0.1% CPU.  This is not the desirable or 
expected behaviour.

My conclusion is, the strategy of expiring the whole active array before any 
expired tasks are allowed to run again is incorrect.  Instead, each active 
list should be refreshed from the expired list individually.  This does not 
affect the desirable O(1) scheduling property.  To prevent low priority 
starvation, the high-to-low scan should be elaborated to skip some runnable, 
high priority tasks occasionally in a *controlled* way.

IMHO, this minor change will provide a more solid, predictable base for Con 
and Nick's dynamic priority and dynamic timeslice experiments.

Regards,

Daniel

