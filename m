Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbTCZMP1>; Wed, 26 Mar 2003 07:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbTCZMP1>; Wed, 26 Mar 2003 07:15:27 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:22207 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261646AbTCZMP0>; Wed, 26 Mar 2003 07:15:26 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Date: Wed, 26 Mar 2003 12:26:37 +0000 (UTC)
Message-ID: <slrnb8373s.19a.usenet@bender.home.hensema.net>
References: <20030326013839.0c470ebb.akpm@digeo.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@digeo.com) wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm1/

LVM or device mapper seems to be broken in -mm. I've only tried the
following kernels so far:
2.5.64 - works
2.5.65-mm2 - doesn't work
2.5.66 - works
2.5.66-mm1 - doesn't work

I'm getting these messages while setting up LVM from my bootscripts (I've
included the actual commands prefixed with a > ):

Remounting root file system (/) read/write for vgscan...
> mount -n -o remount,rw /
Removing old device inodes...
> rm /dev/system/* /dev/mapper/*
Setting up devices...
> /usr/local/sbin/devmap_mknod.sh
Creating /dev/mapper/control character device with major:10 minor:63.
Scanning for LVM volume groups...
> /usr/local/sbin/vgscan
  Reading all physical volumes.  This may take a while...
  Found volume group "system" using metadata type lvm1
Activating LVM volume groups...
> /usr/local/sbin/vgchange -a y system
device-mapper: allocating minor 0.
device-mapper: allocating minor 1.
device-mapper: destroying md
device-mapper: destroying table
device-mapper: allocating minor 0.
device-mapper: destroying md
device-mapper: destroying table
  1 logical volume(s) in volume group "system" now active

The only active volume is the most recently created volume.

On 2.5.6x-vanilla the output of vgchange is:
device-mapper: allocating minor 0.
device-mapper: allocating minor 1.
device-mapper: allocating minor 2.
  3 logical volume(s) in volume group "system" now active
 
-- 
Erik Hensema <erik@hensema.net>
