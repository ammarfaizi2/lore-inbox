Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTDHQIC (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTDHQIB (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:08:01 -0400
Received: from [195.205.16.117] ([195.205.16.117]:8456 "HELO
	mother.fordon.pl.eu.org") by vger.kernel.org with SMTP
	id S261875AbTDHQH7 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:07:59 -0400
Date: Tue, 8 Apr 2003 18:21:18 +0200
From: "Tomasz Torcz, BG" <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.redhat.com>
Subject: [2.5.67] buffer layer error at fs/buffer.c:127; problems with via686a sensor
Message-ID: <20030408162118.GA10209@irc.pl>
Mail-Followup-To: "Tomasz Torcz, BG" <zdzichu@irc.pl>,
	LKML <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

infos about my system is here: http://fordon.pl.eu.org/~zdzichu/my_setup/
(lspci, output of some files from /proc, dmesg and .config).

I've got some unexplained Call Traces in dmesg:

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0140ee9>] __buffer_error+0x29/0x30
 [<c0140fd6>] __wait_on_buffer+0x6a/0xac
 [<c0117414>] autoremove_wake_function+0x0/0x38
 [<c0117414>] autoremove_wake_function+0x0/0x38
 [<c01be336>] reiserfs_unmap_buffer+0x4a/0x80
 [<c01be3b0>] unmap_buffers+0x44/0x54
 [<c01be5d4>] indirect2direct+0x214/0x260
 [<c01bc0dd>] maybe_indirect_to_direct+0x21d/0x228
 [<c01bc2d2>] reiserfs_cut_from_item+0xca/0x454
 [<c01251cb>] rcu_check_callbacks+0x53/0x54
 [<c01bc9a9>] reiserfs_do_truncate+0x305/0x45c
 [<c01ada76>] reiserfs_truncate_file+0xca/0x1b0
 [<c01aeb5e>] reiserfs_file_release+0x3be/0x3e4
 [<c0140d4c>] __fput+0x30/0xb0
 [<c0140d1b>] fput+0x13/0x14
 [<c013fbb5>] filp_close+0x59/0x64
 [<c0119d18>] put_files_struct+0x58/0xc0
 [<c011a61e>] do_exit+0x14a/0x2f0
 [<c011a7ea>] sys_exit+0xe/0x10
 [<c0108ca3>] syscall_call+0x7/0xb

What is that?

Also, I had problem compiling via686a sensors into the kernel.
First, it complained about missing i2c_detect(); I've
replaced it by i2c_probe(); kernel has built and booted.
Only sysfs directory of sensor is empty :(
It works with 2.4.x lm_sensors (via /proc of course).

$ ls -laR /sys/bus/i2c

/sys/bus/i2c:
total 0
drwxr-xr-x    4 root     root            0 kwi  8 14:21 .
drwxr-xr-x    7 root     root            0 kwi  8 14:21 ..
drwxr-xr-x    2 root     root            0 kwi  8 14:21 devices
drwxr-xr-x    4 root     root            0 kwi  8 14:21 drivers

/sys/bus/i2c/devices:
total 0
drwxr-xr-x    2 root     root            0 kwi  8 14:21 .
drwxr-xr-x    4 root     root            0 kwi  8 14:21 ..

/sys/bus/i2c/drivers:
total 0
drwxr-xr-x    4 root     root            0 kwi  8 14:21 .
drwxr-xr-x    4 root     root            0 kwi  8 14:21 ..
drwxr-xr-x    2 root     root            0 kwi  8 14:21 VIA686A
drwxr-xr-x    2 root     root            0 kwi  8 14:21 i2c-dev dummy dr

/sys/bus/i2c/drivers/VIA686A:
total 0
drwxr-xr-x    2 root     root            0 kwi  8 14:21 .
drwxr-xr-x    4 root     root            0 kwi  8 14:21 ..

/sys/bus/i2c/drivers/i2c-dev dummy dr:
total 0
drwxr-xr-x    2 root     root            0 kwi  8 14:21 .
drwxr-xr-x    4 root     root            0 kwi  8 14:21 ..


Please CC me if replying.
-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated.
