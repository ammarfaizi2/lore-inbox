Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbSKUXky>; Thu, 21 Nov 2002 18:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSKUXky>; Thu, 21 Nov 2002 18:40:54 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:13472 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267197AbSKUXkx>;
	Thu, 21 Nov 2002 18:40:53 -0500
Message-ID: <3DDD7067.6090500@us.ibm.com>
Date: Thu, 21 Nov 2002 15:46:47 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] export e820 table on x86
References: <Pine.LNX.4.44.0211211448460.5779-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 20 Nov 2002, Dave Hansen wrote:
> 
>>I stole a patch that Arjan did a while ago, and ported it up to 2.5:
>>http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch
>>
>>We need this so avoid making BIOS calls when using kexec.
> 
>  - why isn't the info in /proc/iomem good enough - ie wouldn't it be 
>    better to just extend resource handling to 64 bit instead of
>    creating a new file.

It looks good enough.  The only irritating part is turning the "S3 
Inc. Trio 64 3D" or "ACPI Tables" back into the numberic e820 type.  I 
accomplished this in the previous patch by removing the printing of 
the name completely.  I thought it was silly to have the kernel 
printing out a pretty name just to have the userspace program parse it 
back into a number.  It saved a bug hunk of code in both the kernel 
and the kexec utility to skip the name.

What would you think of just adding another field to /proc/iomem which 
contains the e820 field type?  I've never seen any userspace use of 
iomem, but I would imagine that things like kudzu use it.  I wonder if 
they'll get tripped up if
50000000-50000fff : Texas Instruments PCI1450
changes into something like
50000000-50000fff : 2 : Texas Instruments PCI1450

>  - please use the seq_file interfaces for new files if you do end up 
>    creating new files.

I posted one this morning.

-- 
Dave Hansen
haveblue@us.ibm.com

