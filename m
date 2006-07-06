Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWGFFU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWGFFU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWGFFU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:20:56 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:23243 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S932309AbWGFFUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:20:55 -0400
Message-ID: <4314.58.105.227.226.1152163948.squirrel@58.105.227.226>
In-Reply-To: <20060705201746.3438e944.rdunlap@xenotime.net>
References: <4960.58.105.227.226.1152155926.squirrel@58.105.227.226>
    <20060705201746.3438e944.rdunlap@xenotime.net>
Date: Thu, 6 Jul 2006 15:32:28 +1000 (EST)
Subject: Re: O_TARGET
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy, that works. But now it generated a NewSerial.ko instead of
NewSerial.o in kernel 2.6, this caused a problem when I called the insmod,
the insmod added another .o as follows:

insmod NewSerial.ko
insmod: NewSerial.ko.o: no module by that name found

Is it possible for me to get a NewSerial.o, not a NewSerail.ko?

Thank you.

Jim

> On Thu, 6 Jul 2006 13:18:46 +1000 (EST) yh@bizmail.com.au wrote:
>
>> Hi,
>>
>> The O_TARGET is no longer valid in kernel 2.4, what is the replacement
>> of
>> following module object in kernel 2.6?
>>
>> O_TARGET := NewSerial.o
>>
>> obj-y   := new_s_driver.o queue.o
>> obj-m   := $(O_TARGET)
>
> You just want a trivial Makefile ?
>
> See Documentation/kbuild/makefiles.txt for more info.
>
> Here is a working trivial example:
>
> #################### begin ###################3
> # usage:
> # make -C /path/to/kernel/source M=/path/to/source/TARGET/ [modules]
>
> obj-m := TARGET.o
>
> clean-files := *.o *.ko *.mod.c
> ############# end #######################
>
> M= implies modules, so modules is optional.
> I usually use M=$PWD (after cd to TARGET dir).
>
> ---
> ~Randy
>


