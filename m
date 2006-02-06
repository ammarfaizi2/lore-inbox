Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWBFD3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWBFD3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWBFD3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:29:21 -0500
Received: from smtpout.mac.com ([17.250.248.87]:8654 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750885AbWBFD3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:29:21 -0500
In-Reply-To: <17382.43646.567406.987585@cse.unsw.edu.au>
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <43DEC095.2090507@zytor.com> <17374.50399.1898.458649@cse.unsw.edu.au> <43DEC5DC.1030709@zytor.com> <17382.43646.567406.987585@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BBB1D529-4E8F-48A9-BAB2-698B7B132C42@mac.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Exporting which partitions to md-configure
Date: Sun, 5 Feb 2006 22:29:14 -0500
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2006, at 20:46, Neil Brown wrote:
> On Monday January 30, hpa@zytor.com wrote:
>> Well, if we're going to have a generic facility it should make  
>> sense across the board.  If all we're doing is supporting legacy  
>> usage we might as well export a flag.
>>
>> I guess we could have a single entry with a string of the form  
>> "efi:e6d6d379-f507-44c2-a23c-238f2a3df928" or "msdos:fd" etc -- it  
>> really doesn't make any difference to me, but it seems cleaner to  
>> have two pieces of data in two different sysfs entries.
>
> What constitutes 'a piece of data'?  A bit? a byte?
>
> I would say that
>    msdos:fd
> is one piece of data.  The 'fd' is useless without the 'msdos'. The  
> 'msdos' is, I guess, not completely useless with the fd.  I would  
> lean towards the composite, but I wouldn't fight a separation.

I think this boundary is blurred by the fact that several partition  
tables allow mostly-arbitrary partition type strings.  It would be  
convenient to not have to worry about the prefix in that case.  You  
would need just the partition type in the parent device anyways, so  
why munge it into the partition label too?

>>> And if other partition styles wanted to add support for raid auto
>>> detect, tell them "no". It is perfectly possible and even preferable
>>> to live without autodetect.   We should support legacy usage (those
>>> above) but should discourage any new usage.
>>
>> Why is that, keeping in mind this will all be done in userspace?
>
> partition-type based autodetect is easily fooled.  If you take a  
> pair of drives from a failed computer, plug them into a similar  
> computer for data recovery, and boot:  you might have two different  
> pairs of drives that both want to be 'md0'.  Which wins?

Nonono, not _just_ partition-type based autodetect, but a more  
complicated solution done _completely_ in userspace.  Essentially, by  
exporting this data you would merely be providing _extra_ pieces of  
data that could be verified on boot.  If I know that my boot RAID  
volumes for my desktop always have a partition table type string of  
"Linux_RAID_<unique-id>", then I can _also_ verify that in my  
initramdisk.  This isn't as useful on x86, but that's no reason to  
prevent it from being used on archs that do allow 31+ character  
strings for partition types.

> I believe there needs to be a clear, non ambigous, causality path  
> from the kernel paramters, initramfs, or machine hardware that  
> leads to the arrays to be assembled and hence the filesystem to be  
> mounted.

This is one way of doing that on a systems with mac partition  
tables.  The autoprobing is mostly useless on x86 hardware due to the  
limited range of partition types, but that's x86's problem.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



