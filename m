Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVFLEqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVFLEqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVFLEqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:46:32 -0400
Received: from opersys.com ([64.40.108.71]:55304 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261876AbVFLEqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:46:20 -0400
Message-ID: <42ABC089.8080100@opersys.com>
Date: Sun, 12 Jun 2005 00:56:41 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.44.0506112126580.24837-100000@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506112126580.24837-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Walker wrote:
>>The proof is in the pudding: it's not for nothing that the results
>>we published earlier show that the mere enabling of Adeos actually
>>increases Linux's performance under heavy load.
> 
> 
> Why do you think that is? Is ADEOS optimized for specific machine 
> configurations?

I was refering back to what you were talking about just before I
replied: no disabling of interrupts.

> It doesn't seem like one could really merge the two. From what I've read 
> , it seem like ADEOS is something completly indepedent . It would be linux 
> and ADEOS , but never just linux . 

I'm not sure I follow. Forget about all the fancy hypervisor/
nanokernel talk. The bottom line is that while the initial design
called for an entire nanokernel, the actual code in adeos can be
summarized by the interrupt pipepline. Said ipipe is a feature
that stands on its own and could easily be integrated into mailine
as a feature. Using just the ipipe, for example, it would be
possible to load a module that would register ahead of Linux
in the pipeline and therefore obtain its interrupts regardless
of whether or not Linux has stalled its pipeline stage (i.e.
cli'ed.) That's hard-rt at a very low cost in terms of general
kernel source code intrusion.

This is why I have a hard time understanding the statement that
"It would be Linux and Adeos, but never just Linux." In this case,
it would be Linux with an ipipe. Said ipipe can then be left
unpopulated, and then we get back to what you guys have just
implemented. Or a driver can use it to obtain hard-rt. Or
additional Adeos components can hook onto the ipipe to provide
services enabling RTAI to run side-by-side with Linux.

May I suggest getting a copy of a recent Adeos patch and looking
through it? I'm sure it would make things much simpler to
understand.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
