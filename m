Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWBPBfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWBPBfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWBPBfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:35:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48046 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751214AbWBPBfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:35:14 -0500
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1140027592.2733.38.camel@mindpipe>
References: <43EF8388.10202@ruault.com>
	 <20060214114102.GC20975@vanheusden.com>
	 <1139934749.11659.97.camel@mindpipe>
	 <20060215150710.GN30182@vanheusden.com> <1140027592.2733.38.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Feb 2006 01:38:27 +0000
Message-Id: <1140053907.14831.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 13:19 -0500, Lee Revell wrote:
> AFAICT in PIO mode if a huge IO request is submitted and/or the device
> is slow to respond there's nothing to prevent us spending a long time in
> the IDE driver.

IDE is basically bits of ISA bus decode stuffed down a cable and then
sped up/fancified later. In PIO0 each cycle is pretty slow and we may
issue quite a few in one transfer. If IORDY is enabled as is normally
the case the drive also has the power to tell us to shut up and can do
so for as long as it likes.

> IIRC this can't be made preemptible due to data corruption issues on
> some hardware.  Maybe we should touch the watchdog in there.

Some chips disable IRQs here and need to so that the stream of data
doesn't stall and stuff fall apart. Touching the watchdog would be
sensible.

Possibly the same is needed in the new libata pata bits too

