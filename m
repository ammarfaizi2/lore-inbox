Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRAGTHE>; Sun, 7 Jan 2001 14:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbRAGTGo>; Sun, 7 Jan 2001 14:06:44 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:46244 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130063AbRAGTGk>;
	Sun, 7 Jan 2001 14:06:40 -0500
Date: Sun, 7 Jan 2001 14:05:43 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Gleb Natapov <gleb@nbase.co.il>
cc: Ben Greear <greearb@candelatech.com>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup
 (DoesNOT  meet Linus' sumission policy!)
In-Reply-To: <20010107205113.H28257@nbase.co.il>
Message-ID: <Pine.GSO.4.30.0101071354340.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Gleb Natapov wrote:

> And what about bonding device? What major number should they use?

Would that include several ifindeces?
use standards. 802.3ad(?). Didnt Intel release some code on this or
are they still playing the big bad corporation? Normaly standards will
take care of things like MIBs etc.

> Ifindexes not reusable so in your scheme we should have separate minor
> counter for each major interface, what for?

Still each "interface" has its own ifindex, so counters will be
per-interface.
Here's what i mean:

netdevice (major part of ifindex, proto unaware link layer)
	|
	|
	--> protocol level (IPV4, V6 etc)
             | ..........|
             |           |--> interface 2^16
             |
              -->interface 1

The interface could be looked as something on top of a device (struct
ifa) and is distinguishable on the device by its minor number. EG
ifindex 1002 is eth0:2.
I could write a whole lengthy RFC if it is of interest and we could
use that as a starting point for discussion.
Note, i dont think this would affect the core code other than the setup
part.

cheers,
jamal


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
