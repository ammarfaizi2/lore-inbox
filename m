Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTAUJzW>; Tue, 21 Jan 2003 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTAUJzW>; Tue, 21 Jan 2003 04:55:22 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:26020 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id <S266965AbTAUJzU>;
	Tue, 21 Jan 2003 04:55:20 -0500
Date: Tue, 21 Jan 2003 12:04:25 +0200 (EET)
From: Catalin BOIE <util@ns2.deuroconsult.ro>
X-X-Sender: <util@hosting.rdsbv.ro>
To: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] prio it's not respected in hash tables?
Message-ID: <Pine.LNX.4.33.0301211200210.1894-100000@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Seems that if I add two filters in a hash node, prio doesn't matter
anymore.
It's a known bug?

Long story:

If I do this:
echo "****************** jumptables..."
echo "*** 800: link 1:"
$tc filter add dev $dev parent 1: prio 1 u32 match ip nofrag hashkey mask 0xff000000 at 16 link 1:

echo "*** 1:1 link 2:"
$tc filter add dev $dev parent 1: prio 1 u32 ht 1:1: match ip nofrag hashkey mask 00ff0000 at 16 link 2:

echo "*** 2:2 link 3:"
$tc filter add dev $dev parent 1: prio 1 u32 ht 2:2: match ip nofrag hashkey mask 0000ff00 at 16 link 3:

echo "*** 3:3 link 4:"
$tc filter add dev $dev parent 1: prio 1 u32 ht 3:3: match ip nofrag hashkey mask 000000ff at 16 link 4:

# *************************** important part ******************************
tc filter add dev $dev parent 1: prio 2 u32 \
#                                    ^^^
        ht 4:4: match ip dst 1.2.3.4/32 flowid 1:2
tc filter add dev $dev parent 1: prio 1 u32 \
#                                    ^^^
        ht 4:4: match ip dst 1.2.3.4/32 flowid 1:3


But every ping to 1.2.3.4 goes to flowid 1:2 instead of 1:3 :(.

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro


