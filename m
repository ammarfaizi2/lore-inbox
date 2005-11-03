Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbVKCVUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbVKCVUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbVKCVUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:20:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26254 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030490AbVKCVT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:19:59 -0500
Date: Fri, 4 Nov 2005 08:19:59 +1100
From: Nathan Scott <nathans@sgi.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large file system oddities
Message-ID: <20051104081959.C6290773@wobbly.melbourne.sgi.com>
References: <20051103190334.GI2507@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051103190334.GI2507@mail.muni.cz>; from xhejtman@mail.muni.cz on Thu, Nov 03, 2005 at 08:03:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 08:03:34PM +0100, Lukas Hejtmanek wrote:
> Hello,
> 
> I use vanilla kernel 2.6.13.4 on Pentium 4 with EM64T extensions in x86_64 mode.
> 
> I have 3.5TB partition formated as XFS.

Looks like you actually ended up with a 1.2TB partition formatted
as XFS on a 3.5TB device...

> Using fdisk I made one big partition accross whole disk:

Why?  Just use /dev/sdc directly, and you'll avoid the 32 bit
problems fdisk (or the default partition table type, I can't
remember which it is now) evidently has.

>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdc1               1       53201  3418696008   83  Linux

> # cat /proc/partitions 
>    8    32 3418704128 sdc
>    8    33 1271212360 sdc1

Yes, there's your problem.

> I made XFS file system on it:
> # mkfs.xfs -f -s size=4096 -d su=65536,sw=7 /dev/sdc1

mkfs.xfs is just using the information that its given from the
kernel, which is the second /proc/partitions line above.

> So what's wrong? Or am I something missing?

Try without the partition, looks like that'll work.

cheers.

-- 
Nathan
