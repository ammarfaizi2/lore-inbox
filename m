Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVKROSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVKROSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKROSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:18:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64916 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750752AbVKROSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:18:49 -0500
Message-ID: <437DE2BF.8010008@namesys.com>
Date: Fri, 18 Nov 2005 17:18:39 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sander@humilis.net, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: segfault mdadm --write-behind, 2.6.14-mm2 
References: <431B9558.1070900@baanhofman.nl>	<17179.40731.907114.194935@cse.unsw.edu.au>	<20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org>
In-Reply-To: <20051116142000.5c63449f.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Andrew Morton wrote:
> Sander <sander@humilis.net> wrote:
>>Neil Brown wrote (ao):
>>> If you use mdadm-2.0 and mark a device as --write-mostly, then all
>>> read requests will go to the other device(s) if possible,.
>>> e.g.
>>>   mdadm --create /dev/md0 --level=1 --raid-disks=2 /dev/ramdisk \
>>>      --writemostly /dev/realdisk
>>>
>>> Does this suit your needs?
>>>
>>> You can also arrange for the write to the writemostly device to be
>>> 'write-behind' so that the filesystem doesn't wait for the write to
>>> complete.  This can reduce write-latency (though not increase write
>>> throughput) at a very small cost of reliability (if the RAM dies, the
>>> disk may not be 100% up-to-date).
>>With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
>>try this:
> 
> It oopsed in reiser4.  reiserfs-dev added to Cc...
> 
>>mdadm -C /dev/md1 -l1 -n2 --bitmap=/storage/md1.bitmap /dev/loop0 \
>>--write-behind /dev/loop1
>>
>>loop0 is attached to a file on tmpfs, and loop1 is attached
>>to a file on a lvm2 volume (reiser4, if that matters).
>>

I tried ext2 on lvm2 and that did not help.
So, for now I would assume that the problem is not in reiser4 but somewhere else.

