Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbTCJP7x>; Mon, 10 Mar 2003 10:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261343AbTCJP7x>; Mon, 10 Mar 2003 10:59:53 -0500
Received: from sapporo.toad.net ([162.33.130.41]:27800 "EHLO sapporo.toad.net")
	by vger.kernel.org with ESMTP id <S261342AbTCJP7v>;
	Mon, 10 Mar 2003 10:59:51 -0500
Date: Mon, 10 Mar 2003 11:10:28 -0500
From: "Matt P." <matt@area403.org>
To: linux-kernel@vger.kernel.org
Subject: pb with init for 2.5.62, not 2.4.20
Message-ID: <20030310161027.GA4386@scyld.com>
Reply-To: matt@area403.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux copperhead 2.4.17
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know if this is a kernel issue, but since I have a pb with one
kernel and not the other, I assume it is... Please don't flame.

I am trying to have a small distro that uses ramdisk for its partitions
that need rw access, and the cd for the rest. Part of the script
(slurped from boot-cd hint from linux from scratch) consists in copying
over from the cd to the ramdisk these partitions (script in app-1).

The behavior depend on the kernel... after the last mount, with 2.5 the
fake/needwrite directory doesn't contain anything, whereas with 2.4.20
it does contain what I put in it. And I think it is related, but with
2.5, I never get into run level 1 or 2 or 3, it just hangs after the
last script in rcsysinit.d., whereas 2.4.20 slides smoothly into
whatever inittab tells him to.

Do I need extra modules in 2.5?

(Note that the size of 2.4 is ~ 930k, where as 2.5 is 1.5M)

Thx for any suggestion.

Matt


App 1:

#!/bin/sh
dev_ram=/dev/ram0
dir_ramdisk=/fake/ramdisk
dir_needwrite=/fake/needwrite

source /etc/rc.d/init.d/functions

case "$1" in
        start)
                echo -n "Creating ext2fs on $dev_ram ...              "
                /sbin/mke2fs -m 0 -i 1024 -q $dev_ram > /dev/null 2>&1
                evaluate_retval
                sleep 1
                echo -n "Mounting ramdisk on $dir_ramdisk ...         "
                mount -n $dev_ram $dir_ramdisk
                evaluate_retval
                sleep 1
                echo -n "Copying files to ramdisk ...                 "
                cp -dpR $dir_needwrite/* $dir_ramdisk > /dev/null 2>&1
                evaluate_retval
                sleep 1
                echo -n "Remount ramdisk to $dir_needwrite ...        "
                umount -n $dir_ramdisk > /dev/null 2>&1
                sleep 1
                mount -n $dev_ram $dir_needwrite
                sleep 1
                ;;
        *)
                echo "Usage: $0 {start}"
                exit 1
                ;;
esac
