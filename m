Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbTDAJXG>; Tue, 1 Apr 2003 04:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTDAJXG>; Tue, 1 Apr 2003 04:23:06 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:25768 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262209AbTDAJXF>; Tue, 1 Apr 2003 04:23:05 -0500
Message-Id: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Peter Oberparleiter <oberpapr@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Partition check order in fs/partition/check.c?
Date: Tue, 1 Apr 2003 11:33:03 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Russell King <rmk@arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a few questions regarding partition checks in fs/partition/*.c of 
both Linux 2.4 and 2.5:

I ran into a situation in which an MSDOS partition table was incorrectly 
interpreted as an ACORN POWERTEC partition table, resulting in no valid 
partition being found. When I looked at fs/partition/acorn.c I noticed that 
the powertec partition check is kept fairly generic (adding bytes 1..511 of 
the MBR plus an offset and comparing the result with byte 512). In addition 
to this, the acorn-specific set of partition checks comes first in the list 
in fs/partition/check.c so that statistically, every one in 256 MSDOS 
partition tables (they got a fixed pattern at bytes 511 and 512) would be 
incorrectly identified as POWERTEC.

Now for the actual questions: what is the reason for the order of partition 
checks as it is? Couldn't the acorn tests be moved further down in the list 
to solve this particular problem? Also, is there a way to make the acorn test 
more specific?

A workaround for this problem would of course be to deselect the 
CONFIG_ACORN_PARTITION_POWERTEC option, but that wouldn't work in cases both 
acorn and msdos partition tables are used.

Thanks in advance for any kind of insight into this matter.


Regards,
  Peter Oberparleiter
