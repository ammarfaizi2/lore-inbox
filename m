Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRI3Fn3>; Sun, 30 Sep 2001 01:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272576AbRI3FnT>; Sun, 30 Sep 2001 01:43:19 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:37595 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272559AbRI3FnI>; Sun, 30 Sep 2001 01:43:08 -0400
Date: Sat, 29 Sep 2001 22:49:57 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
Message-ID: <1076417648.1001803797@[10.10.1.2]>
In-Reply-To: <E15n24b-0007tz-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> FWIW, I still think that means that the console locking changes are
>> broken  - adding a printk shouldn't panic the kernel. I'll go look at
>> the console locking changes (*and* fix my disgusting hack ;-) )
>
> I suspect the panic has nothing to do with adding the printk, but merely
> that the timing patterns of your disgusting hack have changed
>
> Happy logical analysers 8)

OK, you're right ;-) It turned out to be a race between init_idle and
reschedule_idle, that is a generic bug, but is revealed by the timing
changes that my printk introduces (both in standard SMP and NUMA
kernels, if you turn on serial consoles).

See imminent post for a patch. Having fixed the real problem, I can
now axe that disgusting hack ;-)

Thanks for your help,

Martin.


