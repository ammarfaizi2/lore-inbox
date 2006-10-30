Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965504AbWJ3KsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965504AbWJ3KsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965509AbWJ3KsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:48:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61841 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965504AbWJ3KsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:48:09 -0500
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061030104435.623fd057@gondolin.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
	 <20061027012058.GH5591@parisc-linux.org>
	 <20061026182838.ac2c7e20.akpm@osdl.org>
	 <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz>
	 <20061027113908.4a82c28a.akpm@osdl.org>
	 <20061027114144.f8a5addc.akpm@osdl.org>
	 <20061027114237.d577c153.akpm@osdl.org>
	 <1161989970.16839.45.camel@localhost.localdomain>
	 <20061027160626.8ac4a910.akpm@osdl.org>
	 <20061030104435.623fd057@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Oct 2006 10:48:51 +0000
Message-Id: <1162205331.11965.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-30 am 10:44 +0100, ysgrifennodd Cornelia Huck:
> Would it be sufficient just to make the busses wait until all their
> devices are through with their setup? This is what the ccw bus on s390
> does:

For ATA and IDE no, it might work with SCSI but your devices would
randomly re-order which is also obnoxious. IDE relies on both link probe
order and also has code that knows boot time processing is single
threaded. 

