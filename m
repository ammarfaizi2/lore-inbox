Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVATNxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVATNxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVATNxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:53:41 -0500
Received: from smtp-bedford-x.mitre.org ([192.160.51.76]:6823 "EHLO
	smtp-bedford.mitre.org") by vger.kernel.org with ESMTP
	id S262102AbVATNxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:53:38 -0500
Message-ID: <41EFB7E0.60701@mitre.org>
Date: Thu, 20 Jan 2005 08:53:36 -0500
From: Jeff Blaine <jblaine@mitre.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: oom-killer active when overcommit_memory contains '2', and more...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see this as 2 bugs, personally, and will say right up front
that none of these problems exist in 2.4.10.  I don't mean
to sound flippant, but also have to say that the reality of
this is that I do not have the time to test things further
for anyone.  Filing this bug report is as much as I have time
for (in addition to all of the time I have spent on this
already before this message).

1.  Filling up the memory on a 2.6.10 box renders it completely
     and permanently useless even after the memory-filling process
     exits due to oom-killer's havoc.

     I came across this problem when running Iozone NFSv3
     benchmarks.  The client Linux box in question is running
     2.6.10 (Fedora Core 3 with latest updates) and has 4GB
     physical memory and 4GB in a swap partition.  To perform
     a proper Iozone benchmark for NFS testing, one needs to
     specify a test file size that is larger than the amount
     of memory in the client.  In my case, 4224MB is being
     specified:

          ./iozone -a -g 4224m -f /sol9server/testfile

     As soon as it finally gets to trying a file size of
     4194304, oom-killer steps in and starts blasting
     processes off my machine.  NFS stops functioning,
     RPC calls to the box fail, SSH connections are no
     longer accepted, and I generally have to hard
     powercycle the box.  That's pretty poor :)

2.  Andries Brouwer looked into this and asked me to try
     turning off oom-killer with the following command:

         echo 2 > /proc/sys/vm/overcommit_memory

     Re-running the 4GB benchmark with Iozone, this did
     nothing and oom-killer walked through the door blasting
     processes off of my machine, rendering it totally
     broken in the end.

