Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVCIKxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVCIKxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCIKug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:50:36 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:60079 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261593AbVCIKtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:49:46 -0500
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: serial console messup during boot
Date: Wed, 9 Mar 2005 10:49:43 +0000 (UTC)
Organization: Wurtelization
Message-ID: <d0mkc6$klk$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1110365383 21172 83.68.3.130 (9 Mar 2005 10:49:43 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6 kernels we've noticed that there's a period during booting that
the serial console output is messed up. Most probable cause is a wrong
baud rate.

This is on Dell rackmount servers, with the serial console running at
115200 baud. The BIOS works fine, GRUB works fine, the first part of the
kernel bootup shows up fine, and then:

  Real Time Clock Driver v1.12  
  i8042: ACPI detection disabled
  serio: i8042 AUX port at 0x60,0x64 irq 12
  serio: i8042 KBD port at 0x60,0x64 irq 1 
  Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxINIT: version 2.85 booting
  Activating swap.
  Adding 1052152k swap on /dev/md3.  Priority:1 extents:1
  Checking root file system...                           
  fsck 1.35 (28-Feb-2004)
  Reiserfs super block in block 16 on 0x900 of format 3.6 with standard journal
  Blocks (total/free): 264960/247705 by 4096 bytes
  Filesystem marked as cleanly umounted
  Filesystem seems mounted read-only. Skipping journal replay.
  Checking internal tree..finished                  

The xxxx characters were garbage characters that I didn't want to paste
into an otherwise ASCII message...
As soon as the serial driver is loaded, the baud rate (I guess) is
messed up until the time init is loaded (which probably resets the
serial console settings).

I've tried e.g. setting the default baudrate in the serial driver to 115200
to no avail, so I'm hoping someone here will be able to help. On at
least one occasion booting went wrong in the time that the output is
messed up, so we had to carry a CRT into the server room to watch the
VGA, so we'd be most grateful if this little problem could be fixed :-)

With 2.4 kernel this corruption of the output does not occur.


Thanks,
Paul Slootman

