Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQLKXp1>; Mon, 11 Dec 2000 18:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbQLKXpR>; Mon, 11 Dec 2000 18:45:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17165 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130147AbQLKXpE>; Mon, 11 Dec 2000 18:45:04 -0500
Date: Tue, 12 Dec 2000 00:16:12 +0100
From: Martin Mares <mj@suse.cz>
To: Gérard Roudier <groudier@club-internet.fr>
Cc: "David S. Miller" <davem@redhat.com>, lk@tantalophile.demon.co.uk,
        davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001212001612.A14150@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200012112221.OAA01081@pizda.ninka.net> <Pine.LNX.4.10.10012112250330.2255-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10012112250330.2255-100000@linux.local>; from groudier@club-internet.fr on Mon, Dec 11, 2000 at 11:07:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It is the bar cookies in pci dev structure that are insane, in my opinion.
> 
> If a driver needs BARs values, it needs actual BARs values and not some
> stinking cookies. What a driver can do with BAR cookies other than using
> them as band-aid for dubiously designed kernel interface.

If a driver wants to know the BAR values, it can pick them up in the configuration
space itself. The problem is that these values mean absolutely nothing outside
the bus the device resides on. There exist zillions of translating bridges
and no driver except for the driver for the particular bridge should ever
assume anything about them.

The values in pci_dev->resource[] are not some random cookies, they are
genuine physical addresses as seen by the CPU and as accepted by ioremap().

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"People disagree with me.  I just ignore them." -- Linus Torvalds
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
