Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRFBJXI>; Sat, 2 Jun 2001 05:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbRFBJW6>; Sat, 2 Jun 2001 05:22:58 -0400
Received: from fungus.teststation.com ([212.32.186.211]:40342 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S262355AbRFBJWw>; Sat, 2 Jun 2001 05:22:52 -0400
Date: Sat, 2 Jun 2001 11:21:59 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Frank Eichentopf <frei@hap-bb.de>
cc: <linux-kernel@vger.kernel.org>,
        "Rose, Daniel" <daniel.rose@datalinesoutions.com>,
        Yiping Chen <YipingChen@via.com.tw>,
        Felix Maibaum <f.maibaum@tu-bs.de>,
        Jonathan Morton <chromi@cyberspace.org>,
        David Vrabel <dv207@hermes.cam.ac.uk>,
        Donald Becker <becker@scyld.com>
Subject: [patch][CFT] Re: via-rhine DFE-530TX rev A1
In-Reply-To: <01053111335702.04024@server>
Message-ID: <Pine.LNX.4.30.0106021027190.23124-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0106021032341.23124@cola.teststation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Are you sure. What's the version of your driver. Please tell me. It's
> >important.
> >I remember we have fixed it already. 
> 
> The driver version (dlkfet.sys) is 2.52 from 08/06/2000. this is the lastest
> driver from the original dlink site.

Perhaps Yiping Chen was talking about a D-Link linux driver?
David Vrabel has found a D-Link driver ("1.11") based on Donald Beckers
that fixes the "00:00:00:00:00 after rebooting from win98" problem.

Here is a patch vs 2.4.5-ac4 that may fix this (if I didn't break it).

http://www.hojdpunkten.ac.se/054/via-rhine-2.4.5-ac4-dlink-3.patch

Please test and let me know if it works. It should apply vs any 2.4.5*
kernel. I have added those that I know have reported this problem before
to the Cc list.


What the driver does differently at init time is disable wake-on-lan and
power-management-events and then reload the MAC Address from EEPROM.

The reload code is also in the latest test version (1.10) from Donald
Becker at www.scyld.com, and that is the code I have used with slight
modification. I don't know if reloading from EEPROM alone is enough to fix
the 00:00:00:00:00 bug.

There is also a minor thing with 0x01 being a reserved bit in TxConfig,
that should probably be 0x02 to set it to loopback.


The D-Link driver has some other changes for various things. I have been
unable to find the driver on dlinks site, but I have the copy David sent
me:
http://www.hojdpunkten.ac.se/054/via-rhineb1.zip

/Urban

