Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVKLNc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKLNc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 08:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKLNc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 08:32:29 -0500
Received: from mail.tmr.com ([64.65.253.246]:20191 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932250AbVKLNc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 08:32:29 -0500
Message-ID: <4375F110.705@tmr.com>
Date: Sat, 12 Nov 2005 08:41:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compatible fstat()
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com> <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net> <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com> <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com> <FC49A7EB-A267-4C94-8739-2321C4DC1A1B@comcast.net> <43712D43.5080404@tmr.com> <93241CB9-F1EE-4D38-9194-C10B471FD02C@comcast.net>
In-Reply-To: <93241CB9-F1EE-4D38-9194-C10B471FD02C@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:

>
> On Nov 8, 2005, at 5:57 PM, Bill Davidsen wrote:
>
>> Parag Warudkar wrote:
>>
>>> On Nov 8, 2005, at 2:39 PM, Bob Copeland wrote:
>>>
>>>> Isn't this just because the device size is > 2**32?  What if you   
>>>> use fseeko(3)
>>>> and #define _FILE_OFFSET_BITS 64?
>>>>
>>> Yep. I got it to return the correct hard disk size (17Gb) using   
>>> lseek64 and
>>> #define _LARGEFILE64_SOURCE
>>> #define _FILE_OFFSET_BITS 64
>>> Here is what I did
>>> -------------------------------------------------
>>> #define _LARGEFILE64_SOURCE
>>> #define _FILE_OFFSET_BITS 64
>>> #include <stdio.h>
>>> #include <unistd.h>
>>> #include <fcntl.h>
>>> int main()
>>> {
>>>         int f;
>>>         off64_t off=0;
>>
>> Why is this initialized?
>>
>>>         f = open("/dev/hda", O_RDONLY );
>>>         if(f <= 0){
>>>                 perror("open");
>>>                 exit(0);
>>>         }
>>>         off = lseek64(f, 0, SEEK_SET);
>>
>> Why do this? it always returns zero.
>>
>>>         off = lseek64(f, 0, SEEK_END);
>>>         perror("llseek");
>>>         printf ("Size %lld\n", off);
>>>         close(f);
>>>         return 0;
>>> }
>>
>> RETURN VALUE
>>   Upon successful completion, lseek returns the resulting offset
>>   location as measured in bytes from the beginning of the  file.
>>   Otherwise,  a  value  of  (off_t)-1 is returned and errno is
>>   set to indicate the error.
>>
>
> You took it a little too seriously! It was from the scribble-and- 
> shuffle-till-it-works department ;) Sole purpose was to figure out a  
> way to print the disk size from the device - some how that is!
>
> But thanks for pointing out anyway - it doesn't hurt to be correct no  
> matter what the purpose is. 

You could look at how blockdev does it, the --getss (sector size) and 
--getsize (size in sectors) seem to work, based on trying it on a total 
of two machines ;-) Even gives correct size for software RAID arrays!

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

