Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFKLcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFKLcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUFKLcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:32:51 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25217 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263818AbUFKLcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:32:48 -0400
Date: Fri, 11 Jun 2004 20:34:01 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4]Diskdump Update
To: linux-kernel@vger.kernel.org
Message-id: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I update the Diskdump patch for kernel 2.6.6. I fixed some codes 
according to comments from Christoph Hellwig.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108566610109915&w=2

Source code can be downloaded from
	http://sourceforge.net/projects/lkdump

Please feel free to comment.

Next week, I'll try the following and release new patch.

1) Change codes around add_timer()/del_timer()/etc.
2) Replace dev_t with block_device
3) Clean code more



On Thu, 27 May 2004 14:51:34 +0100, Christoph Hellwig wrote:

>> +/******************************** Disk dump ****************************
>> *******/
>> +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
>> +#undef  add_timer
>> +#define add_timer       diskdump_add_timer
>> +#undef  del_timer_sync
>> +#define del_timer_sync  diskdump_del_timer
>> +#undef  del_timer
>> +#define del_timer       diskdump_del_timer
>> +#undef  mod_timer
>> +#define mod_timer       diskdump_mod_timer
>> +
>> +#define tasklet_schedule        diskdump_tasklet_schedule
>> +#endif
>
>Yikes.  No way in hell we'll place code like this in drivers. This needs
>to be handled in common code.

Another approach is insering some codes into the core timer and tasklet
routines.

For example, 

static inline void add_timer(struct timer_list * timer)
{
	if(crashdump_mode())
		__diskdump_add_timer(timer);
	else
		__mod_timer(timer, timer->expires);
}

But I do not want to make common codes dirty...
Please let me know more good idea!

Best Regards,
Takao Indoh
