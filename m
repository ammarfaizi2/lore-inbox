Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272358AbRH3Rc5>; Thu, 30 Aug 2001 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272359AbRH3Rcs>; Thu, 30 Aug 2001 13:32:48 -0400
Received: from [209.218.224.101] ([209.218.224.101]:19080 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S272357AbRH3Rcg>; Thu, 30 Aug 2001 13:32:36 -0400
Message-ID: <05c501c13178$43e19ba0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
Date: Thu, 30 Aug 2001 10:21:54 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a very strange problem yesterday... my server here, which is a
700 MHz Celeron, 256MiB RAM, four ~40G disks has two RAID-5 arrays (using
the standard kernel MD driver) configured across those four drives. For some
reason definitely related to operator error, the machine crashed and needed
to resync the arrays after being rebooted.

Eveything was working fine, interactive response was just fine even though
the drives were just cranking away doing their resync. I then brought up my
PPP Internet connection, which came up just fine. However, I was _not_ able
to actually communicate with any 'Net hosts. Watching the modem lights, it
appeared that my packets were going out, and responses were coming back, but
the responses never made it up to the userspace applications.

I even dropped and reestablished the PPP connection twice, thinking I got a
bad connection to the ISP, but there was no improvement. When the RAID-5
resync was complete, suddenly things began working just fine. While the
resync was happening, top showed "raid5syncd" with PRI 19 and NI 19 using
about 25-30% CPU, and "raid5" with PRI -1 and NI -20 using about 60-65% CPU.

I can probably reproduce this pretty easily, if anyone is interested and can
give me some idea where to look for the cause...

