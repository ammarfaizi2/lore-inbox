Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266962AbUBMMUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266964AbUBMMUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:20:00 -0500
Received: from [195.228.112.1] ([195.228.112.1]:15115 "HELO
	goliat.otpbank-direkt.hu") by vger.kernel.org with SMTP
	id S266962AbUBMMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:19:56 -0500
Message-ID: <402CC114.8080100@dell633.otpefo.com>
Date: Fri, 13 Feb 2004 13:20:36 +0100
From: Nagy Tibor <nagyt@otpbank.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, hu
MIME-Version: 1.0
To: xela@slit.de, mochel@osdl.org, bmoyle@mvista.com, orc@pell.chi.il.us
CC: linux-kernel@vger.kernel.org
Subject: HIGHMEM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry, I have found your e-mail address in 
./arch/i386/kernel/setup.c. I have the problem below since a year, and 
there is no solution yet. I guess, the problem is about e820. The 
problem exists in 2.4.x and also in 2.6.1.

We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
kernel uses about 500MB less memory in the newer machine.

----------------------- 2.4.20 ---------------------------------

See /var/log/boot.msg on the old one:

<4>Linux version 2.4.20 (root@dell632) (gcc version 2.95.3 20010315
(SuSE)) #4 SMP Fri Jan 10 12:07:00 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 00000000fbffe000 (usable)
<4> BIOS-e820: 00000000fbffe000 - 00000000fc000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>3135MB HIGHMEM available.
<5>896MB LOWMEM available.

and on the new one:

<4>Linux version 2.4.20 (root@alfa) (gcc version 2.95.3 20010315 (SuSE))
#10 SMP Fri Mar 28 15:40:45 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
<4> BIOS-e820: 00000000dfff0000 - 00000000dfffec00 (ACPI data)
<4> BIOS-e820: 00000000dfffec00 - 00000000dffff000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>2687MB HIGHMEM available.
<5>896MB LOWMEM available.

There is a big hole between 00000000dffff000 and 00000000fec00000, which
is not used on the new machine. What can I do?

------------------------------ 2.6.1 ------------------------------
I do not see in boot.msg such a detailed memory map, but the next line 
in boot.msg indicates, that the situation is the same:

<6>Memory: 3627908k/3669952k available (2918k kernel code, 40908k 
reserved, 1049k data, 180k init, 2752448k highmem)

--------------------------------------------------------------------

ACPI can not be disabled in BIOS. If ACPI is disbled in the kernel, the 
memory mapping remains the same, but CPU hyperthreading does not work also.


Thanks for your help.

Tibor


------------------------------------------------------------------------
Tibor Nagy
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------



