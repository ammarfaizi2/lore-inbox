Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWGRV3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGRV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWGRV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:29:24 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:53989 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932096AbWGRV3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:29:24 -0400
Message-ID: <44BD51F5.7020305@s5r6.in-berlin.de>
Date: Tue, 18 Jul 2006 23:26:13 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: snapshot of physical memory
References: <17d79880607180916h6c6d63ddo2f5a6d090fa53c7f@mail.gmail.com> <200607181919.k6IJJYfm032474@turing-police.cc.vt.edu>
In-Reply-To: <200607181919.k6IJJYfm032474@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 18 Jul 2006 12:16:16 EDT, Allison said:
> 
>> 2. How do I make sure that no updates take place in memory from the
>> time I initiate the snapshot till it is done.
> 
> Hint: If you're running a program to dump memory, it's going to be calling
> I/O drivers and so on - and all this activity has to modify at least *some*
> memory (unless you're on an architecture with a *really* deep register stack ;)
> You can't ensure that *no* updates take place.  At best, you can minimize
> the number of pages touched.
> 
> For an example of the kind of hoops you need to jump through, I suggest a
> careful reading of the 'suspend' and/or 'suspend2' source code - a large part
> of that code is basically taking a snapshot of memory.

This can be avoided by dumping the memory remotely via FireWire. All one
needs is PCI and a FireWire card in both machines, the ohci1394 driver
with default parameters loaded on the machine where you want to get the
memory dump from, and a tool like "firescope" on the remote machine.
http://www.linux1394.org/links.php

Software on the remote node B is able to fetch data from the node A
without _any_ software assistence on node A once A's FireWire controller
was initialized in the default mode. (BTW, because of the security
implications of this hardware feature, do not attach untrusted devices
to your PC's FireWire port or do not load ohci1394 or load ohci1394 only
with the parameter phys_dma=0.)

> Also, you'll need to make sure that whatever software is running that
> you're trying to snapshot is fairly tolerant of pauses - if you have a
> disk that manages 20MBytes/second and you have 256M of memory, you're going
> to be sitting there for 10 seconds. This can come as a surprise to programs
> that were sleeping on a timer interrupt.. :)

Of course the need to stop the program whose memory you want to debug
during the whole time required for the dump remains with the FireWire
method too. It can be alleviated if you only dump a small known range of
physical addresses.

You can get about 25 MB/s out of FireWire 400 if both machines run Linux
(about 35 MB/s if you add a Windows, Mac OS, or OS X box as second or
third box or use a tool like 1394commander to emulate a certain feature
which is missing in Linux' FireWire drivers) but more if you have
FireWire 800.
-- 
Stefan Richter
-=====-=-==- -=== -====
http://arcgraph.de/sr/
