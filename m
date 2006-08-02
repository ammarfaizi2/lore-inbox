Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWHBQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWHBQwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHBQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:52:38 -0400
Received: from mail.tmr.com ([64.65.253.246]:2695 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751224AbWHBQwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:52:38 -0400
Message-ID: <44D0D92A.6080306@tmr.com>
Date: Wed, 02 Aug 2006 12:56:10 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <44CF9A23.9090409@t-online.de> <44CF9C0A.8090405@gmail.com>
In-Reply-To: <44CF9C0A.8090405@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Harald Dunkel wrote:
>> Tejun Heo wrote:
>>> Can you try the following instead of hdparm?
>>>
>>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>>>
>>> It will make libata involved in putting the disk to sleep and waking it
>>> up, and, when waking, it will kick the drive in the ass by resetting the
>>> channel.  Please try with the latest -rc kernel.
>>>
>>
>> Sorry to say, but this did not work:
>>
>> # echo 1 > /sys/bus/scsi/devices/0:0:0:0/power/state
>> bash: echo: write error: Invalid argument
>> # ll !$
>> ll /sys/bus/scsi/devices/0:0:0:0/power/state
>> -rw-r--r-- 1 root root 0 Aug  1 20:00 
>> /sys/bus/scsi/devices/0:0:0:0/power/state
>> # cat !$
>> cat /sys/bus/scsi/devices/0:0:0:0/power/state
>> 0
>> # uname -a
>> Linux bugs 2.6.18-rc3 #2 PREEMPT Sun Jul 30 16:26:22 CEST 2006 i686 
>> GNU/Linux
> 
> You probably should do 'echo -n 1', the parsing function is pretty picky.
> 
Given that the data from the "cat" of state returned a zero with 
newline, perhaps unreasonably picky. On a Fedora kernel it just doesn't 
seem to work for SATA drives, sample size = 1.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
