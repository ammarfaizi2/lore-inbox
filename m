Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbTAXMaY>; Fri, 24 Jan 2003 07:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTAXMaY>; Fri, 24 Jan 2003 07:30:24 -0500
Received: from angband.namesys.com ([212.16.7.85]:1664 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267642AbTAXMaX>; Fri, 24 Jan 2003 07:30:23 -0500
Date: Fri, 24 Jan 2003 15:39:29 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030124153929.A894@namesys.com>
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030124023213.63d93156.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 24, 2003 at 02:32:13AM -0800, Andrew Morton wrote:

> The below patch should fix it up - please test that.

Yup. The patch gets rids of those lots of inode problems.
But fsx issue is still there.

> So that's the umount problem.  I don't know why you're getting the fsx-linux
> failure - I was unable to hit it in an hour's run of the above workload on
> 4-way.  Against both scsi and IDE.  So please look further into that, thanks.

Ok, So far simplest way of reproducing for me was this:
mkdir /mnt
fsstress -p 10 -n1000000 -d /mnt &
fsx -c 1234 testfile

Now look at fsx output. When it says about "truncating to largest ever: 0x3ffff",
wait 10 more seconds and if nothing happens, ^C the fsx,
run "rm -rf testfile*"
now run fsx again
and so on until it fails.

Last time it took me three iterations to reproduce.

Bye,
    Oleg
