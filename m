Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSKBQJD>; Sat, 2 Nov 2002 11:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSKBQJD>; Sat, 2 Nov 2002 11:09:03 -0500
Received: from khms.westfalen.de ([62.153.201.243]:22233 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S261287AbSKBQJC>; Sat, 2 Nov 2002 11:09:02 -0500
Date: 02 Nov 2002 15:02:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8$44uP-Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0211011205330.26575-100000@nakedeye.aparity.com>
Subject: Re: [lkcd-devel] Re: What's left over.
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com> <Pine.LNX.4.44.0211011205330.26575-100000@nakedeye.aparity.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yakker@aparity.com (Matt D. Robinson)  wrote on 01.11.02 in <Pine.LNX.4.44.0211011205330.26575-100000@nakedeye.aparity.com>:

> On Fri, 1 Nov 2002, Linus Torvalds wrote:

> |>And if you get these things wrong, you're quite likely to stomp on your
> |>disk. Hard. You may be tryign to write the swap partition, but if the
> |>driver gets confused, you just overwrote all your important data. At which
> |>point it doesn't matter if your filesystem is journaling or not, since you
> |>just potentially overwrote it.
>
> We haven't seen this before, but it is always a possibility for any
> dump scenario.  That's why you some choose netdump instead. :)

*If* you want safe dumping to a partition, it seems wrong to me to try to  
figure that out after the crash.

Instead,

* configure the crash space with a user-mode app or possibly a kernel  
command line arg
* Whenever repartitioning, check if the crash dump partition is affected,  
and if so, clear it until it is explicitely reconfigured
* Save a good checksum (say, md5 or sha1) of the crash partition config,  
and only dump if that checksum checks out

You might want to checksum even more than that, of course :-)

But there's certainly a reason Netware liked to crash dump to a series of  
floppies - too bad those are much too small for today's machines. When  
floppy sizes stopped to be slightly larger than standard RAM sizes[*], the  
computing public lost big time, and we haven't recovered from that.

[*] Apple ][+: 48 KB RAM, 140 KB floppy. IBM PC: 640 KB RAM, 1.2 MB  
floppy. (Yes, I know there were other combinations as well.) Where's my  
approximately-1-GB floppy that everyone and their aunt have installed  
today? No, CD writers are *not* universal. And burn-once CDs aren't much  
like floppies.

Of course, the same problem exists with general backup technology - tape  
the size of modern disks is not really affordable anymore.

MfG Kai
