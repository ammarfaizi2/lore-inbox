Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWAZUl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWAZUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWAZUl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:41:28 -0500
Received: from mail.zelnet.ru ([80.92.97.13]:31172 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S964858AbWAZUl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:41:27 -0500
Message-ID: <43D933EB.6080009@namesys.com>
Date: Thu, 26 Jan 2006 23:41:15 +0300
From: Edward Shishkin <edward@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4,
 unixfile) vs (reiser4,cryptcompress)
References: <43D7C6BE.1010804@namesys.com> <43D7CA7F.4010502@namesys.com> <20060126153343.GH4311@suse.de> <43D91225.3030605@namesys.com> <20060126185612.GM4311@suse.de>
In-Reply-To: <20060126185612.GM4311@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Thu, Jan 26 2006, Edward Shishkin wrote:
>  
>
>>Jens Axboe wrote:
>>
>>    
>>
>>>On Wed, Jan 25 2006, Hans Reiser wrote:
>>>
>>>
>>>      
>>>
>>>>Notice how CPU speed (and number of cpus) completely determines
>>>>compression performance.
>>>>
>>>>cryptcompress refers to the reiser4 compression plugin, (unix file)
>>>>refers to the reiser4 non-compressing plugin.
>>>>
>>>>Edward Shishkin wrote:
>>>>
>>>>  
>>>>
>>>>        
>>>>
>>>>>Here are the tests that vs asked for:
>>>>>Creation (dd) of 20 tarfiles (the original 200M file is in ramfs)
>>>>>Kernel: 2.6.15-mm4 + current git snapshot of reiser4
>>>>>
>>>>>------------------------------------------
>>>>>
>>>>>Laputa workstation
>>>>>Uni Intel Pentium 4 (2.26 GHz) 512M RAM
>>>>>
>>>>>ext2:
>>>>>real 2m, 15s
>>>>>sys 0m, 14s
>>>>>
>>>>>reiser4(unix file)
>>>>>real 2m, 7s
>>>>>sys  0m, 23s
>>>>>
>>>>>reiser4(cryptcompress, lzo1, 64K)
>>>>>real 2m, 13s
>>>>>sys 0m, 11s
>>>>>    
>>>>>
>>>>>          
>>>>>
>>>Just curious - does your crypt plugin reside in user space?
>>>
>>>
>>>
>>>      
>>>
>>Nop.
>>This is just wrappers for linux crypto api, zlib, etc..
>>so user time is zero and not interesting.
>>    
>>
>
>Then why is the sys time lower than the "plain" writes on ext2 and
>reiser4? Surely compressing isn't for free, yet the sys time is lower on
>the compression write than the others.
>
>  
>

I guess this is because real compression is going in background
flush, not in sys_write->write_cryptcompress (which just copies
user's data to page cache). So in this case we have something
very similar to ext2. Reiser4 plain write (write_unix_file) is
more complex, and currently we try to reduce its sys time.

Edward.


