Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280889AbRKCABC>; Fri, 2 Nov 2001 19:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280890AbRKCAAx>; Fri, 2 Nov 2001 19:00:53 -0500
Received: from druid.if.uj.edu.pl ([149.156.64.221]:3342 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S280889AbRKCAAc>; Fri, 2 Nov 2001 19:00:32 -0500
Date: Sat, 3 Nov 2001 01:00:28 +0100 (CET)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
Message-ID: <Pine.LNX.4.33.0111030050520.19178-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there any reason why the floppy module requires the ioport range
0x3f0-0x3f1 in order to load?  On my computer /proc/ioports reports this
range as used by PnPBIOS PNP0c02, thus the floppy module cannot reserve
the range 0x3f0-0x3f5 and refuses to load.

I have taken a quick look at the port specification of the FDC and have
found no readon for any access to the 0x3f0 port, I have found a reason
for accessing the 0x3f1 port - but only on PS/2's.  This ain't a PS/2 so
that is irrelevant.  Furthermore analysis of the code fails to find any
place where these two ports would actually be used...

Deciding to take a try at it I changed the floppy module to reserve only
the 0x3f2-0x3f5 and 0x3f7 ports, recompiled and the module now loads.
I have not done any tests on it, however copying a diskette via mcopy,
mdir and plain old mount worked fine.

All in all I would say that at least in my case there is no reason for
floppy to reserve these two ports - I don't know about other machines
(especially PS/2's) - but I cannot see any use of them in the source code
any way.

Questions, Ideas?

Maciej Zenczykowski

