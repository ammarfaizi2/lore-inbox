Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWGHRv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWGHRv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWGHRv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:51:57 -0400
Received: from mail.tmr.com ([64.65.253.246]:29366 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964889AbWGHRv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:51:56 -0400
Message-ID: <44AFF152.5050103@tmr.com>
Date: Sat, 08 Jul 2006 13:54:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <44ABAB2D.5050305@tmr.com> <44ABAE38.7080107@argo.co.il>
In-Reply-To: <44ABAE38.7080107@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Bill Davidsen wrote:
>>
>> > I believe that implementing RAID in the filesystem has many benefits 
>> too:
>> > - multiple RAID levels: store metadata in triple-mirror RAID 1, random
>> > write intensive data in RAID 1, bulk data in RAID 5/6
>> > - improved write throughput - since stripes can be variable size, any
>> > large enough write fills a whole stripe
>> >
>> I rather like the idea of allowing metadata to be on another device in
>> general, or at least the inodes. That way a very small chunk size can be
>> used for the inodes, to spread head motion, while a larger chunk size is
>> appropriate for data in some cases.
>>
> 
> If your workload is metadata intensive, your data disks are idle; if 
> you're reading data, the inode device is gathering dust. You can run out 
> of inodes before you run out of space and vice-versa. Very suboptimal.

Using the correct resource for the job is very optimal, no RAID will 
make big slow cheap drives fast for inodes, no fast drive is practical 
in cost or heat for moderately large data.
> 
> A symmetric configuration allows full use of all resources for any 
> workload, at the cost of increased complexity - every extent has its own 
> RAID level and RAID component devices.

Why would you want to use all your resources when only part of them are 
at all suited to the job?

Do consider the price and performance of 15k RPM Ultra320 drives (32GB) 
vs. 750GB SATA before telling me that it doesn't work better to have 
metadata on fast storage and application data on cheap drives. You can 
use 10TB of 300kB avg files in random directories as a model. Figure 10% 
churn every day, delete and create not rewrite, 27 creates/sec and 
200-300 open for read/sec.
> 
>> Larger max block sizes would be useful as well. Feel free to discuss the
>> actual value of "larger."
>>
> 
> Filesystems should use extents, not blocks, avoiding the block size 
> tradeoff entirely.
> 

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
