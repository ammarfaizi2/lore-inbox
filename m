Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSE2Lpm>; Wed, 29 May 2002 07:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSE2Lpl>; Wed, 29 May 2002 07:45:41 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:61871 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315162AbSE2Lpb>;
	Wed, 29 May 2002 07:45:31 -0400
Date: Wed, 29 May 2002 13:45:20 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [INFO] Wake-On-LAN and VIA Rhine / DFE-530TX
Message-ID: <20020529114520.GA2956@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have added some code for Wake-On-LAN support in via-rhine.c which
basically boils down to handling the WOL cases in
via_rhine_ethtool_ioctl().

There are two pitfalls to consider:

- Depending on the version of the chip, the bit flags are in different
  locations, and not all chips support the same WOL options. We already
  have chip specific code paths, hence no problem.

- The manual I have for the Rhine-based D-Link DFE-530TX claims WOL
  support, and these cards come indeed with a WOL connector. That doesn't
  mean WOL works, though. The DFE-530TX exists in different revisions
  (sticker on the board): wrong revision -> no WOL. The LK Rhine driver
  does not read stickers, so the problem is right there.

With some luck the revisions can be mapped to the pci subsystem id (there
is some evidence indicating that this might be the case). Provided there is
a strict mapping, _if_ WOL ever makes it into via-rhine.c, we had better
match subsystem ids and throw an error message or something if a user tries
to enable WOL with a board that doesn't support it. Otherwise it's easy to
predict a new FAQ.

Roger
