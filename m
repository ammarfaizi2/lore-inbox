Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbRHAR3J>; Wed, 1 Aug 2001 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRHAR3A>; Wed, 1 Aug 2001 13:29:00 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:18614 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S267642AbRHAR2m>; Wed, 1 Aug 2001 13:28:42 -0400
Date: Wed, 1 Aug 2001 13:43:23 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Disk quotas not staying in sync?
Message-ID: <Pine.LNX.4.31.0108011322470.4569-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm missing something silly, but I can't seem to put my finger on
whats happening here.

I have a sever that holds the e-mail and webpages for our dial-up
customers.  Each user (for the most part) gets 20MB of space to hold their
files.

So people, for what ever reason, get so much e-mail they run up to their
quota.  They have trouble downloading 20MB of mail across a dial-up link,
and really don't want all the messages (picutues) anyway.  So one of the
techs here will just wipe out the messages.

We are using the Maildir format to store the mail, so each message is in a
seperate file.

The problem is sometimes after all the messages have been deleted they
still can't get any new mail.  Looking at their quota usage the machine
still thinks that they have their quota full, but `du` says otherwise.
Running `quotacheck` fixes things up.

I've tried to reproduce this with a test account.  Just creating a bunch
of files to run up to the quota and then deleting them.  But no matter
what I tried the system followed the test account's disk usage exactly.

This doesn't just happen when someone runs up to their quota.  I have also
seen their quota usage not correctly reflect what is on disk, but as the
usage goes up and down, both the actual disk usage and the what quota says
change by the same amount.

Any ideas?  This machine is pretty much standard.  ext2 file systems on
all partitions.  /home is the only one with user disk quotas.  Running
2.4.7 kernel (but I've seen it in all 2.4 kernels, I was running
2.4.0-prerelease on the machine when I first put it up, so I don't know
how 2.2 works).  To access the disks I'm using a sym53c8xx controller that
is talking to a hardware RAID controller that has the disks behind it.

Thanks,
Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


