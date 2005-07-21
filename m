Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGUNPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGUNPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 09:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGUNPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 09:15:32 -0400
Received: from mail.timesys.com ([65.117.135.102]:41282 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261667AbVGUNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 09:15:30 -0400
Message-ID: <42DF9F8C.7010503@timesys.com>
Date: Thu, 21 Jul 2005 09:13:48 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: 2.6.12 PREEMPT_RT && PPC
References: <200507200816.11386.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com> <200507210745.57120.gene.heskett@verizon.net>
In-Reply-To: <200507210745.57120.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jul 2005 13:06:19.0765 (UTC) FILETIME=[FC7F1250:01C58DF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

> Humm, I wondering out loud if this is the video dma failure in tvtime?
> Anyway, it applied cleanly over -33, and is building now, set for 
> mode=4.

On i386 the hw_irq_controller.end() handler
conditionally calls the function registered
for the hw_irq_controller.enable() handler
[enable_8259A_irq()] which I'd hazard is
how the missing hw_irq_controller.end() call
went unnoticed.  ie: for the i386 the end()
call was effectively redundant w/r/t the
enable() call.

However for PPC there is some specific
unfinished business to be done at the logical
conclusion of IRQ reception which is
accomplished by the registered end() hook.

-john


-- 
john.cooper@timesys.com
