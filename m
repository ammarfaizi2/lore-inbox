Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCWSDJ>; Fri, 23 Mar 2001 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRCWSC7>; Fri, 23 Mar 2001 13:02:59 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:22438 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129245AbRCWSCz>; Fri, 23 Mar 2001 13:02:55 -0500
Message-ID: <3ABB8F57.3000800@muppetlabs.com>
Date: Fri, 23 Mar 2001 10:00:55 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: RAMFS, CRAMFS and JFFS2(was Re: /linuxrc query)
In-Reply-To: <3ABAF64A.1040106@muppetlabs.com>  <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net> <9118.985356471@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I did consider CRAMFS and JFFS2 when it was announced on the mtd list. 
Conserving flash over system ram is more relevant. Our reasons are below:

RAMFS v/s CRAMFS
1. RAMFS is just more stable in terms of less complexity, less bugs reported 
over the time, etc.
2. RAMFS is a fairly robust filesystem and all features required as far as I can 
tell.

RAMFS v/s ext2 on a ramdisk
1. Fixed size. Results in overallocation or more dangerously overshooting the 
size decided earlier during mke2fs.

RAMFS v/s JFFS2
1. JFFS2 was announced around a month ago and few utils were still in 
development, hence it was not there for the first development cycle.
2. Just offhand, joining 100 small files (say in /etc) and then compressing into 
a one file over these 100 files in a JFFS2 fs seems to give better overall space 
usage and probably less flash wear during modifications.
3. JFFS2 does has some compelling reasons, more robustness ofcourse with JFFS2 
over above approach, flash wearing(though would require sufficient free space on 
that mtd partition), etc. Plan to compare these later.

I might be wrong and hence would welcome any suggestions.

Regards
Amit

David Woodhouse wrote:

> amit@muppetlabs.com said:
> 
>>  Also as a note, what we are doing is keeping our rootfs on flash as a
>> tar.gz and  reading it and mounting it on a ramfs in the /linuxrc
>> before doing a pivot_root.  To summarize, pivot_root has been a life
>> saver as the earlier real_root_dev  might not have been useful in this
>> case. Not using the ramfs limits for now, will do soon.
> 
> 
> If you're concerned about memory usage - why untar the whole of your root
> filesystem into a ramfs? My preferred solution is to just mount the root
> filesystem directly from the flash as cramfs (or JFFS2), with symlinks into a
> ramfs for appropriate parts like /tmp and /var.
> 
> I suppose the best option is actually to union-mount the ramfs over the 
> root, rather than mucking about with symlinks. I just haven't got round to 
> doing that yet.
> 
> --
> dwmw2

