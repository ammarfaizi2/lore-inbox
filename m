Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWEUTTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWEUTTi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWEUTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:19:38 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:20124 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S964914AbWEUTTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:19:37 -0400
Date: Sun, 21 May 2006 12:19:33 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Greg KH <gregkh@suse.de>, Brice Goglin <brice@myri.com>,
       Roland Dreier <rdreier@cisco.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
In-Reply-To: <fa.7RUPmW8q906KfAmuRItEvwbAUvg@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0605211216510.7870@osa.unixfolk.com>
References: <fa.WOQy7TVxeMkzxI+BbQP2Wqi34A0@ifi.uio.no>
 <fa.7RUPmW8q906KfAmuRItEvwbAUvg@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2006, Michael S. Tsirkin wrote:
| > Michael is the one who added that change, perhaps he can explain how he
| > tested it?
| 
| Well, I just re-tested with 2.6.17-rc4 and it does not seem to work.  No idea
| what did I do wrong when testing this patch before posting it :(. Oops.
| I'm sorry.
| 
| Given that its late in -rc series, that its a clear regression from 2.6.16, that
| disabling MSI is always safe, and that the patch was intended to enable MSI on

Disabling MSI is not always safe.   The InfiniPath PCIe adapter has no
other way to interrupt, for example.

The original patch (which you are proposing reverting to, or so it
appears to me), causes our chip to not work at all on any motherboard
which has both 8131 and PCIe slots (and there are at least 2 or 3 of
those, including supermicro and HP), despite the fact that the 8131
problem is irrelevant to PCIe on Nvidia or other root complexes.

We (PathScale/QLogic) are having to tell people to patch their
kernels in order for the InfiniPath PCIe adapter to work, on such systems.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
