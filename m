Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAFFBE>; Sat, 6 Jan 2001 00:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAFFAz>; Sat, 6 Jan 2001 00:00:55 -0500
Received: from adsl-151-196-235-211.baltmd.adsl.bellatlantic.net ([151.196.235.211]:25657
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S129771AbRAFFAn>; Sat, 6 Jan 2001 00:00:43 -0500
Date: Sat, 6 Jan 2001 00:01:43 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] tulip driver
Message-ID: <Pine.LNX.4.10.10101052344200.760-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter De Schrijver (p2@mind.be) wrote:

> Attached you will find a patch to the tulip driver in Linux 2.4. This patch 
> will interpret a bit more of 21142 extended format type 3 info blocks in a 
> tulip SROM. This allows correct autonegotation of the builtin 21143 based 
> ethernet adapter on a digital PWS500a(u).

This patch isn't quite correct.

The to-advertise value in the type 3 media info block must be written
to the transceiver after each transceiver reset.  The write is done in
select_media(), not when initially reading EEPROM.

One part of the problem is that to work correctly the driver must keep the
to-advertise values separately for the SYM/serial transceiver and each MII
transceiver.

> Maybe a future version should do 
> a more thorough interpretation of the SROM. 

The tulip driver in 2.4 uses older media selection code.  See the
tulip.c driver at
   http://www.scyld.com/network/tulip.html
for a driver with the many updates needed to support recent chips and
boards.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
