Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315053AbSDWELp>; Tue, 23 Apr 2002 00:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315055AbSDWELo>; Tue, 23 Apr 2002 00:11:44 -0400
Received: from gear.torque.net ([204.138.244.1]:35848 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315053AbSDWELo>;
	Tue, 23 Apr 2002 00:11:44 -0400
Message-ID: <3CC4DDFA.4632C43A@torque.net>
Date: Tue, 23 Apr 2002 00:07:22 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.9 IDE subsystem oops on scsi box
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lk 2.5.9 building a kernel with the ide subsystem and
ide-disk built in but no ATA disks oopses around mount
time (of the scsi disk) in the boot sequence.

This worked fine in lk 2.5.8 and lk 2.5.8-dj1 . Going into
the BIOS and disabling the on board IDE chipsets makes the
oops go away:
$ uname -a
Linux frig 2.5.9 #21 Mon Apr 22 20:51:46 EDT 2002 i686 unknown
$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3              8499168   6437568   1629856  80% /
/dev/sda1                31079     16949     12526  58% /boot

Hand decoding the oops gave this stack backtrace:
  __ide_end_request
  ide_end_request
  ide_intr
  handle_IRQ
  do_IRQ
  default_idle

Doug Gilbert
