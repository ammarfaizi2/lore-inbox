Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUDODOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 23:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUDODOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 23:14:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9389 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263658AbUDODN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 23:13:58 -0400
Message-ID: <407DFDE7.5050803@austin.ibm.com>
Date: Wed, 14 Apr 2004 22:13:43 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
References: <407C4130.8000901@austin.ibm.com>	<20040413170642.22894ebc.akpm@osdl.org>	<407DF5AD.5090909@austin.ibm.com> <20040414195116.778fa4b2.akpm@osdl.org>
In-Reply-To: <20040414195116.778fa4b2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> 
>>>This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
>>
>> > instead.  There's an example in fs/super.c
>>
>> Ok, thanks for the tip.  Is this better?
> 
> 
> Looks OK.  How well tested was it?  Nothing calls init_proc_inum_idr().
> Maybe all-zeroes happens to work.

Sorry, I tested it all day; it just happens to work :)  Olof just 
pointed the error out to me, too.

I successfully allocated 152371 proc entries using this.

During testing I made sure that release_inode_number was actually 
releasing id's by inserting a call to idr_find before idr_remove, and 
using a dummy token for idr_get_new instead of NULL.  I can pass those 
bits along if you like.

BTW I found the use of idr in kernel/posix-timers.c to be more 
consistent with the comments in lib/idr.c so I emulated that.  I think 
the call to idr_remove in fs/super.c::set_anon_super needs to be holding 
unnamed_dev_lock.

Thanks,
Nathan
