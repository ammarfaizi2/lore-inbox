Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJQQz0>; Thu, 17 Oct 2002 12:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSJQQzZ>; Thu, 17 Oct 2002 12:55:25 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:30366 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261748AbSJQQzZ>; Thu, 17 Oct 2002 12:55:25 -0400
To: Oliver Neukum <oliver@neukum.name>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <87smza1p7f.fsf@goat.bogus.local>
	<20021017053014.C26442@figure1.int.wirex.com>
	<87bs5t9mqa.fsf@goat.bogus.local>
	<200210171807.33178.oliver@neukum.name>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 17 Oct 2002 19:00:54 +0200
Message-ID: <87elap80ft.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.name> writes:

>> diff -urN a/drivers/char/mem.c b/drivers/char/mem.c
>> --- a/drivers/char/mem.c	Sat Oct  5 18:44:55 2002
>> +++ b/drivers/char/mem.c	Thu Oct 17 16:02:56 2002
>> @@ -525,7 +525,7 @@
>>
>>  static int open_port(struct inode * inode, struct file * filp)
>>  {
>> -	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
>> +	return capable(CAP_SYS_KMEM) ? 0 : -EPERM;
>
> return capable(CAP_SYS_KMEM) && capable(CAP_SYS_RAWIO) ? 0 : _EPERM;
>
> Unless you check for RAWIO you can gain RAWIO by illegitimate means.

It's embarrassing, but it took until now for me to realize, that this
tries to protect CAP_SYS_RAWIO and not /dev/kmem. Well, thanks for
being patient with me.

> Now whether one place justifies a whole capability is another question.

This is unnecessary then.

Regards, Olaf.
