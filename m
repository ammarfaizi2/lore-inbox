Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVKIAO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVKIAO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKIAO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:14:27 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:33994 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030441AbVKIAO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:14:26 -0500
In-Reply-To: <43712D43.5080404@tmr.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com> <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net> <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com> <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com> <FC49A7EB-A267-4C94-8739-2321C4DC1A1B@comcast.net> <43712D43.5080404@tmr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93241CB9-F1EE-4D38-9194-C10B471FD02C@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 19:14:19 -0500
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 5:57 PM, Bill Davidsen wrote:

> Parag Warudkar wrote:
>> On Nov 8, 2005, at 2:39 PM, Bob Copeland wrote:
>>> Isn't this just because the device size is > 2**32?  What if you   
>>> use fseeko(3)
>>> and #define _FILE_OFFSET_BITS 64?
>>>
>> Yep. I got it to return the correct hard disk size (17Gb) using   
>> lseek64 and
>> #define _LARGEFILE64_SOURCE
>> #define _FILE_OFFSET_BITS 64
>> Here is what I did
>> -------------------------------------------------
>> #define _LARGEFILE64_SOURCE
>> #define _FILE_OFFSET_BITS 64
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> int main()
>> {
>>         int f;
>>         off64_t off=0;
> Why is this initialized?
>>         f = open("/dev/hda", O_RDONLY );
>>         if(f <= 0){
>>                 perror("open");
>>                 exit(0);
>>         }
>>         off = lseek64(f, 0, SEEK_SET);
> Why do this? it always returns zero.
>>         off = lseek64(f, 0, SEEK_END);
>>         perror("llseek");
>>         printf ("Size %lld\n", off);
>>         close(f);
>>         return 0;
>> }
> RETURN VALUE
>   Upon successful completion, lseek returns the resulting offset
>   location as measured in bytes from the beginning of the  file.
>   Otherwise,  a  value  of  (off_t)-1 is returned and errno is
>   set to indicate the error.
>

You took it a little too seriously! It was from the scribble-and- 
shuffle-till-it-works department ;) Sole purpose was to figure out a  
way to print the disk size from the device - some how that is!

But thanks for pointing out anyway - it doesn't hurt to be correct no  
matter what the purpose is.

Parag
