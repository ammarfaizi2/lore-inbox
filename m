Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUGSNLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUGSNLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUGSNLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:11:55 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:53150 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265152AbUGSNLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:11:52 -0400
Message-ID: <40FBC4E9.2000504@xeon2.local.here>
Date: Mon, 19 Jul 2004 14:56:09 +0200
From: kladit@t-online.de (Klaus Dittrich)
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040719091943.GA866@xeon2.local.here> <20040719112047.GA14784@outpost.ds9a.nl> <20040719113228.GA15295@outpost.ds9a.nl>
In-Reply-To: <20040719113228.GA15295@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rXghUvZ-ZeFMlyYSw-O0pwU15fAuEuF4FKkW5P8hSyckVumA23YKkW
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>/proc/fs/dentry-state of course, sorry
>
>On Mon, Jul 19, 2004 at 01:20:47PM +0200, bert hubert wrote:
>  
>
>>On Mon, Jul 19, 2004 at 11:19:43AM +0200, Klaus Dittrich wrote:
>>
>>    
>>
>>>I found out I could trigger the memory outage using du -s /disc1 too.
>>>      
>>>
>>Including crashing and/or running out of swap? That would indicate that the
>>dentry cache is not cleaning itself up, or that something is wrong with
>>reference counting.
>>
>>Can you run 'cat fs/dentry-state' before and after the du -s? (assuming
>>there is an 'after'. Also, which fs is /disc1 on? any messages in dmesg?
>>
>>dentry-state
>>------------
>>
>>Status of  the  directory  cache.  Since  directory  entries  are
>>dynamically allocated and deallocated, this file indicates the current
>>status. It holds six values, in which the last two are not used and are
>>always zero. The others are listed in table 2-1.
>>
>>
>>Table 2-1: Status files of the directory cache 
>>..............................................................................
>> File       Content                                                            
>> nr_dentry  Almost always zero                                                 
>> nr_unused  Number of unused cache entries                                     
>> age_limit  
>>            in seconds after the entry may be reclaimed, when memory is
>>short 
>> want_pages internally                                                         
>>
>>
>>-- 
>>http://www.PowerDNS.com      Open source, database driven DNS Software 
>>http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>  
>
The fs is ext2.cat /proc/sys/fs/dentry-state
Output of  cat /proc/sys/fs/dentry-state before and after processes got 
killed.
891083  888395  45      0       0       0
1142933 1085759 45      0       0       0
--
Klaus
