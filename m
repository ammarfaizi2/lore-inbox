Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269696AbUJGMrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbUJGMrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269714AbUJGMqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:46:45 -0400
Received: from [195.23.16.24] ([195.23.16.24]:55943 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269802AbUJGMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:35:34 -0400
Message-ID: <41653814.1060405@grupopie.com>
Date: Thu, 07 Oct 2004 13:35:32 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
References: <20040927210305.A26680@flint.arm.linux.org.uk>	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>	 <1096931899.32500.37.camel@localhost.localdomain>	 <loom.20041005T130541-400@post.gmane.org>	 <20041005125324.A6910@flint.arm.linux.org.uk>	 <1096981035.14574.20.camel@pc960.cambridge.arm.com>	 <20041005141452.B6910@flint.arm.linux.org.uk> <1097016532.32500.357.camel@localhost.localdomain>
In-Reply-To: <1097016532.32500.357.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.5; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Tue, 2004-10-05 at 23:14, Russell King wrote:
> 
>>On Tue, Oct 05, 2004 at 01:57:15PM +0100, Richard Earnshaw wrote:
>>
>>>Why don't you pass s to is_arm_mapping_symbol and have it do the same
>>>thing as you've done in get_ksymbol?
>>
>>"sym_entry" is not an ELF symtab structure - it's a parsed version
>>of the `nm' output, and as such does not contain the symbol type nor
>>binding information.
> 
> 
> I believe that Paulo (CC'd) ended up with a patch which included the
> actual type information in /proc/kallsyms.  Paulo, what's the status of
> that patch?

That patch is in the -mm tree, and has been there for a while, so it is 
pretty much stable by now. There were 4 seperate patches, but since they 
were pretty much dependant, I think akpm merged them into 
"kallsyms-data-size-reduction--lookup-speedup.patch".

For those who don't know what the patch is about, it changes the format 
of the compressed kallsyms, so that they occupy less space, decompress 
faster (a lot faster) and include the same type char that was output by nm.

The code in kernel/kallsyms.c handles "aliases" (symbols with the same 
address) in a way that it shows a consistent output: the symbol shown is 
always the first. This can be easily changed, but I didn't want to 
change the old behavior.

The patch by Russel King seems ok to me, although I prefer Rusty's idea 
of not using any symbol that is not in the form "[A-Za-z0-9_]+". We just 
need to check if there are any real world users of these "weird" symbols.

If this seems ok to everyone I can cook up a patch to do this.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
