Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVD3MEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVD3MEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVD3MEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:04:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:7390 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261202AbVD3MEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:04:12 -0400
To: =?iso-8859-1?Q?Paul_Mackerras?= <paulus@samba.org>
Subject: =?iso-8859-1?Q?Re:_Re:_[PATCH_3/4]_ppc64:_Add_driver_for_BPA_iommu?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>,
       =?iso-8859-1?Q?Benjamin_Herrenschmidt?= <benh@kernel.crashing.org>,
       =?iso-8859-1?Q?linuxppc64-dev?= <linuxppc64-dev@ozlabs.org>,
       =?iso-8859-1?Q?Linux_Kernel_list?= <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Anton_Blanchard?= <anton@samba.org>
Message-Id: <26879984$111486195242737180269552.40594107@config8.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Sat, 30 Apr 2005 14:02:02 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.135
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Mackerras <paulus@samba.org> schrieb am 29.04.2005, 15:06:54:
> Arnd Bergmann writes:
> 
> > Implementation of software load support for the BE iommu. This is very
> 
> Could you expand a bit on what "software load support" is?  Your
> description is a bit terse.

The Cell processor can put the I/O page table either in memory like
the hashed page table (hardware load) or have the operating system
write the entries into memory mapped CPU registers (software load).

I use the software load mechanism because I know that all I/O page
table entries for the amount of installed physical memory fit into
the IO TLB cache. At the point when we get machines with more than
4GB of installed memory, we can either use hardware I/O page table
access like the other platforms do or dynamically update the I/O
TLB entries when a page fault occurs in the I/O subsystem.

The software load can then use the macros that I have implemented
for the static mapping in order to do the TLB cache updates.

I'll make sure to add the description to the patches when I send them
next time.

       Arnd <><
