Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTAYXWc>; Sat, 25 Jan 2003 18:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTAYXWc>; Sat, 25 Jan 2003 18:22:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:20478 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264878AbTAYXWb>;
	Sat, 25 Jan 2003 18:22:31 -0500
Date: Sat, 25 Jan 2003 15:32:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5 hangs on boot
Message-Id: <20030125153217.6ff6e275.akpm@digeo.com>
In-Reply-To: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com>
References: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2003 23:31:40.0107 (UTC) FILETIME=[E947E9B0:01C2C4C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler <ttsig@tuxyturvy.com> wrote:
>
> I was interested in testing the new IO scheduler in 2.5.59-mm5 because
> it attempts to correct a problem that has always bothered me

Yup.

> but with
> this kernel (using the identical config to -mm2) my system hangs almost
> immediately after boot.

Several people are reporting this.  We seem to have lost a disk request or
such.

First up, please see if changing this:

	static int antic_expire = HZ / 25;

to

	static int antic_expire = 0;

in drivers/block/deadline-iosched.c fixes it up.


If not then please confirm that

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-luuk/2.5.59-luuk.gz

still causes the problem.

If so then I'd really appreciate it if you could work through the individual
patches in

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-luuk/broken-out/

and find out which one is causing the problem.  The patch application order is

vmlinux-fix.patch
deadline-np-42.patch
deadline-np-43.patch
reiserfs-readpages.patch
ext3-scheduling-storm.patch
auto-unplug.patch
less-unplugging.patch
kirq.patch
kirq-up-fix.patch
ext3-truncate-ordered-pages.patch
vma-file-merge.patch
quota-lockfix.patch
quota-offsem.patch
dont-wait-on-inode.patch

Thanks.
