Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULRPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULRPDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULRPDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:03:24 -0500
Received: from mail.tmr.com ([216.238.38.203]:38847 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261173AbULRPDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:03:04 -0500
Message-ID: <41C448BB.1020902@tmr.com>
Date: Sat, 18 Dec 2004 10:11:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Chris Ross <chris@tebibyte.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.9-ac16
References: <41C2FF09.5020005@tebibyte.org><1103222616.21920.12.camel@localhost.localdomain> <1103349675.27708.39.camel@tglx.tec.linutronix.de>
In-Reply-To: <1103349675.27708.39.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

> Andrea fixed the invocation problem, which also handles the reentrancy
> problem in a clean way. It get's us rid of the ugly count, time,
> whatever mechanisms in out_of_memory which was designed to cover the
> invocation problem but was not able to prevent reentrancy and the
> resulting overkill (kill a random amount of processes even if enough
> memory is available). 
> 
> I added the "Take child processes into account" modification for the
> whom to kill selection on top of that and I was not able to make it
> missbehave with my different test scenarios.
> 
> The patches are available in parts in this thread and the final combined
> patch is there:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110269783227867&w=2
> 
> 2.6.10-rc3 contains a partial fix for the erroneous invocation problem,
> but it is not as effective as Andrea's solution and it still runs into
> overkill once the oom mechanism is invoked.
> 
> Andrea's fix and the selection changes should go into 2.6.10, but I
> suspect that the VM gurus havent still reached a point, where they
> agree. I also have the feeling that the problem is partially ignored.
> Obviously has everybody plenty of memory in his boxes. </rant off>

As someone who runs most new versions first on a 96MB (slow) machine, I 
would agree that this is a desirable change. I'm not sure yet if the 
selection is optimal, but it's better than the stock kernel, which seems 
to follow the "kill them all, let god sort it out" principle.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
