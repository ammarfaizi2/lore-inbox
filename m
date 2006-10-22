Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWJVUKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWJVUKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJVUKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:10:50 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:3990 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751343AbWJVUKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:10:49 -0400
Message-ID: <453BD251.1000703@wolfmountaingroup.com>
Date: Sun, 22 Oct 2006 14:19:29 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adam radford <aradford@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linuxraid@amcc.com, linux-scsi@vger.kernel.org
Subject: Re: 3Ware delayed device mounting errors with newer 9500 series adapters
References: <453A52CE.80605@wolfmountaingroup.com>	 <20061021233904.c2f40a5f.akpm@osdl.org> <b1bc6a000610221019i47283722g3b8f4a79918c4825@mail.gmail.com>
In-Reply-To: <b1bc6a000610221019i47283722g3b8f4a79918c4825@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam radford wrote:

> Jeff,
>
> Can you reproduce with 2.6.18.1?  ES4 contains a custom 3ware driver.

We don't use kernels later than 2.6.15 in our shipping releases since 
they have
some issues with stability. 

>
> Also, you have included no error output with this email whatsoever.  Can
> you go to a virtual console during your ES4 install, run 'dmesg', and 
> see if
> the errors are in there, or if they are a part of the ES4 anaconda 
> installer?

dmesg produces no output since the errors are reflected from init.

Errors are typical of an unmounted volume.  i.e. 

"cannot touch /var/lock/subsys/<service> (dozens of these)
Starting System logger (hangs for 15 minutes) 

So no logs .....

>
> /dev/sdb, etc. having delayed appearances sounds like it is udev related.

No, I do not believe so.

>
> Are you running the latest firmware?  Do your controllers older than 
> 60 days
> have different firmware?

This is the right question.  I will collect the various versions this 
occurs on and post them here.

>
> I will try to reproduce this.

Pretty easy to do.

Jeff

>
> -Adam
>
> On 10/21/06, Andrew Morton <akpm@osdl.org> wrote:
>
>> On Sat, 21 Oct 2006 11:03:10 -0600
>> "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com> wrote:
>>
>> >
>> > Adam,
>> >
>> > We have been getting 3Ware 9500 series adapters in the past 60 days
>> > which exhibit a delayed behavior during mounting of FS from
>> > /etc/fstab.   The adapters older than this do not exhibit this 
>> behavior.
>> >
>> > During bootup, if the driver is compiled as a module rather than in
>> > kernel, mount points such as /var in fstab fail to detect the devices
>> > until the system fully boots, at which point the /dev/sdb etc. devices
>> > showup.  It happens on both ATA cabled drives and drives
>> > cabled with multi-lane controller backplanes.
>> >
>> > The problem is easy to reproduce.  Install ES4, point the /var 
>> directory
>> > during install to one of the array devices in disk druid, and after
>> > the install completes, /var/ will not mount during bootup and all 
>> sorts
>> > of errors stream off the screen.  I can reproduce the problem
>> > with several systems in our labs and upon investigating the adapter
>> > revisions, I find that adapters ordered in the past 60 days exhibit
>> > the problem.   Compiling the driver in kernel gets around the problem,
>> > indicating its timing related.
>> >
>>
>> cc's added.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

