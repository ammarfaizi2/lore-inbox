Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUKOHxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUKOHxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 02:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUKOHxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 02:53:40 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:32411 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261503AbUKOHxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 02:53:37 -0500
Date: Mon, 15 Nov 2004 07:52:50 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Thomas Spatzier <thomas.spatzier@de.ibm.com>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [patch 4/10] s390: network driver.
In-Reply-To: <4196B4E9.40502@pobox.com>
Message-ID: <Pine.LNX.4.61.0411150735070.10262@hibernia.jakma.org>
References: <OF88EC0E9F.DE8FC278-ONC1256F4A.0038D5C0-C1256F4A.00398E11@de.ibm.com>
 <4196B4E9.40502@pobox.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004, Jeff Garzik wrote:

> Queues are DESIGNED to fill up under various conditions.

What happens when they are full? Blocking isnt good, at least not 
from GNU Zebra / Quagga's POV.

> Would not the zebra routing software have the same problems with 
> cable pull under an e1000 or tg3 gigabit NIC?

If they block further writes, yes.

> The most popular drivers -- e1000, tg3, etc. -- do not do this, for 
> very good reasons.

The problem is that GNU Zebra / Quagga uses a single raw socket for 
certain protocols, eg OSPF. Blocking the socket because one NIC has a 
cable pulled is undesireable, and there's no point queueing the 
packets, by the time the link comes back, if ever, its highly 
unlikely there is any use in sending the packets (sending OSPF 
hello's from X minutes ago on a link that just came back is useless).

The kernel really shouldnt get too much in the way of an application 
that already is fully aware of reliability issues[1] - at least that 
is the application's expectation in this case.

We could change it to use a socket/interface on Linux, but it seems a 
bit unnecessary to me, at least for raw socket/included-header 
sockets.

> 	Jeff

1. an application must be if its uses raw sockets surely? Even for 
non-raw/header-included sockets, eg BGP tcp sockets, a user like GNU 
Zebra / Quagga would much prefer packets to be dropped.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
My interest is in the future because I am going to spend the rest of my
life there.
