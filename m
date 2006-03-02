Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWCBQsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWCBQsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCBQsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:48:35 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:32785 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751000AbWCBQse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:48:34 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Neil Brown <neilb@suse.de>
Subject: RAID5 initial rebuild slow, 2.6.16-rc4
Date: Thu, 2 Mar 2006 16:48:21 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021648.21465.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

I recently purchased two SATA2 Western Digital WD2500KS (250GB) HDs to add to 
a pair of Maxtor DiamondMax 10's (200GB). I planned to initialise two 100GB 
RAID5 arrays spanning all four drives (the remaining 2x50GB on the new HDs is 
currently used for booting).

All the drives are connected to the same controller. I'm running mdadm 2.3.1, 
which is the latest version I believe. I created the array with the following 
command:

mdadm --create /dev/md1 --auto=yes --chunk=64 --level=5 
--raid-devices=4 /dev/sda3 /dev/sdb3 /dev/sdc2 /dev/sdd2

A few seconds later the array completed and I got the following 
in /proc/mdstat:

[root] 16:45 [~] cat /proc/mdstat
Personalities : [raid0] [raid5] [raid4] [multipath]
md2 : active raid0 sdb1[1] sda1[0]
      195318016 blocks 32k chunks

md1 : active raid5 sdd2[4] sdc2[2] sdb3[1] sda3[0]
      298736448 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
      [>....................]  recovery =  0.5% (501376/99578816) 
finish=1646.2min speed=1000K/sec

I've not yet attempted to put a filesystem on the device, because I planned to 
wait until the (presumably pointless) recovery process completed. However, 
this rebuild seems to be extremely slow (the speed never exceeds the 
"minimum" recovery speed). CPU usage is almost nill.

This machine is an Athlon64 X2 3800+, with 2GB RAM, running an x86_64 kernel. 
Is there any reason for this poor performance?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
