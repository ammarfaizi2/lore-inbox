Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSKMRJ1>; Wed, 13 Nov 2002 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKMRJ1>; Wed, 13 Nov 2002 12:09:27 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:58353 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S262314AbSKMRJZ>; Wed, 13 Nov 2002 12:09:25 -0500
Message-ID: <3DD28914.3050107@mvista.com>
Date: Wed, 13 Nov 2002 10:17:08 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: Brian Jackson <brian-kernel-list@mdrx.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com> <20021113114641.GI19811@marowsky-bree.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars,

Another method is to lock an md array to a specific host.  This method 
requires no DLM (since there is no shared write to the same array 
capability).

Thanks
-steve

Lars Marowsky-Bree wrote:

>On 2002-11-12T18:25:29,
>   Brian Jackson <brian-kernel-list@mdrx.com> said:
>
>  
>
>>Does the MD driver work with shared storage? I would also be interested to 
>>know if the new DM driver works with shared storage(though I must admit I 
>>didn't really try to answer this one myself, just hoping somebody will 
>>know). 
>>    
>>
>
>The short answer is "Not sanely", as far as I know.
>
>RAID0 might be okay, however RAID1/5 get into issues if two nodes update the
>same data in parallel; they do not coordinate the writes, and thus might stomp
>over each other.
>
>In theory, given a RAID1 with disks {d1,d2}, node n1 might write in order
>(d2,d1) while n2 writes as (d1,d2), resulting in inconsistent mirrors. This
>becomes a bigger race window for RAID5, obviously, because more disks are
>involved.
>
>The "multiple nodes beginning to reconstruct the same md device" is also a
>problem; but even if that was solved that only one node does the recovery, the
>others would be blocked from doing any IO on that drive for the time being.
>
>Another issue that any node will want to update the md superblock regularly.
>
>LVM is fine, MD doesn't seem to be.
>
>With the MD patches I posted weeks ago, at least MD multipathing should work
>appropriately; even if the ugliness of multiple nodes scribbling over the
>superblock remains, it shouldn't matter because the autodetection is based
>only on the UUID for m-p.
>
>In short, you can do "MD", if you don't use it as "shared"; have only one node
>have a given md device active at any point in time. Thus, no autostart, but
>manual activation. This rules out "GFS over md", basically.
>
>If you want to fix that, it would be cool; it will just require a DLM,
>membership and communication services in the kernel. ;-)
>
>
>Sincerely,
>    Lars Marowsky-Brée <lmb@suse.de>
>
>  
>

