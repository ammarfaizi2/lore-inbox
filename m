Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVKWItg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVKWItg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKWItg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:49:36 -0500
Received: from mail.setcomm.ru ([83.102.151.194]:59084 "EHLO mail.setcomm.ru")
	by vger.kernel.org with ESMTP id S1030367AbVKWItf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:49:35 -0500
Message-ID: <43842D1E.6070006@kernelpanic.ru>
Date: Wed, 23 Nov 2005 11:49:34 +0300
From: "Boris B. Zhmurov" <bb@kernelpanic.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Rulez Forever/1.7.12-1.4.1
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: MTRR compile failure in git
References: <Pine.SOC.4.61.0511231037390.13524@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0511231037390.13524@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Meelis Roos.

On 23.11.2005 11:38 you said the following:

>   CC      arch/i386/kernel/cpu/mtrr/main.o
> arch/i386/kernel/cpu/mtrr/main.c: In function 'set_mtrr':
> arch/i386/kernel/cpu/mtrr/main.c:225: error: 'ipi_handler' undeclared 
> (first use in this function)
> arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier 
> is reported only oncearch/i386/kernel/cpu/mtrr/main.c:225: error: for 
> each function it appears in.)
> 
> x86 UP i686 (PIII)


Yep. That happens after that patch:

tree e7ba0f1bc8764c36859e2cfa9421bb1d86f2e7f4
parent b3a5225f31180322fd7d692fd4cf786702826b94
author Russell King <rmk+kernel@arm.linux.org.uk> Wed, 23 Nov 2005 
06:38:04 -0800
committer David S. Miller <davem@davemloft.net> Wed, 23 Nov 2005 
06:38:04 -0800

[NET]: Shut up warnings in net/core/flow.c

Not really a network problem, more a !SMP issue.

net/core/flow.c:295: warning: statement with no effect

flow.c:295:        smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);

Fix this by converting the macro to an inline function, which
also increases the typechecking for !SMP builds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>





-- 
Boris B. Zhmurov
mailto: bb@kernelpanic.ru
"wget http://kernelpanic.ru/bb_public_key.pgp -O - | gpg --import"

