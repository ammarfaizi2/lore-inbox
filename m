Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbTD2K7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 06:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbTD2K7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 06:59:14 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:32495 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261349AbTD2K7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 06:59:13 -0400
Message-ID: <3EAE5DF5.1040209@superbug.demon.co.uk>
Date: Tue, 29 Apr 2003 12:11:49 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in linux kernel when playing DVDs.
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On 27 April 2003 13:47, James Courtier-Dutton wrote:
>  
>
>>Hello,
>>
>>I have found a bug in the linux kernel when it plays DVDs. I use xine
>>(xine.sf.net) for playing DVDs.
>>At some point during the playing there is an error on the DVD. But
>>currently this error is not handled correctly by the linux kernel.
>>This puts the kernel into an uncertain state, causing the kernel to
>>take 100% CPU and fail all future read requests.
>>    
>>
>...
>  
>
>>Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: error=0x34
>>Apr 26 17:16:24 games kernel: hdd: ATAPI reset complete
>>Apr 26 17:16:25 games kernel: end_request: I/O error, dev 16:40
>>(hdd), sector 7750464
>>    
>>
>...
>  
>
>>DriveReady SeekComplete Error }
>>Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0x34
>>Apr 26 17:16:59 games kernel: hdd: ATAPI reset complete
>>Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40
>>(hdd), sector 7750468
>>    
>>
>
>See? Sector # is increasing... Linux retries the read several times,
>then reports EIO to userspace and goes to next sectors. Unfortunately,
>they are bad too, so the loop repeats. Eventually it will pass
>by all bad sectors (if not, it's a bug) but it can take longish
>time.
>
>Apart of making max retry # settable by the user, I don't see how
>this can be made better. Pity. This is common problem on CDs...
>--
>vda
>  
>
What is this EIO report. The CPU is never returned to user space apps, 
so the app never sees any error.
As for retries, for DVD playing we do not want the Linux kernel to do 
any retries, because during DVD playback, we just want a very quick 
response saying there was an error. The DVD playing application can then 
skip forward 0.5 seconds and continue. If one sector fails on a DVD, 
there is little or not point in reading the next sector. One has to 
start reading from the next VOBU. (i.e. about 0.5 seconds skip.)

Cheers
James


