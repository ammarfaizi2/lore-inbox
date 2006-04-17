Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWDQWHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWDQWHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWDQWHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:07:33 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:44481 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S1751338AbWDQWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:07:32 -0400
In-Reply-To: <200604161443.21653.arvidjaar@mail.ru>
References: <200604161443.21653.arvidjaar@mail.ru>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F77F3A5F-D618-4F7F-A266-14391E5DD739@cs.otago.ac.nz>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Re: Slab corruption after unloading a module
Date: Tue, 18 Apr 2006 10:08:06 +1200
To: Andrey Borzenkov <arvidjaar@mail.ru>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> There was no problem if I just load and unload the module. But if I
>> write to the device using "ls > /dev/temp" and then unload the
>> module, I would get slab corruption.
>
> you return different value as what has really been consumed:
>
>>         if (*f_pos + count > MAX_DSIZE)
>>                 count1 = MAX_DSIZE - *f_pos;
>>
>>         if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {
>>                 rv = -EFAULT;
>>                 goto wrap_up;
>>         }
>>         up (&temp_dev->sem);
>>         *f_pos += count1;
>>         return count;
>
> may be it confuses the rest of kernel a bit?

I did this intentionally. Since my baby device buffer is fixed size,  
I can't overflow the buffer. What I do is to cheat the application  
(by pretending the bytes requested are copied to the device) so that  
the application will be happy and do not hang on to send to the  
device again and again. After all it is a test module for char device.
Nevertheless, I don't think this cheating has something to do with  
the slab corruption.
