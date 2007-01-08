Return-Path: <linux-kernel-owner+w=401wt.eu-S1751589AbXAHPcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXAHPcM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbXAHPcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:32:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57198 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751588AbXAHPcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:32:11 -0500
Date: Mon, 8 Jan 2007 15:42:49 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
Message-ID: <20070108154249.6d8f5697@localhost.localdomain>
In-Reply-To: <45A24159.7060001@pobox.com>
References: <20070108122659.00c22754@localhost.localdomain>
	<45A24159.7060001@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem you need to fix or work around is ata_probe_ent, which 
> doesn't properly fill in ata_port info for this situation.  Tejun has 
> posted patches that kill ata_probe_ent, which you were pointed to. 

And which are not yet in the main tree leaving many users unable to
install Linux. This isn't the way to get stuff done. When you've got the
new patches in the driver can use them if its worth it (which, see below,
I question).

> If you get the setup right, you don't bloat each hook with "is this port 
> PATA?" tests.  At present, your sata_via patch introduces these needless 
> tests.

Which I might note are actually smaller than the extra structs and on a
code path usually executed twice per boot. So the needless tests are more
efficient and not on a hot path and are shorter than the elegant
not-present solution and let users actually install Linux on current VIA
systems, which right now the generally cannot do.

Out of boredom I'll also note that clock timings say that if the extra
port info stuff causes a single extra L1 cache miss its also faster to do
the tests.

Alan
