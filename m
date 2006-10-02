Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWJBKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWJBKCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWJBKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:02:17 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:61620 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750702AbWJBKCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:02:16 -0400
Message-ID: <4520E3A6.7030907@s5r6.in-berlin.de>
Date: Mon, 02 Oct 2006 12:02:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 13
References: <20060928211920.GI5017@parisc-linux.org> <1159732857.3542.5.camel@mulgrave.il.steeleye.com> <20061001201753.GG16272@parisc-linux.org>
In-Reply-To: <20061001201753.GG16272@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Add ability to scan scsi busses asynchronously
> 
> Since it often takes around 20-30 seconds to scan a scsi bus, it's
> highly advantageous to do this in parallel with other things.  The bulk
> of this patch is ensuring that devices don't change numbering, and that
> all devices are discovered prior to trying to start init.  For those
> who build SCSI as modules, there's a new scsi_wait_scan module that will
> ensure all bus scans are finished.
> 
> This patch only handles drivers which call scsi_scan_host.  Fibre Channel,
> SAS, SATA, USB and Firewire all need additional work.

A note on FireWire/ SBP-2's status: We basically scan* asynchronously,
although the scans are serialized across all FireWire devices on all
buses. Parallelized scanning is on my long term to-do list. Serialized
scanning is actually quick enough unless something goes wrong.

Integration of sbp2 with scsi_wait_scan is now on my to-do list too. It
is orthogonal to parallelized scanning as a feature but probably
somewhat coupled when it comes to an actual implementation.

So far, the few people who have the root filesystem (or any other
filesystem that they want to have ready on boot) on an SBP-2 disk simply
put a sleep into their initrd or run a more or less complete hotplug
environment from initrd. The scsi_wait_scan module would certainly be
more comfortable than that.

[ *) "scan" = read ISO 13213 configuration ROMs, then run protocol
     driver probes including sbp2's login ]
-- 
Stefan Richter
-=====-=-==- =-=- ---=-
http://arcgraph.de/sr/
