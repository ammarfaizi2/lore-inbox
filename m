Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbUJ1K7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbUJ1K7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUJ1K7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:59:11 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:27579 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262958AbUJ1K7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:59:06 -0400
Subject: Re: Livelock with the shmctl04 test program from linux test project
From: Alexander Nyberg <alexn@dsv.su.se>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41794334.1080206@colorfullife.com>
References: <41794334.1080206@colorfullife.com>
Content-Type: text/plain
Message-Id: <1098961145.787.7.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 28 Oct 2004 12:59:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Alexander,
> 
> >I'm seeing some sort of livelock on my dual amd64 with the shmctl04 test program
> >
> What do you mean with "sort of livelock"? Does it recover after a few 
> minutes, does it recover if you send a signal to the shmctl04 test app? 
> What is the contents of /proc/sysvipc/shm while xfce4 is running/not 
> running?

Sorry for late reply, but I just can't understand why & how this happens, been trying to grasp
the IPC/SHM part but I'm missing something. One processor gets locked up and never released.
I did:

printk("taking lock\n"); 
spin_lock(&info->lock);
printk("lock taken\n");

and it never prints out "lock taken" so i know where it locks up. Now the fun part,
spinlock debugging doesn't catch it, but I did a simple patch to show who is holding a lock
at the current time, and it appears noone has taken the lock. I really don't get this.


With xfce4 running:
       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime
         0      32768  1600                393216   629   608      2  1000  1000  1000  1000 1098960009          0 1098960009
         0      65537  1600                196608   644   608      2  1000  1000  1000  1000 1098960009          0 1098960009
         0      98306  1600                393216   646   668      2  1000  1000  1000  1000 1098960014 1098960014 1098960009
         0     131075  1600                393216   648   608      2  1000  1000  1000  1000 1098960021          0 1098960021
         0     163844  1600                393216   666   700      2  1000  1000  1000  1000 1098960029 1098960029 1098960023
         0     196613  1600                196608   666   700      2  1000  1000  1000  1000 1098960029 1098960029 1098960023
         0     229382  1600                393216   643   608      2  1000  1000  1000  1000 1098960023          0 1098960023
         0     262151  1600                393216   668   681      2  1000  1000  1000  1000 1098960025 1098960025 1098960025
         0     294920  1600                196608   648   608      2  1000  1000  1000  1000 1098960026          0 1098960026
         0     360457  1600                393216   706   711      2  1000  1000  1000  1000 1098960036 1098960036 1098960035
         0     425994  1600                393216   715   716      2  1000  1000  1000  1000 1098960039 1098960084 1098960039
         0     458763  1600                196608   715   608      2  1000  1000  1000  1000 1098960041          0 1098960041
         0     491532  1600                393216   642   608      2  1000  1000  1000  1000 1098960059          0 1098960059


Console only:
       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime


