Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJIXvb>; Tue, 9 Oct 2001 19:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277251AbRJIXvW>; Tue, 9 Oct 2001 19:51:22 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:28076 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S277203AbRJIXvK>; Tue, 9 Oct 2001 19:51:10 -0400
From: rwhron@earthlink.net
Date: Tue, 9 Oct 2001 19:54:29 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VFS: brelse error on reiserfs with linux-2.4.10-ac8 - ac10 - details
Message-ID: <20011009195429.A18067@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oct  9 19:24:43 rushmore kernel: VFS: brelse: Trying to free free buffer

I tracked the above error which I've only seen on 2.4.10-ac8 and 2.4.10-ac10
while running Linux Test Project on reiserfs.  

The offending test case appears to be:  mmap01

Here is a log of results:

root@rushmore:/usr/src/sources/l/ltp# date
Tue Oct  9 19:49:15 EDT 2001

root@rushmore:/usr/src/sources/l/ltp# mount -t ext2 /dev/hda7 /tmp

root@rushmore:/usr/src/sources/l/ltp# mmap01 ; mmap01 ; mmap01
mmap01      1  PASS  :  Functionality of mmap() successful
mmap01      1  PASS  :  Functionality of mmap() successful
mmap01      1  PASS  :  Functionality of mmap() successful

root@rushmore:/usr/src/sources/l/ltp# tail /var/log/messages
Oct  9 19:24:34 rushmore kernel: Loaded 131 symbols from 11 modules.
Oct  9 19:24:43 rushmore kernel: VFS: brelse: Trying to free free buffer
Oct  9 19:26:19 rushmore exiting on signal 15
Oct  9 19:45:51 rushmore syslogd 1.4.1: restart.
Oct  9 19:45:51 rushmore kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  9 19:45:51 rushmore kernel: Inspecting /boot/System.map-2.4.10-ac10a
Oct  9 19:45:51 rushmore kernel: Loaded 13702 symbols from /boot/System.map-2.4.10-ac10a.
Oct  9 19:45:51 rushmore kernel: Symbols match kernel version 2.4.10.
Oct  9 19:45:51 rushmore kernel: Loaded 131 symbols from 11 modules.
Oct  9 19:45:51 rushmore kernel: VFS: brelse: Trying to free free buffer

# note 19:45:51 error was from a previous run of mmap01

root@rushmore:/usr/src/sources/l/ltp# umount /tmp

root@rushmore:/usr/src/sources/l/ltp# df -T /tmp
Filesystem    Type   1k-blocks      Used Available Use% Mounted on
/dev/hda12
          reiserfs     4056252    945108   3111144  24% /

root@rushmore:/usr/src/sources/l/ltp# mmap01 ; mmap01 ; mmap01
mmap01      1  PASS  :  Functionality of mmap() successful
mmap01      1  PASS  :  Functionality of mmap() successful
mmap01      1  PASS  :  Functionality of mmap() successful

root@rushmore:/usr/src/sources/l/ltp# tail /var/log/messages
Oct  9 19:24:43 rushmore kernel: VFS: brelse: Trying to free free buffer
Oct  9 19:26:19 rushmore exiting on signal 15
Oct  9 19:45:51 rushmore syslogd 1.4.1: restart.
Oct  9 19:45:51 rushmore kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  9 19:45:51 rushmore kernel: Inspecting /boot/System.map-2.4.10-ac10a
Oct  9 19:45:51 rushmore kernel: Loaded 13702 symbols from /boot/System.map-2.4.10-ac10a.
Oct  9 19:45:51 rushmore kernel: Symbols match kernel version 2.4.10.
Oct  9 19:45:51 rushmore kernel: Loaded 131 symbols from 11 modules.
Oct  9 19:45:51 rushmore kernel: VFS: brelse: Trying to free free buffer
Oct  9 19:50:24 rushmore last message repeated 3 times

root@rushmore:/usr/src/sources/l/ltp# date
Tue Oct  9 19:50:35 EDT 2001


-- 
Randy Hron

