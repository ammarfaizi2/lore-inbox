Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWBPVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBPVfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBPVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:35:34 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.138]:18312 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932137AbWBPVfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:35:33 -0500
Date: Thu, 16 Feb 2006 13:35:25 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: oops, 2.6.15.4 + qla1280+md+xfs+quota (fwd)
In-Reply-To: <20060217074540.E9364782@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0602161321130.21660@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0602161028180.21660@potato.cts.ucla.edu>
 <20060217074540.E9364782@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Nathan Scott wrote:
> On Thu, Feb 16, 2006 at 10:30:34AM -0800, Chris Stromsoe wrote:
>> I sent this to lkml yesterday.  Short description of the problem -- xfs 
>> on 2.6.15.4 without quota enabled is ok.  When I try to mount with 
>> "quota", the entire machine hangs.  Details are below.
>
> Could you try without 4Kstacks just for grins?  Thanks. There was a 
> stack abuse accidentally introduced in the XFS quota mount path a month 
> or two back - I have a fix for that pending so that may just be it.

I rebuilt with the same config, but without 4K stacks.  I have the xfs 
partition mounted with quota enabled, and everything looks ok.  I don't 
have any content on the partition yet, but this is further than I got 
yesterday.  If you have patches to fix the 4K/8K issue, I'm willing to 
test them to see if they do fix the problem with 4K stacks.

> EIP is at a whacky spot, and your stack trace is all messed up - not 
> sure how we'd get into that situation on a mount with quotas, unless 
> something really bizzare happened (like a stack overflow).

All of the stack traces I got back while testing were different, and none 
made much sense.


-Chris

> cheers.
>
>> ---------- Forwarded message ----------
>> Date: Thu, 16 Feb 2006 03:10:00 -0800 (PST)
>> From: Chris Stromsoe <cbs@cts.ucla.edu>
>> To: linux-kernel@vger.kernel.org
>> Subject: oops, 2.6.15.4 + qla1280+md+xfs+quota
>>
>> I have a 2.6.15.4 system that was running fine.  Internal drives are using the
>> Fusion MPT driver.  I have two external JBODs with 12 disks each. Each JBOD has
>> two channels, 6 disks per channel, and each channel is connected to a QLogic
>> ISP 10160 controller.
>>
>> Each of the JBODs is built as an md raid5 (md1 and md2).  Both raid5s are
>> mirrored (md3).  I had an ext3 filesystem running fine.
>>
>> I unmounted md3, ran "mkfs.xfs /dev/md3 && mount /dev/md3" and the system hung.
>> md is built in, qla1280 and xfs are both modules.  mount options in fstab are
>> rw, quota, noatime -- possibly also noexec and nosuid, but I don't think they
>> were enabled.  XFS is built with XFS quota support; I've tried also with and
>> without generic quota support.  4K stacks are enabled, if that matters.  Full
>> .config and dmesg output are at http://hashbrown.cts.ucla.edu/pub/oops-200602/
>> (config is with generic quota, dmesg has xfs loaded as a module and /dev/md3
>> mounted without quota set).
>>
>> I added "defaults" and removed "quota" from fstab for /dev/md3 and was able to
>> mount the partition normally.
>>
>> It's not responsive to sysrq on the serial console. The last output (without
>> generic quota) was:
>>
>> XFS mounting filesystem md3
>> XFS quotacheck md3: Please wait.
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> c0114f5a
>> *pde = 00000000
>> Oops: 0000 [#1]
>> SMP
>> Modules linked in: xfs e1000 bonding qla1280 st
>> CPU:    0
>> EIP:    0060:[<c0114f5a>]    Not tainted VLI
>> EFLAGS: 00010006   (2.6.15.4)
>> EIP is at do_page_fault+0x93/0x545
>> eax: eb7ac000   ebx: 00000001   ecx: 0000007b   edx: 00100100
>> esi: 000001ff   edi: c0114ec7   ebp: eb7ac0e8   esp: eb7ac094
>> ds: 007b   es: 007b   ss: 0068
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel NULL pointer dereference at virtual address 00000078
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address bebaee76
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address bebaee76
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>> Unable to handle kernel paging request at virtual address 00100178
>>   printing eip:
>>
>>
>> As soon as I mount the partition with quota in fstab, the machine hangs. The
>> oops is not always the same.  During one test run, I saw a number of "BUG: soft
>> lockup detected on CPU#0" errors.  The above oops is the only one I managed to
>> capture.
>>
>>
>>
>> -Chris
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
> -- 
> Nathan
>
