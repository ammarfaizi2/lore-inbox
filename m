Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129141AbRBIN2K>; Fri, 9 Feb 2001 08:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBIN1u>; Fri, 9 Feb 2001 08:27:50 -0500
Received: from node121b3.a2000.nl ([24.132.33.179]:13440 "EHLO
	node121b3.a2000.nl") by vger.kernel.org with ESMTP
	id <S129141AbRBIN1l>; Fri, 9 Feb 2001 08:27:41 -0500
Message-ID: <3A83F04A.7182E3E1@reviewboard.com>
Date: Fri, 09 Feb 2001 14:27:38 +0100
From: Chris Chabot <chabotc@reviewboard.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tadavis@lbl.gov, linux-kernel@vger.kernel.org
Subject: Bonding driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few bugs still show up in the 2.4.x series with the bonding
(drivers/net/bonding.c / bonding.0) driver. Ive tried all the below
situations in both 2.4.0 and 2.4.1 (both clean/final versions), and on
redhat's default 2.2.16enterprise kernel. the 2.2.16 kernel doesnt have
any of the bugs described below, so it seems they are newly introduced
in the 2.4 series at some point.. The system im testing on is a dual p3
600 (asus p2b-ds mainboard, 440 chipset), 512Mb ecc ram, raid0 4xide
disks, 2x 3com 3c905b network cards connected to a 3com superstack III
switch. The system runs redhat 7.0 with a clean self compiled 2.4.0/1
kernel.

Things that go wrong..

<BUG>
    ifdown bond0
    ifdown eth0
    --> kernel oops, system hard crash

system shutdown does the above as well, so as result i cant normaly shut
down my servers anymore. This is very anoying for my fsck's on the 300Gb
raid0.. and i fear for my data :)

<BUG>
    ping <some-addr>
    ifconfig
    --> packets go over the 2 interfaces
    ifdown bond0
    ifup bond0
    ping <same-addr>
    --> packets go -only- over eth0


<BEHAVIOUR>
    ping -f <some-addr>
    ifconfig
    --> bond0 shows 0 rx packets, while eth0/1 do show rx's being
distributed over the 2 interfaces.


If there's more information i can provide, dont hesitate to ask. Pls cc
me in replies since im not subscribed to linux-kernel.

    -- Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
