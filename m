Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRHHAE2>; Tue, 7 Aug 2001 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270230AbRHHAES>; Tue, 7 Aug 2001 20:04:18 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:58826 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S270229AbRHHAEF>; Tue, 7 Aug 2001 20:04:05 -0400
Message-ID: <3B708202.105D696B@Bellsouth.net>
Date: Tue, 07 Aug 2001 20:04:18 -0400
From: Josh Wyatt <jdwyatt@Bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.CX>
CC: Mark Atwood <mra@pobox.com>, Andrzej Krzysztofowicz <ankry@pg.gda.pl>,
        Michael McConnell <soruk@eridani.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not have a provision like the following:
1. For a given driver, assign ethX in [ascending|descending] (pick one)
order based on MAC addr.  At least this is a predictable order; it
should never change for a given driver.

2. If it's modular, you could make it even more flexible with options:
alias eth0 eepro100
alias eth1 ne2k-pci
alias eth2 eepro100
options eepro100 "bind_mac_order=eth0,eth2
bind_mac_list=00D0B760C299,00D0B760C3DC"

3. if it's modular and insmod'ed with no options, default to a combo of
the current behavior and #1, above.

Of course, you'd have to rely on the module maintainers to follow the
convention.

Also, I can see a potential dependency manifested in a scenario like
this:
1. add eth0, eth1, eth2 as above
2. un-hot-plug eth0.  now hotplug another interface, not used by the
previous driver
3. eepro100 driver is still bound to eth0
4. should the new device get eth3?  or eth0?  
5. Is this a textbook problem outside of PCMCIA?

Dumb? Klutzy? thoughts?

Thanks,
Josh

