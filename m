Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTFSUvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265411AbTFSUvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:51:23 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:27190 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265188AbTFSUvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:51:21 -0400
Message-ID: <3EF224B2.1010909@rackable.com>
Date: Thu, 19 Jun 2003 14:01:38 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Venkat <rpraneshnews@yahoo.com>
CC: linux-kernel@vger.kernel.org, srikumarss@yahoo.com
Subject: Re: Linux IDE & RAID Rebuid Issue
References: <20030619204308.39271.qmail@web14802.mail.yahoo.com>
In-Reply-To: <20030619204308.39271.qmail@web14802.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 21:05:20.0791 (UTC) FILETIME=[7E4C5A70:01C336A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkat wrote:

>Hi all,
>I have two IDE controllers in my mother board 
>(Serverworks and Silicon Image CMD 680) . I have two
>Maxtor IDE Drives(same model, same capacity) connected
>to the IDE controllers (One drive per controller). 
>Linux detects the drives but the number of heads
>reported by the controller/BIOS/Linux is different.
>For one drive linux reports 64 heads and for the other
>drive it reports 255 heads. This is causing a problem
>with RAID rebuilding. The below text explains the
>problem in detail.
>
>I create a RAID drive across both the drives.I want to
>create a 512 MB partition on both the drives, but
>Redhat installatiion program creates 512MB partition
>on one drive and 520MB partition on the other drive. I
>assume that this discrepanies is due to different Head
>count.
>
>This is OK when the RAID drives are created, because
>the RAID drive takes the smallest size(512MB)
>
>But the problem happens when the one of the drives is
>pulled out and a new partition of same size is created
>and the RAID drives are rebuilt. When i create the
>same size partition on the new drive using FDISK, it
>is not exactly the size i want (512MB). It creates a
>509 MB Partition on the new drive. This causes the MD
>RAID driver to fail the rebuild.
>The new drive is also of the same type and same model
>as the drive pulled out.
>
>So i assume that if Linux reports the same head count
>for the both the drives, the problem should be solved.
>I am not an expert on Linux IDE subtree. Can anyone
>explain or give a fix?
>
>  
>

  Try the below.  (This will not work if you have extented partitions on 
the drive.)

dd if=/dev/gooddisk of=/dev/newdisk  count=2048

echo "w" |fdisk /dev/newdisk

fdisk -l /dev/newdisk /dev/goodisk

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


