Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWH2SA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWH2SA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWH2SA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:00:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965196AbWH2SA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:00:57 -0400
Date: Tue, 29 Aug 2006 11:00:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Drop cache has no effect?
Message-Id: <20060829110048.20e23e75.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 14:53:34 +0200 (MEST)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> Hello,
> 
> 
> recently I picked up knowledge of /proc/sys/vm/drop_caches 
> (http://lkml.org/lkml/2006/8/4/95)
> 
> It does not always work right away:
> 
> (/U is a vfat, that is, permissions are back to 755 as soon as the caches 
> are gone)
> 14:51 gwdg-wb04A:/U # chmod 644 *
> 14:51 gwdg-wb04A:/U # sync
> 14:51 gwdg-wb04A:/U # echo 2 >/proc/sys/vm/drop_caches 
> 14:51 gwdg-wb04A:/U # l
> total 50713
> drwxr-xr-x   3 jengelh users     2048 2006-08-29 14:48 .
> drwxr-xr-x  22 root    root      4096 2006-08-25 14:00 ..
> drw-r--r--   2 jengelh users     2048 2006-08-29 13:55 as
> -rw-r--r--   1 jengelh users 13806629 2006-08-29 14:00 all-20060611.tar.bz2
> -rw-r--r--   1 jengelh users 37816633 2006-07-28 19:25 
> inkscape-0.44-2.guru.suse101.i686.rpm
> -rw-r--r--   1 jengelh users   297243 2006-08-15 01:13 
> vmware-any-any-update104.tar.gz
> 
> Remains 644.
> 

That would be a vfat problem - the changed permission bits weren't written
back to disk, so when you re-read them from disk (or, more likely, from
blockdev pagecache) they came back with the original values.

Does vfat even have the ability to store the seven bits?  Don't think so? 
If not, permitting the user to change them in icache but not being to write
them out to permanent store seems rather bad behaviour.
