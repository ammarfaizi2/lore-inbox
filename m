Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWIEXvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWIEXvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWIEXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:51:54 -0400
Received: from mail.tmr.com ([64.65.253.246]:61345 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965158AbWIEXvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:51:52 -0400
Message-ID: <44FE0DD4.1000805@tmr.com>
Date: Tue, 05 Sep 2006 19:52:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, grundler@parisc-linux.org, geert@linux-m68k.org,
       zippel@linux-m68k.org, paulus@samba.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: Re: [PATCH 01/26] Dynamic kernel command-line - common
References: <200609040050.13410.alon.barlev@gmail.com> <200609040052.15870.alon.barlev@gmail.com> <20060903221002.GE2558@parisc-linux.org>
In-Reply-To: <20060903221002.GE2558@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Sep 04, 2006 at 12:52:14AM +0300, Alon Bar-Lev wrote:
>> @@ -116,8 +116,12 @@ extern void time_init(void);
>>  void (*late_time_init)(void);
>>  extern void softirq_init(void);
>>  
>> -/* Untouched command line (eg. for /proc) saved by 
>> arch-specific code. */
>> -char saved_command_line[COMMAND_LINE_SIZE];
>> +/* Untouched command line saved by arch-specific code. */
>> +char __initdata boot_command_line[COMMAND_LINE_SIZE];
> 
> Your patch is wordwrapped.
> 
> Also, what was the point of all this?  Was there some discussion that
> this would be useful?
> 
Assuming that this works as described, the benefits are obvious. In most 
cases I would expect the memory saved to be more than the patch takes, 
and the patch is init code. Having the possibility of having very long 
command lines is bound to be useful on occasion, particularly when using 
drivers with option-names-way-too-long.

I agree that this wouldn't make my top 200 list of wanted features, but 
it's here, it saves a little memory, it adds a capability someone will 
find useful, why not use it? It appears to be a small win in every case.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
