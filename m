Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUENSAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUENSAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUENSAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:00:23 -0400
Received: from h00207813f68b.ne.client2.attbi.com ([24.91.60.206]:48527 "EHLO
	buddha.badbelly.com") by vger.kernel.org with ESMTP id S261989AbUENR6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:58:48 -0400
Date: Fri, 14 May 2004 13:58:41 -0400 (EDT)
From: gboyce@badbelly.com
To: linux-kernel@vger.kernel.org
Subject: Burning CDs with a CD-ROM is a bad idea
Message-ID: <Pine.LNX.4.58.0405141352540.7746@buddha.badbelly.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

Yesterday I made a slight thinko while attempting to burn a CD.  Rather 
than specifying dev=/dev/hdd, I add dev=/dev/hdc, which is my CD-ROM 
drive rather than my cd burner.  Whoops!

Now, I believe I've done this before, and recieved an error message.  
However, in this particular case with 2.6.6, the system behaved a bit 
different.

bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out
hdc: lost interrupt
cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED
sector 0, nr/cnr 0/0
bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
ide-cd: cmd 0x1e timed out

It's been a day, and cdrecord is still trying.  I've tried cancelling or 
killing cdrecord with no avail.  

root     11461  0.0  0.0     0    0 ?        DW   May13   0:00 [cdrecord]

This seems like the wrong behavior to me.  What I'm not sure of though is 
if this is a kernel bug, or some sort of problem with cdrecord.  Thoughts?
