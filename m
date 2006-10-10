Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWJJUtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWJJUtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWJJUtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:49:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36005 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030341AbWJJUtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:49:49 -0400
Date: Tue, 10 Oct 2006 15:49:47 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
       James K Lewis <jklewis@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/21]: powerpc/cell spidernet bugfixes, etc.
Message-ID: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, please apply/forward upstream.

The following set of 21 patches (!) are all aimed at the the 
spidernet ethernet device driver. The spidernet is an etherenet
controller built into the Toshiba southbridge for the PowerPC Cell
processor. (This is the only device in existance that with this
ethernet hardware in it).

These patches re-package/re-order/re-cleanup a previous
set of patches I've previously mailed. Thus, some have
been previously Acked-by lines, most do not. Most of
these patches are tiny, and handle problems that cropped
up during testing. Sorry about there being so many of them.

The first set of 12 patches fix a large variety of mostly 
minor bugs. 

The important patches are 13 through 17: these overcome a 
debilitating performance problem on transmit (6 megabits
per second !!) on transmit of patches 500 bytes or larger.
After applying these, I am able to get the following:

pkt sz   speed (100K buffs)       speed (4M buffs)
------   -----------------        ----------------
1500     700 Mbits/sec            951 Mbits/sec
1000     658 Mbits/sec            770
800      600                      648
500      500                      500
300      372                      372
60        70                       70

Above buf size refers to /proc/sys/net/core/wmem_default

----

I'm not planning on any further patches for a long while.
I tried to do som RX work, but gave up. RX performance could 
be improved.

FYI, Christoph Hellwig's node-aware patches seem to make no
difference at all any more.

I tried to base these on linux-2.6.19-rc1-mm1 but hit a 
kernel BUG in copy_fdtable at fs/file.c:138! 
(reported earlire today by Olof)

--linas
