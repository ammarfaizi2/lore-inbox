Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUALTVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUALTVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:21:07 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.117]:41624 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264940AbUALTVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:21:05 -0500
Message-ID: <4002F317.2070102@myrealbox.com>
Date: Mon, 12 Jan 2004 11:18:47 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reserfs-list@namesys.com
Subject: loopback over reiserfs broken in 2.6.1-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

on 2.6.1-mm1, where /var is reiserfs:

[root@luto var]# dd if=/dev/zero of=foo count=1024
1024+0 records in
1024+0 records out
[root@luto var]# losetup /dev/loop0 foo
ioctl: LOOP_SET_FD: Invalid argument

This works on ext3 and XFS, and it worked on -test11.  It does not work 
in /tmp or anything bind-mounted off reiserfs, but it does work in bind 
mounts from ext3.  Any ideas?

/proc/mounts:

rootfs / rootfs rw 0 0
/dev/root / ext3 rw,noatime 0 0
none /dev devfs rw 0 0
/proc /proc proc rw 0 0
/sys /sys sysfs rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/hda5 /usr reiserfs rw,noatime 0 0
/dev/hda6 /var reiserfs rw,nosuid 0 0
/dev/hda7 /data xfs rw,noatime,nosuid,usrquota,logbufs=8 0 0
tmpfs /dev/shm tmpfs rw 0 0
/dev/hda6 /var/tmp reiserfs rw,nosuid 0 0


--Andy
