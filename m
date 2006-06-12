Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWFLFHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFLFHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWFLFHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:07:03 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:1459 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751275AbWFLFHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:07:01 -0400
Mime-Version: 1.0
Message-Id: <a06230916c0b15944e59e@[129.98.90.227]>
In-Reply-To: <20060610100003.656CB2DF6276@mail.linbit.com>
References: <20060610100003.656CB2DF6276@mail.linbit.com>
Date: Mon, 12 Jun 2006 01:06:30 -0400
To: drbd-user@linbit.com
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Spontaneous access to the CDROM on two computers simultaneously
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spontaneously and for no apparent reason, two computers displayed the 
following message in their logs several times at the same time:

[55419.446442] Buffer I/O error on device hda, logical block 0
[55419.447381] hda: command error: status=0x51 { DriveReady 
SeekComplete Error }
[55419.447386] hda: command error: error=0x54 { AbortedCommand 
LastFailedSense=0x05 }
[55419.447389] ide: failed opcode was: unknown
[55419.447391] end_request: I/O error, dev hda, sector 0

These two amd64-based computers are running kernel 2.6.16.1 with 
drbd-0.7.19. (drbd is a network RAID module; it sends data from one 
computer to the other continuously, but to its own /dev/drbdx 
devices.)

hda is the CDROM drive, so it appears that both computers all on 
their own volition attempted to access their CDROM drive for no 
reason at and the same time, nonetheless. Since neither of them has a 
CDROM in the drive at the time, I think this error makes sense if 
something internally caused a real attempt to do that.

One computer is running a variety of file sharing services (netatalk, 
samba, apache, mysql). Both of them are running heartbeat and drbd, 
and those programs should account for the only communication between 
two computers at the time of the messages, so I'm guessing that 
because of that, drbd could at least theoretically triggered this 
somehow.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
