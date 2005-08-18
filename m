Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVHRFEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHRFEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVHRFEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:04:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:5328 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750704AbVHRFE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:04:29 -0400
Subject: Re: pmac_nvram problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124277416.6336.11.camel@localhost>
References: <1124277416.6336.11.camel@localhost>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 15:00:12 +1000
Message-Id: <1124341212.8848.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure why alloc_bootmem is used at all (is the nvram larger than
> a couple of pages on any machine? And if it is, should it really be
> cached in RAM?), but I think it should be sufficient to just use kmalloc
> (well, it works for me).

There used to be cases where we used the nvram stuff before kmalloc()
was available. I'll check if this is still the case.
 
> Secondly, this driver misses power management. Having suspended, I
> booted OSX which always resets the boot volume. But after resuming
> linux, nvsetvol(8) still reports 0 as the boot volume because the
> pmac_nvram driver caches the nvram contents. Fixing this would require
> converting the driver to the new model though, I think.

Well... the driver doesn't expect you to boot a different OS while
suspended to disk :)

Regarding caching the data in memory, this is done becaues nvram is
actually a flash on recent machines, and you really want to limit the
number of write cycles to it.

Ben.


