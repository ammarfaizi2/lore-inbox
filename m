Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132279AbQLVV5S>; Fri, 22 Dec 2000 16:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbQLVV5H>; Fri, 22 Dec 2000 16:57:07 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:26350 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S132008AbQLVV4z>; Fri, 22 Dec 2000 16:56:55 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012222126.eBMLQNY19430@webber.adilger.net>
Subject: Re: Fw: max number of ide controllers?
In-Reply-To: <00d901c06c57$5ece3220$2b6e60cf@pcscs.com> "from Charles Wilkins
 at Dec 22, 2000 03:40:07 pm"
To: Charles Wilkins <chas@pcscs.com>
Date: Fri, 22 Dec 2000 14:26:23 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Raid mailing list <linux-raid@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Wilkins writes:
> I have ide.2.2.18.1209.patch applied. The kernel is 2.2.18.
> So what is the answer? 4 controllers max or 10 for my kernel?

10 controllers if you have the IDE patches applied.  4 otherwise.

> I have done this. There are no conflicts.
> SB32 uses 0x168-0x16f,0x36e,10 and nothing else does.

> What would be the correct kernel command to manually set up the SB32 as ide
> 4 for the above resources?

in your lilo.conf, add a line:
append="ide4=0x168,0x36e,10"

See /usr/src/linux/Documentation/ide.txt for more info.  You may need to
specify the I/O ports for ide2 and ide3 in this case, as the above I/O
ports are for ide3.

> I have the following hd devices in /dev.

> hda 3,0
> hdb 3,64
> hdc 22,0
> hdd 22,64
> hde 33,0
> hdf 33,64
> hdg 34,0
> hdh 34,64

> How do I go about making devices for hdi, hdj, hdk, hdl, hdm, hdn, etc ?

> i.e. which major and minor numbers do I use?

If you have a reasonably recent /dev/MAKEDEV installed, you should be able
to just do "cd /dev; ./MAKEDEV hdi hdj hdk hdl", but failing that,

hdi = 56,0
hdj = 56,64
hdk = 57,0
hdl = 57,64

You can always check /usr/src/linux/Documentation/devices.txt for more.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
