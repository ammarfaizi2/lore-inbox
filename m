Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUF2Q5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUF2Q5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUF2Q5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:57:18 -0400
Received: from [66.199.228.3] ([66.199.228.3]:17158 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S265810AbUF2Q5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:57:10 -0400
Date: Tue, 29 Jun 2004 09:57:10 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406291657.i5TGvARd028334@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released [SOLVED!!!]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've located the source of the leak.

Linux is innocent! Sorry for doubting you.

The problem is mozilla/flash allocates shared memory
segments but doesn't get a chance to clean them up properly.

So:
Flash memory leak is present related to japanese fonts and our
particular flash content.

We've installed a watchdog process that kills mozilla and
restarts it once it uses up too much memory.

The watchdog process kills mozilla so mozilla doesn't have an
opportunity to free up its shared memory allocations.
They build up over time:
------ Shared Memory Segments --------
key       shmid     owner     perms     bytes     nattch    status      
0x00000000 3014673   root      666       1920000   0                     
0x00000000 1310738   root      666       1920000   0                     
0x00000000 2162707   root      666       1920000   0                     
0x00000000 5537812   root      666       1920000   0                     
0x00000000 3866645   root      666       1920000   0                     
0x00000000 4718614   root      666       1920000   0                     

When I ipcrm these the cached memory goes back down to normal levels.

Thanks for everyone who responded, and sorry for wasting everyone's time.

-Dave
