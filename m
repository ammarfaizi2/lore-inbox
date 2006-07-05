Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWGEMTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWGEMTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGEMTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 08:19:09 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:15877 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964832AbWGEMTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 08:19:08 -0400
Message-ID: <44ABAE38.7080107@argo.co.il>
Date: Wed, 05 Jul 2006 15:19:04 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <44ABAB2D.5050305@tmr.com>
In-Reply-To: <44ABAB2D.5050305@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 12:19:05.0803 (UTC) FILETIME=[357D89B0:01C6A02D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
>
> > I believe that implementing RAID in the filesystem has many benefits 
> too:
> > - multiple RAID levels: store metadata in triple-mirror RAID 1, random
> > write intensive data in RAID 1, bulk data in RAID 5/6
> > - improved write throughput - since stripes can be variable size, any
> > large enough write fills a whole stripe
> >
> I rather like the idea of allowing metadata to be on another device in
> general, or at least the inodes. That way a very small chunk size can be
> used for the inodes, to spread head motion, while a larger chunk size is
> appropriate for data in some cases.
>

If your workload is metadata intensive, your data disks are idle; if 
you're reading data, the inode device is gathering dust. You can run out 
of inodes before you run out of space and vice-versa. Very suboptimal.

A symmetric configuration allows full use of all resources for any 
workload, at the cost of increased complexity - every extent has its own 
RAID level and RAID component devices.

> Larger max block sizes would be useful as well. Feel free to discuss the
> actual value of "larger."
>

Filesystems should use extents, not blocks, avoiding the block size 
tradeoff entirely.

-- 
error compiling committee.c: too many arguments to function

