Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUIHAzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUIHAzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUIHAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:55:21 -0400
Received: from mail-10.iinet.net.au ([203.59.3.42]:51177 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268710AbUIHAzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:55:16 -0400
Message-ID: <413E55D8.8030608@cyberone.com.au>
Date: Wed, 08 Sep 2004 10:44:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: nathanl@austin.ibm.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
References: <200409071849.i87Inw3f143238@austin.ibm.com>
In-Reply-To: <200409071849.i87Inw3f143238@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



nathanl@austin.ibm.com wrote:

>Register a cpu hotplug notifier which reinitializes the scheduler
>domains hierarchy.  The notifier temporarily attaches all running cpus
>to a "dummy" domain (like we currently do during boot) to avoid
>balancing.  It then calls arch_init_sched_domains which rebuilds the
>"real" domains and reattaches the cpus to them.
>
>Also change __init attributes to __devinit where necessary.
>
>Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
>

Thanks Nathan, this looks great.

I think the next step is to now make the setup code only use cpu_online_map
and get rid of everywhere I had been doing cpus_and(tmp, ..., 
cpu_online_map).
This may also make your patch 1/2 unnecessary? What do you think?

Nick

