Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUIPQxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUIPQxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268578AbUIPQxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:53:41 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:50360 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268400AbUIPQxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:53:10 -0400
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ptrace access to syscall page of 32 bit process on x86_64 fails
Reply-To: James Cownie <jcownie@etnus.com>
X-Mailer: MH-E 7.4.3; nmh 1.1-RC1; GNU Emacs 21.3.1
Date: Thu, 16 Sep 2004 17:53:08 +0100
From: James Cownie <jcownie@etnus.com>
Message-Id: <20040916165308.C01EE1DA71@amd64.cownie.net>
X-OriginalArrivalTime: 16 Sep 2004 16:53:34.0413 (UTC) FILETIME=[B4263FD0:01C49C0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running Suse 9.1 on an Opteron 242 uniprocessor,

Using gdb (or TotalView) to debug a 32 bit process ptrace calls which
try to access the system call page at 0xffffe000 fail.

When run on a 32 bit x86 ptrace can successfully access the system call
page.

To reproduce simply use gdb on a -m32 program, set a breakpoint, run to
it and then try to "print *(0xffffe000)"

The relevant ptrace call (a PEEKDATA), return with errno 5 (EIO).

Details of the machine :-

Linux amd64 2.6.5-7.108-default #1 Wed Aug 25 13:34:40 UTC 2004 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
jfsutils               1.1.5
xfsprogs               2.6.3
quota-tools            3.11.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        06 01:50 /lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1

Modules Loaded         usbserial parport_pc lp parport nfsd exportfs joydev sg
                       st sr_mod floppy ehci_hcd uhci_hcd evdev
                       snd_seq_oss snd_seq_midi_event snd_seq
                       snd_pcm_oss snd_mixer_oss snd_ioctl32 ipv6
                       freq_table thermal processor fan button battery
                       ac snd_via82xx snd_pcm snd_timer snd_ac97_codec
                       snd_page_alloc gameport snd_mpu401_uart
                       snd_rawmidi snd_seq_device snd soundcore usbcore
                       tg3 binfmt_misc subfs dm_mod reiserfs sym53c8xx
                       sd_mod scsi_mod

-- 
-- Jim
--
James Cownie	<jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com


