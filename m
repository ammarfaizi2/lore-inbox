Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWAaGm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWAaGm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWAaGm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:42:56 -0500
Received: from smtpout.mac.com ([17.250.248.89]:41435 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030280AbWAaGmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:42:55 -0500
In-Reply-To: <17374.50453.727662.493504@cse.unsw.edu.au>
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <859CB9D0-A1D3-4931-9D9F-96153D0F3E1B@mac.com> <17374.50453.727662.493504@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E0033CA7-A345-4E5A-9A9A-33DFC378FF9C@mac.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Exporting which partitions to md-configure
Date: Tue, 31 Jan 2006 01:42:49 -0500
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 21:01, Neil Brown wrote:
> On Monday January 30, mrmacman_g4@mac.com wrote:
>> On Jan 30, 2006, at 20:10, Neil Brown wrote:
>>> On Monday January 30, hpa@zytor.com wrote:
>>>> Any feeling how best to do that?  My current thinking is to  
>>>> export a "flags" entry in addition to the current ones,  
>>>> presumably based on "struct parsed_partitions->parts[].flags" fs/ 
>>>> partitions/ check.h), which seems to be what causes  
>>>> md_autodetect_dev() to be called.
>>>
>>> I think I would prefer a 'type' attribute in each partition that  
>>> records the 'type' from the partition table.  This might be more  
>>> generally useful than just for md.  Then your userspace code  
>>> would have to look for '253' and use just those partitions.
>>
>> Well, for an MSDOS partition table, you would look for '253', for  
>> a Mac partition table you could look for something like  
>> 'Linux_RAID' or similar (just arbitrarily define some name  
>> beginning with the Linux_ prefix), etc.  This means that the  
>> partition table type would need to
>> be exposed as well (I don't know if it is already).
>
> Mac partition tables doesn't currently support autodetect (as far  
> as I can tell).  Let's keep it that way.

Well, no, the point would definitely *NOT* be to add kernel-level  
autodetect of stuff in the Mac partition tables.  The point would be  
to export the partition-table-format and partition-type information  
to userspace.  That way a custom mdadm-control-script could have a  
config file with "AUTODETECT_TYPE=Linux_RAID" or  
"AUTODETECT_TYPE=253" or "AUTODETECT_TYPE=<insert EFI UUID here>",  
etc.  The whole detection thing could be configured and done in  
userspace based on partition table info provided by the kernel if  
desired, or mdadm could just scan all disks for RAID headers like it  
does now.  The idea would be that any autodetection would be  
completely out of the kernel and userspace's responsibility; the  
kernel would just export info to make it easier.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


