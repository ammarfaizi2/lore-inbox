Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUBGG3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUBGG3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:29:40 -0500
Received: from lgsx14.lg.ehu.es ([158.227.2.29]:13551 "EHLO lgsx14.lg.ehu.es")
	by vger.kernel.org with ESMTP id S266488AbUBGG3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:29:36 -0500
Message-ID: <402485C0.905@wanadoo.es>
Date: Sat, 07 Feb 2004 07:29:20 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Andrew Morton <akpm@osdl.org>, david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org> <4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org> <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Thu, 5 Feb 2004, Andrew Morton wrote:
>
>  
>
>>>By the way, is anyone involved in solving the IO-APIC thing in nforce 
>>>motherboards? Anyone trying a different approach? Anyone contacting 
>>>nvidia about this problem?
>>>      
>>>
>>As far as I know, we're dead in the water on these problems.
>>    
>>
>
> Not necessarily. :-)
>
>  
>
>>Here's one:
>>
>>
>>[x86] do not wrongly override mp_ExtINT IRQ
>>
>>From: Mathieu <cheuche+lkml@free.fr>.
>>
>>With this patch timer IRQ0 is correctly set to IO-APIC-edge
>>(not XT-PIC) on nForce2 boards when using APIC and ACPI.
>>
>> arch/i386/kernel/mpparse.c |    3 ++-
>> 1 files changed, 2 insertions(+), 1 deletion(-)
>>
>>diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
>>--- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 00:12:25.782597272 +0100
>>+++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.786596664 +0100
>>@@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
>> 	 */
>> 	for (i = 0; i < mp_irq_entries; i++) {
>> 		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
>>-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
>>+			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
>>+			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
>> 			mp_irqs[i] = intsrc;
>> 			found = 1;
>> 			break;
>>    
>>
>
> That's not the right fix.  There's a bug in Linux's ACPI IRQ setup as
>I've discovered by comparing the code to the spec.  Here's a patch I sent
>in December both to the LKML and the ACPI maintainer.  The feedback from
>the list was positive, but the maintainer didn't bother to comment.
>
> I haven't pushed the patch more firmly, because the MIPS port is my
>priority and I don't even have any ACPI-aware equipment.
>
> Maciej
>
>  
>
Can you send us the specific patch or at least telling us if you're 
going to push it?

Thanks a lot for the fix ;)

LuisMi Garcia
