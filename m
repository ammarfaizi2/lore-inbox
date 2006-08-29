Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWH2Tty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWH2Tty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWH2Tty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:49:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWH2Ttx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:49:53 -0400
Date: Tue, 29 Aug 2006 12:49:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Drop cache has no effect?
Message-Id: <20060829124945.656dbaa1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0608292117320.5502@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
	<20060829110048.20e23e75.akpm@osdl.org>
	<Pine.LNX.4.61.0608292117320.5502@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 21:21:25 +0200 (MEST)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> -rw-r--r--   1 jengelh users 37816633 2006-07-28 19:25 
> >> inkscape-0.44-2.guru.suse101.i686.rpm
> >> -rw-r--r--   1 jengelh users   297243 2006-08-15 01:13 
> >> vmware-any-any-update104.tar.gz
> >> 
> >> Remains 644.
> >
> >That would be a vfat problem - the changed permission bits weren't written
> >back to disk, so when you re-read them from disk (or, more likely, from
> >blockdev pagecache) they came back with the original values.
> 
> Yes, that's _intended_.
> 
> Fact:
> If you chmod 644 some files on vfat, then unmount and mount it again, they show
> up as 755 again. That is ok.
> 
> Observation:
> Dropping the cache does not imply the 644->755 change observed on unmount.
> 
> Conclusion:
> Caches not dropped.

Not all caches dropped.  It'd be silly to try that - see the implementation.

Running the same command a few more times might wring a couple more dentries
and inodes out of it.
