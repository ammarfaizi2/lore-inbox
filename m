Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTJAPRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTJAPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:17:10 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:23712 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262458AbTJAPRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:17:03 -0400
Date: Wed, 1 Oct 2003 11:16:34 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Frank Horowitz <frank.horowitz@csiro.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: i7505 locks up too (Was: iTyan i7501 Pro (S2721-533) lock-up
 (e1000?))
In-Reply-To: <1064991240.2271.70.camel@bonzo.ned.dem.csiro.au>
Message-ID: <Pine.GSO.4.33.0310011106120.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Frank Horowitz wrote:
>I'm seeing a similar problem with a (bunch of) Supermicro i7505 boards
>(X5DAL-G's if it matters). All with e1000 onboard (but running at
>100Mbps full-duplex through Cisco 2900-series and 4000-series switches).
>All locking up under heavy load (openMosix process migrations).
...
>All boxes have had memtest86 run on them with repeated passes and are
>showing fine.

Currently, both machines are working and stable.  I may have tanted the
results by bleeding on them, however.

 11:07:43  up 19:26,  3 users,  load average: 2.10, 1.83, 1.39
40 processes: 38 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  93.9% user   6.0% system   0.0% nice   0.0% iowait   0.0% idle
Mem:  1035060k av,  919232k used,  115828k free,       0k shrd,   39656k buff
        66692k active,              10476k inactive
Swap: 2040244k av,       0k used, 2040244k free                   28820k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 1272 root      25   0  5824 4192  3000 R    98.2  0.4  1141m   0 capture

First, both machines have un-certified "POWMEM" memory modules.  So, that's
my first suspect.  Tyan boards act insane with "bad" memory.  That said,
memtest86 cannot stress memory in the way it needs to be stressed to
actually fail.  The ring buffers from the e1000's (64bit, 133MHz PCI-X)
will stress memory in the extreme.

If you have "spread spectrum" enabled (search all the BIOS screens), turn
it off and see if the machine becomes more stable.  Failing that, find
known good memory (certified for use in the MB by the manufacturer.)  From
there, try reducing the PCI bus speed (if possible -- there's a bios
option on the i7501)

I'm still running with "pci=noacpi" so that might be adding to the soluion.

I wasn't seeing any IDE problems.  In fact, the disk isn't being touched
at all.

--Ricky


