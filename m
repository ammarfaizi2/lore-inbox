Return-Path: <linux-kernel-owner+w=401wt.eu-S1759301AbWLICi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759301AbWLICi5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 21:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760254AbWLICi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 21:38:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45825 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759301AbWLICi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 21:38:56 -0500
Date: Sat, 9 Dec 2006 02:46:27 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI legacy resource fix
Message-ID: <20061209024627.6bb11a58@localhost.localdomain>
In-Reply-To: <1165630410.7443.346.camel@gullible>
References: <20061206134143.GA6772@linux-mips.org>
	<1165625178.7443.334.camel@gullible>
	<20061209012552.GA15216@linux-mips.org>
	<1165630410.7443.346.camel@gullible>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Checking the patch, my problem is that the old way, all BAR's were being
> set at start = end = flags = 0. The patch makes it set all the BAR's to

Yes the old quirk used to blank the resources as the values on the chip
are undefined and random. This gives you corrupt resource trees and needs
hacks in the drivers as well

> the normal values. This is what it looks like in lspci, pre this patch:
> 
>         Region 0: I/O ports at <unassigned>
>         Region 1: I/O ports at <unassigned>
>         Region 2: I/O ports at <unassigned>
>         Region 3: I/O ports at <unassigned>

Then your device is in legacy mode, or was disabled
 
> So my device is not running in compatibility mode, and should not have

The paste you have their shows that it almost certainly is in legacy mode.

> the BAR's set, as Alan's patch does.

Dump the class code and other bits during boot check how your device is
seen (native v legacy/compatibility) and whether the fixup logic
triggers. It should only trigger for legacy devices.

Alan
