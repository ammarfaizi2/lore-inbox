Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbTCROPT>; Tue, 18 Mar 2003 09:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262417AbTCROPT>; Tue, 18 Mar 2003 09:15:19 -0500
Received: from bestroot.de ([217.160.170.131]:35039 "EHLO
	p15112267.pureserver.de") by vger.kernel.org with ESMTP
	id <S262404AbTCROPS>; Tue, 18 Mar 2003 09:15:18 -0500
Message-ID: <3E772DA1.5080504@elitedvb.net>
Date: Tue, 18 Mar 2003 15:30:57 +0100
From: Felix Domke <tmbinc@elitedvb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE 48 bit addressing causes data corruption
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm having linuxppc-embedded based system (2.4.21-pre, but 2.4.20 shows 
same results) with a normal ATAPI-5-styled IDE controller.

When using a 200GB Maxtor HDD, there are strange effects. When writing 
just the sector number to every sector (or every 100MB is enough), and 
reading back, data from incorrect sectors is read. The upper 24bit of 
the LBA seem to be invalid, shows like the upper 24bit aren't updated in 
the 2 cycle LBA-write in the ide-disk.c. For example, reading from 
0x946000000 (LBA 0x4A30000) will read from 0x2f46000000 (LBA 0x17A30000).
note that i lineary fill the disk, and 0x17xxxxxx is the highest 
possible LBA, so the last upper bit from the write won't be actualized 
any more when reading back from lower addresses.

However, reading them back (using the HOB-bit) will work and give 
correct results. I don't really know whats going wrong, except that 
there are addressing-faults.

Is this a known bug of the Maxtor 6Y200L maybe? the 160GB version showed 
the same effect.

Is it possible that the IDE-Controller causes the fault? normal 28bit 
HDDs work just fine.


Can somebody please confirm again that i don't need an atapi-6 (ATA133) 
controller to use LBA48 ?

Regulary some people are stating this, and regulary some people tell 
that these people are wrong.


felix


