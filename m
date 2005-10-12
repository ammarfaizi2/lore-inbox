Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVJLBVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVJLBVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJLBVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:21:15 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:37493 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932390AbVJLBVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:21:14 -0400
Message-ID: <434C654C.8020400@gmail.com>
Date: Tue, 11 Oct 2005 20:22:20 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
Reply-To: hnagar2@gmail.com
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: Re: [PATCH] Trivial patch to remove list member from struct tcx_par
 in drivers/video/tcx.c
References: <434B23CB.7000609@gmail.com> <Pine.LNX.4.62.0510111947100.20510@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0510111947100.20510@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Mon, 10 Oct 2005, Hareesh Nagarajan wrote:
>> This patch removes the list_head member 'list' from struct tcx_par in the file
>> drivers/video/tcx.c among other trivial cleanups. The member 'list' is never
>> used. It turns out that other frame buffer code like cg14.c, leo.c, bw2.c,
>> etc. (in drivers/video) seem to have the same extra list_head member in their
>> respective *_par structures.
> 
> What about the other changes you made (cfr. below)?

Please pardon my ignorance, but what does 'cfr.' mean?

>> The patch applies to the 2.6.13.4 kernel sources.
> 
> Please send patches inlined in the future. If you send them as an attachment,
> we cannot easily comment on them.

Sure, I will do so.

> 
>> (AFAICT, I am not missing anything; If I am, I'm sorry for wasting your time.)
> 
>> --- linux-2.6.13.4/drivers/video/tcx.c	2005-10-10 13:54:29.000000000 -0500
>> +++ linux-2.6.13.4-edit/drivers/video/tcx.c	2005-10-10 21:05:22.110156000 -0500
>> @@ -174,13 +173,13 @@
>>  			 unsigned red, unsigned green, unsigned blue,
>>  			 unsigned transp, struct fb_info *info)
>>  {
>> +	if (regno >= 256)
>> +		return 1;
>> +
>>  	struct tcx_par *par = (struct tcx_par *) info->par;
>>  	struct bt_regs __iomem *bt = par->bt;
>>  	unsigned long flags;
>>  
>> -	if (regno >= 256)
>> -		return 1;
>> -
>>  	red >>= 8;
>>  	green >>= 8;
>>  	blue >>= 8;
> 
> Please don't change this, or it won't compile anymore with gcc 2.95.

Ok.

>> @@ -442,7 +441,7 @@
>>  
>> -	tcx_blank(0, &all->info);
>> +	tcx_blank(FB_BLANK_UNBLANK, &all->info);
> What about this change?

Well, this isn't really a change, it just enhances readability.

>> @@ -490,8 +489,7 @@
>>  	struct list_head *pos, *tmp;
>>  
>>  	list_for_each_safe(pos, tmp, &tcx_list) {
>> -		struct all_info *all = list_entry(pos, typeof(*all), list);
>> -
>> +		struct all_info *all = list_entry(pos, struct all_info, list);
>>  		unregister_framebuffer(&all->info);
>>  		fb_dealloc_cmap(&all->info.cmap);
>>  		kfree(all);
> 
> And this one?

Why use typeof when you can specify the type. But again, this change 
does nothing. It reduces compile time a tad perhaps? :)

Must I go ahead and create a patch which removes the extra list_head 
member in the *_par structures?

Thanks,

Hareesh
