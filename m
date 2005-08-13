Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVHMKHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVHMKHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVHMKHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 06:07:06 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:45717 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S932143AbVHMKHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 06:07:04 -0400
Date: Sat, 13 Aug 2005 15:37:29 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: opening linux char device file in user thread.
In-Reply-To: <7d15175e05080403145a151b79@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0508131536370.14649@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in>
 <7d15175e05080403145a151b79@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thanks for help, it is working now, I opened the char file before the 
thread starts.

On Thu, 4 Aug 2005, Bhanu Kalyan Chetlapalli wrote:

> On 8/4/05, P.Manohar <pmanohar@lantana.cs.iitm.ernet.in> wrote:
>>
>> hai,
>>
>>    I have written a daemon which is running in user space, will send some
>> data periodically to kernel space. This I have done with the help of a
>> device file.
>>
>>  It is working, but I want to apply threads mechanism in that daemon. But
>> when I split that daemon functionality into a thread and a original
>> process. I am unable to
>> open the device file. This is happening in both places(either in thread or
>> original process).
>
> Try opening the device, get the FD and THEN spawn the thread. this
> will help, as the device is opened only once as far as the driver is
> concerned. The presence of usage from the thread is felt only in the
> reference count of the fd (which should be transparent to user space
> and the device driver). Race conditions are assumed to be taken care
> of in the kernel module though.
>
> The other way is to open device, write data, close device every time u
> write something. This is beneficial if the time between the writes is
> seperated by more than a minute. There will be no races etc to take
> care of.
>
>> The device is opening  when threading is not there.
>>
>> Can anybody suggest me?
>>
>> Regards,
>> P.Manohar.
>>
>
> Bhanu.
>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
> --
> The difference between Theory and Practice is more so in Practice than
> in Theory.
>
