Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272560AbTHJINs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272548AbTHJINs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:13:48 -0400
Received: from miranda.zianet.com ([216.234.192.169]:24841 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S272568AbTHJINk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:13:40 -0400
Message-ID: <3F35FE5B.7060003@zianet.com>
Date: Sun, 10 Aug 2003 02:12:11 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Dave Jones <davej@redhat.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Machine check expection panic
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel>	<20030807002722.GA3579@suse.de.suse.lists.linux.kernel> <p73ekzynuxt.fsf@oldwotan.suse.de>
In-Reply-To: <p73ekzynuxt.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:

>Dave Jones <davej@redhat.com> writes:
>  
>
>>#
>>diff -Nru a/arch/i386/kernel/cpu/mcheck/k7.c b/arch/i386/kernel/cpu/mcheck/k7.c
>>--- a/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
>>+++ b/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
>>@@ -81,7 +81,7 @@
>> 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>> 	nr_mce_banks = l & 0xff;
>> 
>>-	for (i=0; i<nr_mce_banks; i++) {
>>+	for (i=1; i<nr_mce_banks; i++) {
>>    
>>
>
>The change looks rather suspicious to me.
>
>Bank 0 is the data cache unit (DC)
>
>Do you have an errata that says that the DC bank is bad on all Athlons?
>
>Normally BIOS or microcode are supposed to turn off bad MCEs by 
>masking them in another register. Maybe the person's CPU has a 
>real problem that is just masked now, e.g. it could be overclocked
>and stress the cache too much.
>
The CPU's aren't overclocked and have worked fine for
me under much heavier loads than booting a kernel for
at least a year. Using the 2.4 kernel that is. Once
I remove the exception code from the kernel it boots
fine and runs fine under any load I put it under.

>
>The original MCE was:
>
>Status: (4) Machine Check in progress.
>Restart IP invalid.
>parsebank(0): f606200000000833 @ 4040
>        External tag parity error
>        Uncorrectable ECC error
>        CPU state corrupt. Restart not possible
>        Address in addr register valid
>        Error enabled in control register
>        Error not corrected.
>        Error overflow
>        Bus and interconnect error
>        Participation: Local processor originated request
>        Timeout: Request did not timeout
>        Request: Generic error
>        Transaction type : Instruction
>        Memory/IO : Other
>
>Tyan 2466 motherboard
>2 Athon MP 1200 processors  (1200?) 
>  
>
Should say 1.2 GHz processor I imagine. AMD and their
wacky naming schemes. This is before they had they
wacky number scheme.

Steve



