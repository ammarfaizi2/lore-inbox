Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbTAYGno>; Sat, 25 Jan 2003 01:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTAYGno>; Sat, 25 Jan 2003 01:43:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:14060 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261409AbTAYGnn>;
	Sat, 25 Jan 2003 01:43:43 -0500
Date: Fri, 24 Jan 2003 22:53:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030124225320.5d387993.akpm@digeo.com>
In-Reply-To: <20030124153929.A894@namesys.com>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2003 06:52:50.0662 (UTC) FILETIME=[608C5060:01C2C43E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Ok, So far simplest way of reproducing for me was this:
> mkdir /mnt
> fsstress -p 10 -n1000000 -d /mnt &
> fsx -c 1234 testfile
> 
> Now look at fsx output. When it says about "truncating to largest ever: 0x3ffff",
> wait 10 more seconds and if nothing happens, ^C the fsx,
> run "rm -rf testfile*"
> now run fsx again
> and so on until it fails.
> 
> Last time it took me three iterations to reproduce.
> 

Well I've been running this for a couple of hours:

	#!/bin/sh
	while true
	do
	        fsstress -p 10 -n1000000 -d . &
	        fsx-linux -c 1234 testfile &
	        sleep 180
	        killall fsx-linux fsstress
	        sleep 1
	done

Chance of close/open is 1 in 1234
seed = 1043574092
truncating to largest ever: 0x13e76
truncating to largest ever: 0x2e52c
truncating to largest ever: 0x3c2c2
truncating to largest ever: 0x3f15f
truncating to largest ever: 0x3fcb9
truncating to largest ever: 0x3fe96
truncating to largest ever: 0x3ff9d
truncating to largest ever: 0x3ffff
skipping zero size read
skipping zero size write
/home/akpm/fsx-test: line 9:  1253 Terminated              fsstress -p 10 -n1000000 -d .
signal 15
testcalls = 95103
seed = 1043594552


So I'm going to have to ask you to investigate further.  Does it happen on
other machines?  Other filesystems?  Older kernels?  That sort of thing.

Thanks.
