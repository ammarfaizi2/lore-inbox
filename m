Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTA0WCB>; Mon, 27 Jan 2003 17:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTA0WCB>; Mon, 27 Jan 2003 17:02:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:40408 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263333AbTA0WCA>; Mon, 27 Jan 2003 17:02:00 -0500
Date: Mon, 27 Jan 2003 14:03:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
Message-ID: <203100000.1043705004@flay>
In-Reply-To: <3E35AAE4.10204@us.ibm.com>
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org> <3E35AAE4.10204@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The problem is that I have not figured out how to tell the memory
>> allocator just what I need, 
> <snip>
>> I guess I would make the standard zones something like:
>> /*
>>  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
>>  * ZONE_NORMAL  16-896 MB	direct mapped by the kernel
>>  * ZONE_PHYSMEM 896-4096 MB	memory that is accessible with the
>>                               MMU disabled.
>>  * ZONE_HIGHMEM > 4096MB      only page cache and user processes
>>  */
> 
> I think this might be overkill.  ZONE_NORMAL gives you what you want,
> and I don't think it's worth it to introduce a new one just for the
> relatively short timespan where you have the new kernel loaded, but
> haven't actually shut down.  I think a little comment next to the
> allocation explaining this will be more than enough.
> 
> Martin, any ideas?

We talked about creating a new zone specifically for DMA32 (ie <4Gb)
for other reasons, but it's not there as yet. As Dave mentioned,
ZONE_NORMAL should be sufficient, though if you need it physically
contiguous, that might be a problem.

How much memory do you need? If it's only 2Mb or so, why don't we
statically reserve it at boot time and keep it set aside?

M.

