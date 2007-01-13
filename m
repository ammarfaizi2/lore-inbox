Return-Path: <linux-kernel-owner+w=401wt.eu-S1422700AbXAMPmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbXAMPmk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 10:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbXAMPmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 10:42:40 -0500
Received: from twin.jikos.cz ([213.151.79.26]:51390 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422700AbXAMPmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 10:42:39 -0500
Date: Sat, 13 Jan 2007 16:41:19 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: linux-kernel@vger.kernel.org
cc: Pavel Machek <pavel@ucw.cz>, Charles Majola <charles@ubuntu.com>,
       Patrick McFarland <diablod3@gmail.com>
Subject: [announce] ipwireless_cs 3G PCMCIA network driver
Message-ID: <Pine.LNX.4.64.0701121633130.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there was some discussion some time ago on lkml about the driver for the 
ipwireless 3G UMTS (in some countries, such as Czech Republic, this is 
shipped under the name "4G UMTS") PCMCIA card [1]

I have taken the old driver written by guys at Symmetric Systems and 
ported it to the current kernel, modified a code layout a bit, removed 
some dead code, etc. I have established a git tree [2] for this driver, as 
it needs considerable amount of work the be acceptable to mainline (not 
only due to functionality problems with V3 (see below), but also 
CodingStyle, migrating the driver to use in-kernel linked lists, etc etc) 
and testing by other people owning the hardware will also help.

There is a little confusion regarding the hardware - there used to be V1 
and V2 cards (which require some little differences in handling). With 
these card types, the driver seems to work well. Then ipwireless company 
produced version V3 of the card. (sadly, IDs of the card didn't change, 
only firmware seems to be modified). This is for example the card that 
T-Mobile is currently shipping by default for the 4G UMTS service (or at 
least in Czech Republic).

This card is correctly detected by this driver, is able to send and 
receive AT commands, dial and connect, but after the ppp connection is 
established, the LCP frames that the card is passing to the driver are 
broken (one byte per frame). We are currently trying, together with 
authors of original driver, to identify an exact cause of this behavior 
(seems like PPP framer on the card is somehow misconfigured or 
unitialized).

Any testers are welcome. Thanks.

[1] http://lkml.org/lkml/2006/6/16/31
[2] git://git.kernel.org/pub/scm/linux/kernel/git/jikos/ipwireless_cs.git, 
    ipw-devel branch

-- 
Jiri Kosina
SUSE Labs
