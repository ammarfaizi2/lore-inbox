Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130257AbRBZOef>; Mon, 26 Feb 2001 09:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130412AbRBZOcd>; Mon, 26 Feb 2001 09:32:33 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130260AbRBZO3i>;
	Mon, 26 Feb 2001 09:29:38 -0500
Message-ID: <3A9A30C7.3C62E34@colorfullife.com>
Date: Mon, 26 Feb 2001 11:32:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: pat@isis.co.za, linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        Alan@redhat.com
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found the bug:

Someone (Jeff?) removed the line

	tp->advertising[phy_idx++] = reg4;

from tulip/tulip_core.c

pnic_check_duplex uses that variable :-(

There are 2 workarounds:

* change pnic_check_duplex:
s/tp->advertising[0]/tp->mii_advertise/g

* remove the new mii_advertise variable and replace it with
'tp->advertising[i]'.

Jeff, is it really a good idea to have one global mii_advertise
variable? If someone builds a card with multiple transceivers, then
they'll probably support different medias.

--
	Manfred
