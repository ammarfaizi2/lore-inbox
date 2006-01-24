Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWAXGnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWAXGnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWAXGnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:43:22 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39154 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964992AbWAXGnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:43:21 -0500
Message-ID: <43D5CC88.9080207@comcast.net>
Date: Tue, 24 Jan 2006 01:43:20 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: 2.6.16-rc1-mm2 pata driver confusion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an nforce4 based motherboard.  Currently i'm using the amd/nvidia 
driver under the normal ide,ata driver section (2.6.14). 

It appears that the new ata code is hiding under scsi/sata drivers, 
including apparently pata code.  This alone reads confusing, pata 
drivers under the sata driver section, but that's not really the 
problem.  The problem is that there appears to be two nvidia/amd ata 
drivers and I'm unsure which I should try using, if i compile both in, 
which get loaded first (i assume scsi is second to ide) and if i want my 
pata disks loaded under the new libata drivers, will my cdrom work under 
them too, or do i still need some sort of regular ide drivers loaded 
just for cdrom (to use native ata mode for recording access).  

I couldn't find anything to explain how to deal with the new libata when 
it apparently overlaps functionality with the old ata/ide code in the 
Documentation directory, nor is it apparent if atapi is supported under 
the new libata code, or if either should be loaded first or not for best 
performance (if it matters). Or if they can both be loaded at the same 
time at all.


I have booted numerous configurations and have found the following to be 
true.

1.  Atapi is most definitely not supported by libata, right now.
2. whether libata sets the controller up better or not, ide cdroms MUST 
be loaded before libata is or the ide controller will be detected as 
"already in use" and the cdrom drivers wont have any device to attach 
to, since unlike scsi drivers, ide drivers dont probe the hardware on 
controllers to see if any driver has claimed them.
3. For hdd's alone, the pata libata + sata drivers are a "complete" 
replacement for the ide drivers and thus, if you dont have atapi 
devices, you dont need to compile in ide support.
4.  moving to pata libata drivers _will_ change the enumeration of your 
sata devices, it seems that pata is initialized first, so when setting 
up your fstab entries and grub, you'll have to take into account how 
many pata devices you have and offset your current sata device names by 
that amount.

