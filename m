Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTKZKab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTKZKab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:30:31 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:25582 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S264120AbTKZKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:30:29 -0500
Message-ID: <3FC480BF.9060301@softhome.net>
Date: Wed, 26 Nov 2003 11:30:23 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <VQJL.62Q.11@gated-at.bofh.it> <VR3c.6Ns.21@gated-at.bofh.it>
In-Reply-To: <VR3c.6Ns.21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:
> 
> 
>>># echo 2 > /proc/sys/vm/overcommit_memory
>>>
>>>Then try again.
>>
>>   What do you know what is not said in docs?
>>   What '2' means?
> 
> Strict non-overcommit mode.  You can allocate as much
> non-file-backed virtual memory as will fit in swap,
> plus /proc/sys/vm/overcommit_percentage worth of memory.
> 

   [ s/overcommit_percentage/overcommit_ratio/ ]

   Thanks! On 2.6 it works as expected. Test with two concurrent memory 
allocations took some time, but both apps stops exactly when memory was 
depleted. Great.

   Did rmap has something todo with this?
   As I see from implementation of do_mmap_pgoff() - it changed from 2.4 
to 2.6 - but there are a lot of common things.
   If I will do dumb back port of this check to 2.4 - do you think it 
will work? 2.4->2.6 memory accounting changed?
   I didn't found this check in your rmap patches for 2.4.22. (btw 
thanks for keeping them up-to-date).

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

