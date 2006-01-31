Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWAaCF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWAaCF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWAaCF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:05:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:32450 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030266AbWAaCF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:05:27 -0500
Message-ID: <43DEC5DC.1030709@zytor.com>
Date: Mon, 30 Jan 2006 18:05:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com>	<17374.47368.715991.422607@cse.unsw.edu.au>	<43DEC095.2090507@zytor.com> <17374.50399.1898.458649@cse.unsw.edu.au>
In-Reply-To: <17374.50399.1898.458649@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Well, grepping through fs/partitions/*.c, the 'flags' thing is set by
>  efi.c, msdos.c sgi.c sun.c
> 
> Of these, efi compares something against PARTITION_LINUX_RAID_GUID,
> and msdos.c, sgi.c and sun. compare something against
> LINUX_RAID_PARTITION.
> 
> The former would look like
>   e6d6d379-f507-44c2-a23c-238f2a3df928
> in sysfs (I think);
> The latter would look like
>   fd
> (I suspect).
> 
> These are both easily recognisable with no real room for confusion.

Well, if we're going to have a generic facility it should make sense 
across the board.  If all we're doing is supporting legacy usage we 
might as well export a flag.

I guess we could have a single entry with a string of the form 
"efi:e6d6d379-f507-44c2-a23c-238f2a3df928" or "msdos:fd" etc -- it 
really doesn't make any difference to me, but it seems cleaner to have 
two pieces of data in two different sysfs entries.

> 
> And if other partition styles wanted to add support for raid auto
> detect, tell them "no". It is perfectly possible and even preferable
> to live without autodetect.   We should support legacy usage (those
> above) but should discourage any new usage.
> 

Why is that, keeping in mind this will all be done in userspace?

	-hpa

