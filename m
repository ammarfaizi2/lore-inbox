Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbUCMW3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUCMW3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:29:24 -0500
Received: from terminus.zytor.com ([63.209.29.3]:26004 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263201AbUCMW3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:29:22 -0500
Message-ID: <40538B39.90803@zytor.com>
Date: Sat, 13 Mar 2004 14:29:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 very early memory detection cleanup patch breaks the build
References: <1079198139.2512.19.camel@mulgrave> 	<40538091.9050707@zytor.com> <1079215809.2513.39.camel@mulgrave>
In-Reply-To: <1079215809.2513.39.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
>>I removed it because I removed the VISWS dependency, thus making it 
>>redundant.  What you seem to be saying is that the dependency should 
>>have been on SMP not X86_SMP; if that's the issue then please make it so.
>>
>>I think you just needed to apply your own rule to the above statement.
> 
> If you mean the dependency should be
> 
> 	depends X86_SMP || (VOYAGER && SMP)
> 
> Then yes, I'm happy with that.
> 

Actually, I just meant changing:

-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_SMP)		+= trampoline.o

... which is more like what the original code is doing, minus VISWS.

> I'm still debugging the boot time failure.  As far as I can tell it
> looks like ioremap is failing (this is after paging_init); does this
> trigger any associations?

Nope.  It shouldn't be using the boot page tables after paging_init, and 
even so, the "new" boot page tables look just like the "old" ones except 
there might be more of them, so there are two resaons that shouldn't be 
happening.  I'd have been less surprised if you'd seen a problem with 
boot_ioremap(), although even that shouldn't really be different...

My main guess would be a porting problem (_end -> init_pg_tables_end) in 
discontig.c, which I believe Voyager uses, right?

I don't have access to any real subarchitectures (I have a visws now, 
but I haven't actually been able to run it yet), so the discontig stuff 
didn't get tested; on the other hand the change in there was quite trivial.

Sorry for not being able to be more helpful, but I'm surrounded by boxes 
and this is the last weekend I have to pack before I move houses...

	-hpa
